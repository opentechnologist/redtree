<?php
class Model_TaxYTDFile extends Model_Table {
	public $entity_code = 'taxytdfile';

	function init() {
		parent::init();

		$this->addField('empid')->caption('Employee#');
		$this->addField('employees_id')->caption('Full Name')->refModel('Model_FullName')->displayField('fullname');

		$this->addField('taxstatuscode')->caption('Tax Status');
		$this->addField('payperiod')->caption('Pay Period');
		$this->addField('dependents')->caption('Dependents');

		$this->addField('exemption')->type('money')->caption('Total Exemption');
		$this->addField('grossamt')->type('money')->caption('Taxable Income');
		$this->addField('taxamt')->type('money')->caption('Withholding/Income Tax');
		$this->addField('refundamt')->type('money')->caption('Refundable Amount');

		$this->addField('fsyear')->type('list')->caption('Applicable Year')
			->listData(array(
				2011 => 2011,
				2012 => 2012,
				2013 => 2013,
				2014 => 2014,
				2015 => 2015));
	}
}
