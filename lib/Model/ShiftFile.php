<?php
class Model_ShiftFile extends Model_Table {
	public $entity_code = 'shiftfile';

	function init() {
		parent::init();

		/*
		$this->addField('payrollperiod')->type('list')->caption('Payroll Period')
			->listData($this->api->sql->queryAllTableList
				('payrollperiod',null,'payrollperiodlist'));
		*/
		$this->addField('empid')->caption('Employee#')
			->editable(false);
		$this->addField('employees_id')->caption('Full Name')
			->required(true)
			->defaultValue($this->api->sql->queryOneTableField('id','employees'))
			->refModel('Model_FullName')->displayField('fullname');
		$this->addField('shifttable_id')->caption('Shift Schedule')
			->required(true)
			->refModel('Model_ShiftTable')->displayField('shiftdesc');
		$this->addField('restdays')->type('check')->caption('Rest Days')
			->listData(array(
				1 => 'Sunday',
				2 => 'Monday',
				3 => 'Tuesday',
				4 => 'Wednesday',
				5 => 'Thursday',
				6 => 'Friday',
				7 => 'Saturday'));
		$this->addField('startdate')->type('date')->caption('Start Date')
			->required(true)
			->defaultValue(date($this->api->getConfig('locale/date','d/m/Y')));
		$this->addField('enddate')->type('date')->caption('End Date')
			->required(true)
			->defaultValue(date($this->api->getConfig('locale/date','d/m/Y')));
		$this->addField('is_generated')->type('boolean')->caption('Generated?')
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

		if($data['enddate'] <= $data['startdate']){
			$this->owner->owner->js()->atk4_form('fieldError','enddate',
				'End date cannot be earlier than the start date')->execute();
			exit;
		}

		//if(empty($data['restdays'])){
		//	$rd=array();
		//	$r=$this->api->sql->queryOneTableRow('shifttable','id=%i',$data['shifttable_id']);
		//	for($i=1;$i<=7;$i++)
		//		if($r)
		//			$rd[]
		//}

		return parent::beforeModify($data);
	}

	function afterModify($id) {

		$this->api->sql->updateCrossTables(
			'shiftfile','empid','employees','empid',
				'x.employees_id=y.id AND x.id=%i',$id);

		$this->api->sql->updateOneTableField(
			'is_generated','N','shiftfile','id=%i',$id);

		return parent::afterModify($id);
	}

	function afterDelete($id) {

		$schedule = $this->api->sql->queryOneTableFieldsResource(
			'id','shifttrans','shiftfile_id=%i',$id);

		while($sched = $schedule->fetch_assoc()){
			$this->api->sql->update('timerectrans',array(
				'shifttrans_id'=>0,
				'trgroup'=>0,
				'trstatus'=>0,
				'is_processed'=>'N'
			),'id=%i',$sched['id']);

			$this->api->sql->delete('timereccalc',
				'shifttrans_id=%i',$sched['id']);
		}

		$this->api->sql->delete('shifttrans','shiftfile_id=%i',$id);

		$this->api->sql->delete('timereccalc','shiftfile_id=%i',$id);

		return parent::afterDelete($id);
	}

}
