<?php
class Model_SSSOverRide extends Model_Table {
	public $entity_code = 'sssoverride';

	function init() {
		parent::init();

		$this->addField('empid')->caption('Employee#')->editable(false);
		$this->addField('fullname')->caption('Full Name');
		$this->addField('is_override')->type('boolean')->caption('Override?');
		$this->addField('rangefrom')->type('money')->caption('Range from');
		$this->addField('rangeto')->type('money')->caption('Range to');
		$this->addField('salarycredit')->type('money')->caption('Salary Credit');
		$this->addField('employershareamt')->type('money')->caption('Employer Share');
		$this->addField('employerecshareamt')->type('money')->caption('Employer EC Share');
		$this->addField('employeeshareamt')->type('money')->caption('Employee Share');
	}
}
