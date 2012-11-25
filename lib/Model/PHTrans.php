<?php
class Model_PHTrans extends Model_Table {
	public $entity_code = 'phtrans';

	function init() {
		parent::init();

		$this->addField('payrollperiod')->caption('Payroll Period');
		$this->addField('empid')->caption('Employee#')->editable(false);
		$this->addField('employees_id')->caption('Full Name')->refModel('Model_FullName')->displayField('fullname');
		$this->addField('grossamt')->type('money')->caption('Gross Pay for this Period');
		$this->addField('rangefrom')->type('money')->caption('Range from');
		$this->addField('rangeto')->type('money')->caption('Range to');
		$this->addField('salarycredit')->type('money')->caption('Salary Credit');
		$this->addField('employershareamt')->type('money')->caption('Employer Share');
		$this->addField('employeeshareamt')->type('money')->caption('Employee Share');
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
