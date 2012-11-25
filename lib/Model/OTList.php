<?php
class Model_OTList extends Model_Table {
	public $entity_code = 'ottablelist';

	function init() {
		parent::init();

		$this->addField('otdesc')->caption('Overtime Description');
		$this->addField('otrate')->type('real')->caption('Factor Rate');
	}
}
