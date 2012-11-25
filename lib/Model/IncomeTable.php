<?php
class Model_IncomeTable extends Model_Table {
	public $entity_code = 'incometable';

	function init() {
		parent::init();

		$this->addField('incomedesc')->caption('Description');
		$this->addField('frequency')->type('list')->caption('Frequency')
			->listData(array('Recurring'=>'Recurring','One-Time'=>'One-Time'));
		$this->addField('is_taxable')->type('boolean')->caption('Taxable?');
		$this->addField('acctcode')->caption('Account Code');
		$this->addField('contraacct')->caption('Contra Account Code');
		$this->addField('normalbal')->type('list')->caption('Normal Balance')
			->listData(array('Debit'=>'Debit','Credit'=>'Credit'));
	}
}
