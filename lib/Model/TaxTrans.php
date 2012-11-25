<?php
class Model_TaxTrans extends Model_Table {
	public $entity_code = 'taxtrans';

	function init() {
		parent::init();

		$this->addField('payrollperiod')->caption('Payroll Period');
		$this->addField('empid')->caption('Employee#')->editable(false);
		$this->addField('employees_id')->caption('Full Name')->refModel('Model_FullName')->displayField('fullname');
		$this->addField('taxstatuscode')->type('list')->capTion('Tax Status Code')
			->listData(array(
					'S'   => 'Single (with no dependents)',
					'ME'  => 'Married (without children)',
					'S1'  => 'Single with 1 dependent',
					'S2'  => 'Single with 2 dependent',
					'S3'  => 'Single with 3 dependent',
					'S4'  => 'Single with 4 dependent',
					'ME1' => 'Married with 1 child',
					'ME2' => 'Married with 2 children',
					'ME3' => 'Married with 3 children',
					'ME4' => 'Married with 4 children',
					'Z'   => 'Zero Exemption'));
		$this->addField('payperiod')->type('list')->caption('Pay Period')
			->listData(array('Monthly'=>'Monthly','Semi-Monthly'=>'Semi-Monthly','Weekly'=>'Weekly','Daily'=>'Daily','Annual'=>'Annual'));
		$this->addField('rangefrom')->type('money')->caption('Range from');
		$this->addField('rangeto')->type('money')->caption('Range to');
		$this->addField('exemption')->type('money')->caption('Exemption');
		$this->addField('dependents')->type('int')->captioN('Dependents');
		$this->addField('grossamt')->type('money')->caption('Gross Pay for this Period');
		$this->addField('fixedtaxableamt')->type('money')->caption('Fixed Taxable Amt');
		$this->addField('fixedtaxamt')->type('money')->caption('Fixed Tax Amt');
		$this->addField('percentofexcessamt')->type('real')->caption('Percent of Excess Amt');
		$this->addField('taxamt')->type('money')->caption('Income Tax Amount');
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
