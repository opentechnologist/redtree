<?php
class Model_PayPeriod extends Model_Table {
	public $entity_code = 'payperiodtable';

	function init() {
		parent::init();

		$this->addField('payperiod')->capTion('Pay Period');
		$this->addField('paydays')->type('int')->caption('No of Pay Days per Year');
	}
}
