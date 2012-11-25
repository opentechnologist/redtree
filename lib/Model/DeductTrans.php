<?php
class Model_DeductTrans extends Model_Table {
	public $entity_code = 'deducttrans';

	function init() {
		parent::init();

		$this->addField('payrollperiod')->caption('Payroll Period');
		$this->addField('empid')->caption('Employee#')->editable(false);
		$this->addField('employees_id')->caption('Full Name')->refModel('Model_FullName')->displayField('fullname');
		$this->addField('deductfile_id')->caption('Description')->refModel('Model_DeductFile')->displayField('deductdesc');
		$this->addField('payamt')->type('money')->caption('Deducted Amount');
		$this->addField('origpayrollperiod')->caption('Deferred From');
	}
}
