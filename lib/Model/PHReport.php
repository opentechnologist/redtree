<?php
class Model_PHReport extends Model_Table {
	public $entity_code = 'phreport';

	function init() {
		parent::init();

		$this->addField('empid')->caption('Employee#');
		$this->addField('fullname')->caption('Full Name');
		$this->addField('ph_no')->caption('PhilHealth#');
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
