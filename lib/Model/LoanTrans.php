<?php
class Model_LoanTrans extends Model_Table {
	public $entity_code = 'loantrans';

	function init() {
		parent::init();

		$this->addField('payrollperiod')->caption('Payroll Period');
		$this->addField('empid')->caption('Employee#')->editable(false);
		$this->addField('employees_id')->caption('Full Name')->refModel('Model_FullName')->displayField('fullname');
		$this->addField('loanfile_id')->caption('Loan Declaration')->refModel('Model_LoanFile')->displayField('loandesc');
		$this->addField('payamt')->type('money')->caption('Loan Payment');
		$this->addField('origpayrollperiod')->caption('Deferred From');
	}
}
