<?php
class Model_LateTrans extends Model_Table {
	public $entity_code = 'latetrans';

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
		$this->addField('latedate')->type('date')->caption('Date')
			->defaultValue(date($this->api->getConfig('locale/date','d/m/Y')));
		$this->addField('latedesc')->caption('Description/Reason');
		$this->addField('latehhmm')->caption('Late [hhh:mm]')
			->required(true)->length(6);
		$this->addField('lateamt')->type('money')->caption('Amount')
			->editable(false);
		$this->addField('latetype')->type('list')->caption('Type')
			->listData(array('Late'=>'Late','Undertime'=>'Undertime'));
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

		$hhmm = trim($data['latehhmm']);
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
						if(!empty($hhmm)){$f[]='%dmns';$v[]=$hhmm;}
						$hh=intval($hhmm/60);
						$mm=$hhmm%60;
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
		$data['latedesc'] .= sprintf("($f)",$v[0],$v[1]);

		$hhmm=$hh.':'.$mm;
		$data['latehhmm'] = $hhmm;

		return parent::beforeModify($data);
	}

	function afterModify($id) {

		$hhmm=$this->api->sql->queryOneTableField('latehhmm','latetrans','id=%i',$id);
		list($hh,$mm)=split(':',$hhmm);

		$this->api->sql->updateOneTableFieldExpr(
			'latehhmm','LEFT(MAKETIME(%i,%i,0),%i)','latetrans','id=%i',
				$hh,$mm,$hh>99?6:5,$id);

		$this->api->sql->updateOneTableFieldExpr(
			'latemins','HHMM2MINS(latehhmm)','latetrans','id=%i',$id);

		$this->api->sql->updateCrossTablesMultiFields(
			'latetrans','empid,laterate','employees','empid,hourlyrate',
			//'TRIM(x.empid)=%s AND x.employees_id=y.id AND x.id=%i','',$id);
			'x.employees_id=y.id AND x.id=%i',$id);

		$this->api->sql->updateOneTableFieldExpr(
			'lateamt','%f*(%f/60)','latetrans','id=%i','laterate','latemins',$id);

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
