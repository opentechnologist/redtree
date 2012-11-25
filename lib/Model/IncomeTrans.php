<?php
class Model_IncomeTrans extends Model_Table {
	public $entity_code = 'incometrans';

	function init() {
		parent::init();

		$this->addField('payrollperiod')->caption('Payroll Period');
		$this->addField('empid')->caption('Employee#')->editable(false);
		$this->addField('employees_id')->caption('Full Name')->refModel('Model_FullName')->displayField('fullname');
		$this->addField('incomefile_id')->caption('Description')->refModel('Model_IncomeFile')->displayField('incomedesc');
		$this->addField('payamt')->type('money')->caption('Received Income');
		$this->addField('origpayrollperiod')->caption('Deferred From');
	}
}
