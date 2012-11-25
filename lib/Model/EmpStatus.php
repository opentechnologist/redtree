<?php
class Model_EmpStatus extends Model_Table {
	public $entity_code = 'empstatustable';

	function init() {
		parent::init();

		$this->addField('empstatus')->caption('Employment Status');
	}
}
