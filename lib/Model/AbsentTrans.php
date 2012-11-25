<?php
class Model_AbsentTrans extends Model_Table {
	public $entity_code = 'absenttrans';

	function init() {
		parent::init();

		if($this->api->recall('payrollperiod'))
			$payrollperiods=$this->api->sql->queryAllTableList
				('payrollperiod','payrollperioddesc','payrollperiodlist',
					'payrollperiod=%s',$this->api->recall('payrollperiod'));
		else
			$payrollperiods=$this->api->sql->queryAllTableList
				('payrollperiod','payrollperioddesc','payrollperiodlist');

		$this->addField('payrollperiod')->type('list')->caption('Payroll Period')
			->listData($payrollperiods);
		$this->addField('empid')->caption('Employee#')
			->editable(false);
		$this->addField('employees_id')->caption('Full Name')
			->required(true)
			->defaultValue($this->api->sql->queryOneTableField('id','employees'))
			->refModel('Model_FullName')->displayField('fullname');
		$this->addField('absentdate')->type('date')->caption('Date')
			->defaultValue(date($this->api->getConfig('locale/date','d/m/Y')));
		$this->addField('absentdesc')->caption('Description/Reason');
		$this->addField('absentddhhmm')->caption('Absent [ddd:hh:mm]')
			->required(true)->length(6);
		$this->addField('absentamt')->type('money')->caption('Amount')
			->editable(false);
		$this->addField('absenttype')->type('list')->caption('Type')
			->listData(array('Absent'=>'Absent','Undertime'=>'Undertime'));
		$this->addField('is_manual')->type('boolean')->caption('Manual Entry?')
			->editable(false);
	}

	function beforeModify(&$data){
		if(empty($data['employees_id'])){
			$this->owner->owner->js()->atk4_form('fieldError','employees_id',
				'Select an employee from the list')->execute();
			exit;
		}

		if(empty($data['employees_id']))
			$data['employees_id']=$this->api->sql->queryOneTableField('id','employees');

		if(empty($data['empid']))
			$data['empid']=$this->api->sql->queryOneTableField
				('empid','employees','id=%i',$data['employees_id']);

		$ddhhmm = trim($data['absentddhhmm']);

		$hrsperday = 8; // work hours per day adjustment, FIXED to 8 as of the moment

		$f=array();$v=array();

		if(is_numeric($ddhhmm)){
			$ddhhmm*=1;
			if(empty($ddhhmm))
				$dd=$hh=$mm=0;
			else{
				if(is_float($ddhhmm)){
				if(!empty($ddhhmm)){$f[]=$this->dynamicDecimal
					($ddhhmm,5).'dys';$v[]=$ddhhmm;}
					$dd=intval($ddhhmm);
					$hh=$ddhhmm-$dd;
					$hh*=$hrsperday;
					//if(!empty($dd)){$f[]='%ddys';$v[]=$dd;}
					//if(!empty($hh)){$f[]='%dhrs';$v[]=$hh;}
					$mm=$hh-intval($hh);
					$hh=intval($hh);
					$mm=intval($mm*60);
				}else{
					$dd=intval($ddhhmm);
					$hh=$mm=0;
					$f[]='%ddys';
					$v[]=$dd;
				}
			}
		}elseif(strpos($ddhhmm,':')===false || count(split(':',$ddhhmm))<2)
				$dd=$hh=$mm=0;
		else{
			list($dd,$hh,$mm)=split(':',$ddhhmm);
			if(!empty($dd)){$f[]='%ddys';$v[]=$dd;}
			if(!empty($hh)){$f[]='%dhrs';$v[]=$hh;}
			if(!empty($mm)){$f[]='%dmns';$v[]=$mm;}
			$hh+=intval($mm/60);
			$mm=$mm%60;
			$dd+=intval($hh/$hrsperday);
			$hh=$hh%$hrsperday;
		}

		$f=join(' ',$f);
		$data['absentdesc'] .= sprintf("($f)",$v[0],$v[1],$v[2]);

		$ddhhmm=$dd.':'.$hh.':'.$mm;
		$data['absentddhhmm'] = $ddhhmm;

		return parent::beforeModify($data);
	}

	function afterModify($id) {

		$ddhhmm=$this->api->sql->queryOneTableField('absentddhhmm','absenttrans','id=%i',$id);
		list($dd,$hh,$mm)=split(':',$ddhhmm);

		$this->api->sql->updateOneTableFieldExpr(
			'absentddhhmm','MAKETIME(%i,%i,%i)','absenttrans','id=%i',$dd,$hh,$mm,$id);

		$this->api->sql->updateOneTableFieldExpr(
			'absentdays','DDHHMM2DAYS(absentddhhmm)','absenttrans','id=%i',$id);

		$this->api->sql->updateCrossTablesMultiFields(
			'absenttrans','empid,absentrate','employees','empid,dailyrate',
			'x.employees_id=y.id AND x.id=%i',$id);

		$this->api->sql->updateOneTableFieldExpr(
			'absentamt','%f*%f','absenttrans','id=%i','absentrate','absentdays',$id);

		return parent::afterModify($id);
	}

	function dynamicDecimal($x,$n){ // DynamicDecimalPlaces
		$s=number_format($x,$n);
		$i=strlen($s)-$n;
		$s=preg_replace('/\.*0+$/','',$s);
		$i=strlen($s)-$i;
		$s=$i<0?'%d':'%01.'.$i.'f';
		return $s;
	}

}
