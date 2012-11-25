<?php
class Model_SSSTable extends Model_Table {
	public $entity_code = 'ssstable';

	function init() {
		parent::init();

		$this->addField('rangefrom')->type('money')->caption('Range from');
		$this->addField('rangeto')->type('money')->caption('Range to');
		$this->addField('salarycredit')->type('money')->caption('Salary Credit');
		$this->addField('employershareamt')->type('money')->caption('Employer Share');
		$this->addField('employerecshareamt')->type('money')->caption('Employer EC Share');
		$this->addField('employeeshareamt')->type('money')->caption('Employee Share');
	}
}
