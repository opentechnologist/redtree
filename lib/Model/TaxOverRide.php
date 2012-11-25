<?php
class Model_TaxOverRide extends Model_Table {
	public $entity_code = 'taxoverride';

	function init() {
		parent::init();

		$this->addField('empid')->caption('Employee#')->editable(false);
		$this->addField('fullname')->caption('Full Name');
		$this->addField('is_override')->type('boolean')->caption('Override?');
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
		$this->addField('dependents')->type('int')->caption('Dependents');
		$this->addField('fixedtaxableamt')->type('money')->caption('Fixed Taxable Amt');
		$this->addField('fixedtaxamt')->type('money')->caption('Fixed Tax Amt');
		$this->addField('percentofexcessamt')->type('real')->caption('Percent of Excess Amt');
	}
}
