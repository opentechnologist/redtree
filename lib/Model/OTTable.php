<?php
class Model_OTTable extends Model_Table {
	public $entity_code = 'ottable';

	function init() {
		parent::init();

		$this->addField('otdesc')->caption('Overtime Description');
		$this->addField('otrate')->type('real')->caption('Factor Rate');
		$this->addField('acctcode')->caption('Account Code');
		$this->addField('contraacct')->caption('Contra Account Code');
		$this->addField('normalbal')->type('list')->caption('Normal Balance')
			->listData(array('Debit'=>'Debit','Credit'=>'Credit'));
	}
}
