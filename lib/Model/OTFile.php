<?php
class Model_OTFile extends Model_Table {
	public $entity_code = 'otfile';

	function init() {
		parent::init();

		$this->addField('fileref')->caption('Reference#');
		$this->addField('filedate')->type('date')->caption('Applicable Date');
		$this->addField('empid')->caption('Employee#')->editable(false);
		$this->addField('employees_id')->caption('Full Name')->refModel('Model_FullName')->displayField('fullname');
		$this->addField('ottable_id')->caption('Overtime Reference')->refModel('Model_OTTable')->displayField('otdesc');
		$this->addField('otdesc')->caption('Description/Reason');
		$this->addField('othrs')->type('real')->caption('Hours');
		$this->addField('otamt')->type('money')->caption('Amount');
	}
}
