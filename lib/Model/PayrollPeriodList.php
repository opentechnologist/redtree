<?php
class Model_PayrollPeriodList extends Model_Table {
	public $entity_code = 'payrollperiodlist';

	function init() {
		parent::init();

		$this->addField('payrollperiod')->caption('Payroll Period');
		$this->addField('payrollperioddesc')->caption('Description');
	}
}
