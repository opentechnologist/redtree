<?php
class Model_TaxStatus extends Model_Table {
	public $entity_code = 'taxstatustable';

	function init() {
		parent::init();

		$this->addField('taxstatuscode')->caption('Status Code');
		$this->addField('taxstatusdesc')->caption('Tax Status Description');
		$this->addField('personalexemption')->type('money')->caption('Personal Exemption');
		$this->addField('additionalexemption')->type('money')->caption('Additional Exemption for Dependents');
	}
}
