<?php
class Model_ShiftFileList extends Model_Table {
	public $entity_code = 'shiftfilelist';

	function init() {
		parent::init();

		$this->addField('empid')->caption('Employee#')
			->editable(false);
		$this->addField('employees_id')->caption('Full Name')
			->refModel('Model_FullName')->displayField('fullname');
		$this->addField('shifttable_id')->caption('Shift Schedule')
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
		$this->addField('startdate')->type('date')->caption('Start Date');
		$this->addField('enddate')->type('date')->caption('End Date');
	}
}
