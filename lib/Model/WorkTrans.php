<?php
class Model_WorkTrans extends Model_Table {
	public $entity_code = 'worktrans';

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
		$this->addField('workdate')->type('date')->caption('Date')
			->defaultValue(date($this->api->getConfig('locale/date','d/m/Y')));
		$this->addField('workdesc')->caption('Description/Reason');
		$this->addField('workrate')->type('real')->caption('Rate [default:1]')
			->defaultValue(1.00)
			->required(true)->length(12);
		$this->addField('workhhmm')->caption('Work [hhh:mm]')
			->required(true)->length(6);
		$this->addField('workamt')->type('money')->caption('Amount')
			->editable(false);
		$this->addField('worktype')->type('list')->caption('Type')
			->listData(array('Regular Work'=>'Regular Work','Special Work'=>'Special Work'));
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

		$hhmm = trim($data['workhhmm']);
		$f=array();$v=array();

		if(is_numeric($hhmm)){
			$hhmm*=1;
			if(empty($hhmm))
					$hh=$mm=0;
			else{
				if(is_float($hhmm)){
					if(!empty($hhmm)){$f[]=	$this->dynamicDecimal
						($hhmm,5).'hrs';$v[]=$hhmm;}
					$hh=intval($hhmm);
					$mm=$hhmm*60;
					$mm=$mm-($hh*60);
					$mm=intval($mm);
				}else{
						if(!empty($hhmm)){$f[]='%dhrs';$v[]=$hhmm;}
						$hh=intval($hhmm);
						$mm=0;
				}
			}
		}elseif(strpos($hhmm,':')===false || count(split(':',$hhmm))<>2)
			$hh=$mm=0;
		else{
			list($hh,$mm)=split(':',$hhmm);
			if(!empty($hh)){$f[]='%dhrs';$v[]=$hh;}
			if(!empty($mm)){$f[]='%dmns';$v[]=$mm;}
			$hh+=intval($mm/60);
			$mm=$mm%60;
		}

		$f=join(' ',$f);
		$data['workdesc'] .= sprintf("($f)",$v[0],$v[1]);

		$hhmm=$hh.':'.$mm;
		$data['workhhmm'] = $hhmm;

		return parent::beforeModify($data);
	}

	function afterModify($id) {

		$hhmm=$this->api->sql->queryOneTableField('workhhmm','worktrans','id=%i',$id);
		list($hh,$mm)=split(':',$hhmm);

		$this->api->sql->updateOneTableFieldExpr(
			'workhhmm','LEFT(MAKETIME(%i,%i,0),%i)','worktrans','id=%i',
				$hh,$mm,$hh>99?6:5,$id);

		$this->api->sql->updateOneTableFieldExpr(
			'workmins','HHMM2MINS(workhhmm)','worktrans','id=%i',$id);

		$this->api->sql->updateCrossTablesMultiFields(
			'worktrans','empid,hourlyrate','employees','empid,hourlyrate',
			'x.employees_id=y.id AND x.id=%i',$id);

		$this->api->sql->updateOneTableFieldExpr(
			'workamt','%f*%f*(%f/60)','worktrans','id=%i',
				'hourlyrate','workrate','workmins',$id);

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
