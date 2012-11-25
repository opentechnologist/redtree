<?php
class Model_PayrollYTDList extends Model_Table {
	public $entity_code = 'payrollytdlist';

	function init() {
		parent::init();

		$this->addField('empid')->caption('Employee#');
		$this->addField('fullname')->caption('Full Name');

		$this->addField('workamt')->type('money')->caption('Basic Pay');
		$this->addField('lateamt')->type('money')->caption('Late Amount');
		$this->addField('absentamt')->type('money')->caption('Absent Amount');
		$this->addField('otamt')->type('money')->caption('OT Amount');

		$this->addField('incomeamt')->type('money')->caption('Other Income');
		$this->addField('deductamt')->type('money')->caption('Other Deduction');
		$this->addField('loanamt')->type('money')->caption('Loan Deduction');

		$this->addField('sssamt')->type('money')->caption('SSS Contribution');
		$this->addField('hdmfamt')->type('money')->caption('HDMF/PagIbig');
		$this->addField('phamt')->type('money')->caption('PhilHealth');
		$this->addField('taxamt')->type('money')->caption('Income Tax');
		$this->addField('grossamt')->type('money')->caption('Gross Amount');
		$this->addField('netamt')->type('money')->caption('Net Amount');

		$this->addField('fsyear')->type('list')->caption('Applicable Year')
			->listData(array(
				2011 => 2011,
				2012 => 2012,
				2013 => 2013,
				2014 => 2014,
				2015 => 2015));
	}
}
