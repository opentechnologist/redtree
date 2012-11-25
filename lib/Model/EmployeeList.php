<?php
class Model_EmployeeList extends Model_Table {
	public $entity_code = 'employeelist';

	function init() {
		parent::init();

		$this->addField('empid')->caption('Employee#')->editable(false);
		$this->addField('empname')->caption('Full Name');
	}
}
