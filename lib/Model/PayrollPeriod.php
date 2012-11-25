<?php
class Model_PayrollPeriod extends Model_Table {
	public $entity_code = 'payrollperiodtable';

	function init() {
		parent::init();

		$this->addField('payrollperiod')->caption('Payroll Period');
		$this->addField('payrolldesc')->caption('Description');
		$this->addField('payperiodtable_id')->caption('Pay Period')->refModel('Model_PayPeriod')->displayField('payperiod');
		$this->addField('startdate')->type('date')->caption('Coverage Date From');
		$this->addField('enddate')->type('date')->caption('Coverage Date To');
		$this->addField('fsmonth')->type('dropdown')->caption('Applicable Month')
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
			/*->listData(array(
				 1 => 'January',
				 2 => 'February',
				 3 => 'March',
				 4 => 'April',
				 5 => 'May',
				 6 => 'June',
				 7 => 'July',
				 8 => 'August',
				 9 => 'September',
				10 => 'October',
				11 => 'November',
				12 => 'December'));*/
		$this->addField('fsyear')->type('dropdown')->caption('Applicable Year')
			->listData(array(
				2011 => 2011,
				2012 => 2012,
				2013 => 2013,
				2014 => 2014,
				2015 => 2015));
		$this->addField('partno')->type('dropdown')->caption('Part No')
			->listData(array(
				1 => '1st Part',
				2 => '2nd Part',
				3 => '3th Part',
				4 => '4th Part',
				5 => '5th Part',
				6 => '6th Part',
				7 => '7th Part',
				8 => '8th Part'));
		$this->addField('totalparts')->type('dropdown')->caption('Total Parts')
			->listData(array(
				1 => '1 Pay Period Parts',
				2 => '2 Pay Period Parts',
				3 => '3 Pay Period Parts',
				4 => '4 Pay Period Parts',
				5 => '5 Pay Period Parts',
				6 => '6 Pay Period Parts',
				7 => '7 Pay Period Parts',
				8 => '8 Pay Period Parts'));
		$this->addField('deductsss')->type('dropdown')->caption('Deduct SSS')
			->listData(array(
				0 => 'No',
				1 => 'Yes (Partial Adjusted)',
				2 => 'Yes (Full Retro)'));
		$this->addField('deducthdmf')->type('dropdown')->caption('Deduct HDMF')
			->listData(array(
				0 => 'No',
				1 => 'Yes (Partial Adjusted)',
				2 => 'Yes (Full Retro)'));
		$this->addField('deductph')->type('dropdown')->caption('Deduct Phil Health')
			->listData(array(
				0 => 'No',
				1 => 'Yes (Partial Adjusted)',
				2 => 'Yes (Full Retro)'));
		$this->addField('deductothers')->type('dropdown')->caption('Other Deductions')
			->listData(array(
				0 => 'No',
				1 => 'Yes (Partial Adjusted)',
				2 => 'Yes (Full Retro)'));
		$this->addField('deductwtax')->type('dropdown')->caption('Deduct Income Tax')
			->listData(array(
				0 => 'No',
				1 => 'Yes (Partial Adjusted)',
				2 => 'Yes (Full Retro)'));
		$this->addField('earnleaves')->type('dropdown')->caption('Earn Leave Credits')
			->listData(array(
				0 => 'No',
				1 => 'Yes (Partial)',
				2 => 'Yes (Full)'));
		$this->addField('nthmonthpay')->type('dropdown')->caption('Nth Month Pay')
			->listData(array(
				0 => 'No',
				13 => '13th Month Pay',
				14 => '14th Month Pay',
				15 => '15th Month Pay',
				16 => '16th Month Pay',
				17 => '17th Month Pay',
				18 => '18th Month Pay'));
		$this->addField('is_generated')->type('boolean')->caption('Generated?');
		$this->addField('is_closed')->type('boolean')->caption('Closed?');
	}
}
