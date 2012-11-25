<?php
class Model_GeneratePayroll extends Model_Table {
	public $entity_code = 'payrollperiodtable';

	function init() {
		parent::init();

		$this->addField('payrollperiod')->caption('Payroll Period');
		$this->addField('payrolldesc')->caption('Description');
		$this->addField('payperiodtable_id')->caption('Pay Period')->refModel('Model_PayPeriod')->displayField('payperiod');
		$this->addField('startdate')->type('date')->caption('Coverage Date From');
		$this->addField('enddate')->type('date')->caption('Coverage Date To');
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
		$this->addField('is_generated')->type('boolean')->caption('Generated?');
		$this->addField('is_closed')->type('boolean')->caption('Closed?');
	}
}
