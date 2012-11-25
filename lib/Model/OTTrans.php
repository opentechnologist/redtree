<?php
class Model_OTTrans extends Model_Table {
	public $entity_code = 'ottrans';

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
		$this->addField('otdate')->type('date')->caption('Date')
			->defaultValue(date($this->api->getConfig('locale/date','d/m/Y')));
		$this->addField('ottable_id')->caption('Overtime Type')
			//->refModel('Model_OTTable')->displayField('otdesc');
			->refModel('Model_OTList')->displayField('otdesc');
		$this->addField('otdesc')->caption('Description/Reason');
		$this->addField('othhmm')->caption('Overtime [hhh:mm]')
			->required(true)->length(6);
		$this->addField('otamt')->type('money')->caption('Amount')
			->editable(false);
		$this->addField('otfile_id')->caption('Filed Reference')
			->defaultValue(0)
			->visible(false) // goes hand-in-hand with refModel(~,~,false)
			->refModel('Model_OTFile',true,false)->displayField('otdesc');
		$this->addField('is_manual')->type('boolean')->caption('Manual Entry?')
			->editable(false);
	}

	function beforeModify(&$data){
		if(empty($data['employees_id'])){
			$this->owner->owner->js()->atk4_form('fieldError','employees_id',
				'Select an employee from the list')->execute();
			exit;
		}

		if(empty($data['ottable_id'])){
			$this->owner->owner->js()->atk4_form('fieldError','ottable_id',
				'Select an overtime type from the list')->execute();
			exit;
		}

		if(empty($data['employees_id']))
			$data['employees_id']=$this->api->sql->queryOneTableField('id','employees');

		if(empty($data['empid']))
			$data['empid']=$this->api->sql->queryOneTableField
				('empid','employees','id=%i',$data['employees_id']);

		$hhmm = trim($data['othhmm']);
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
		$data['otdesc'] .= sprintf("($f)",$v[0],$v[1]);

		$hhmm=$hh.':'.$mm;
		$data['othhmm'] = $hhmm;

		return parent::beforeModify($data);
	}

	function afterModify($id) {

		$hhmm=$this->api->sql->queryOneTableField('othhmm','ottrans','id=%i',$id);
		list($hh,$mm)=split(':',$hhmm);

		$this->api->sql->updateOneTableFieldExpr(
			'othhmm','LEFT(MAKETIME(%i,%i,0),%i)','ottrans','id=%i',
				$hh,$mm,$hh>99?6:5,$id);

		$this->api->sql->updateOneTableFieldExpr(
			'otmins','HHMM2MINS(othhmm)','ottrans','id=%i',$id);

		$this->api->sql->updateCrossTablesMultiFields(
			'ottrans','empid,hourlyrate','employees','empid,hourlyrate',
				'x.employees_id=y.id AND x.id=%i',$id);

		$this->api->sql->updateCrossTables(
			'ottrans','otrate','ottable','otrate',
				'x.ottable_id=y.id AND x.id=%i',$id);

		$this->api->sql->updateOneTableFieldExpr(
			'otamt','%f*%f*(%f/60)','ottrans','id=%i',
				'hourlyrate','otrate','otmins',$id);

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
