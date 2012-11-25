<?php
class Model_ShiftRecord extends Model_Table {
	public $entity_code = 'shifttranslist';

	function init() {
		parent::init();

		$this->addField('empid')->caption('Employee#');
		$this->addField('employees_id')->caption('Full Name')->refModel('Model_FullName')->displayField('fullname');
		$this->addField('timein')->type('datetime')->caption('Start of Shift');
		$this->addField('timeout')->type('datetime')->caption('End of Shift');

		$this->addField('latemins')->type('int')->caption('Late (mins)');
		$this->addField('is_undertime')->type('boolean')->caption('Undertime?');
		$this->addField('is_latebreak')->type('boolean')->caption('Late Breaks?');
		$this->addField('is_absent')->type('boolean')->caption('Absent?');
		$this->addField('is_exception')->type('boolean')->caption('Exception?');
	}
}
