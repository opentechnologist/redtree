<?php
class Model_LoanTable extends Model_Table {
	public $entity_code = 'loantable';

	function init() {
		parent::init();

		$this->addField('loandesc')->caption('Loan Description');
		$this->addField('acctcode')->type('list')->caption('Account Code');
		$this->addField('contraacct')->caption('Contra Account Code');
		$this->addField('normalbal')->type('list')->caption('Normal Balance')
			->listData(array('Debit'=>'Debit','Credit'=>'Credit'));
	}
}
