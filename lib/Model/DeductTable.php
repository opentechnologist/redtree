<?php
class Model_DeductTable extends Model_Table {
	public $entity_code = 'deducttable';

	function init() {
		parent::init();

		$this->addField('deductdesc')->caption('Description');
		$this->addField('frequency')->type('list')->caption('Frequency')
			->listData(array('Recurring'=>'Recurring','One-Time'=>'One-Time'));
		$this->addField('acctcode')->caption('Account Code');
		$this->addField('contraacct')->caption('Contra Account Code');
		$this->addField('normalbal')->type('list')->caption('Normal Balance')
			->listData(array('Debit'=>'Debit','Credit'=>'Credit'));
	}
}
