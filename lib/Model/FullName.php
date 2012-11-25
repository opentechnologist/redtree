<?php
class Model_FullName extends Model_Table {
	public $entity_code = 'empname';

	function init() {
		parent::init();

		$this->addField('empid')->caption('Employee#');
		$this->addField('fullname')->caption('Full Name');
	}
}
