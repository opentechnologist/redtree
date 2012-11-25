<?php
class Model_PayrollTrans extends Model_Table {
	public $entity_code = 'payrolltrans';

	function init() {
		parent::init();

		$this->addField('payrollperiod')->caption('Payroll Period');
		$this->addField('empid')->caption('Employee#')->editable(false);
		$this->addField('employees_id')->caption('Full Name')->refModel('Model_FullName')->displayField('fullname');
		$this->addField('basicpay')->type('money')->caption('Basic Pay');

		$this->addField('latehrs')->type('real')->caption('Hours Late');
		$this->addField('lateamt')->type('money')->caption('Late Amount');

		$this->addField('absentdays')->type('real')->caption('Days Absent');
		$this->addField('absentamt')->type('money')->caption('Absent Amount');

		$this->addField('othrs')->type('real')->caption('Hours OT');
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

		$this->addField('fsmonth')->type('list')->caption('Applicable Month')
			->listData(array(
				 1 => 'Jan',
				 2 => 'Feb',
				 3 => 'Mar',
				 4 => 'Apr',
				 5 => 'May',
				 6 => 'Jun',
				 7 => 'Jul',
				 8 => 'Aug',
				 9 => 'Sep',
				10 => 'Oct',
				11 => 'Nov',
				12 => 'Dec'));
		$this->addField('fsyear')->type('list')->caption('Applicable Year')
			->listData(array(
				2011 => 2011,
				2012 => 2012,
				2013 => 2013,
				2014 => 2014,
				2015 => 2015));
	}
}
