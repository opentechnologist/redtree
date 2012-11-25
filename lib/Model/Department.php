<?php
class Model_Department extends Model_Table {
	public $entity_code = 'depttable';

	function init() {
		parent::init();

		$this->addField('deptdesc')->caption('Department');
	}
}
