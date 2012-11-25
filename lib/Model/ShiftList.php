<?php
class Model_ShiftList extends Model_Table {
	public $entity_code = 'shifttranslist';

	function init() {
		parent::init();

		$this->addField('empid')->caption('Employee#')
			->editable(false);
		$this->addField('employees_id')->caption('Full Name')
			->required(true)
			->defaultValue($this->api->sql->queryOneTableField('id','employees'))
			->refModel('Model_FullName')->displayField('fullname');
		$this->addField('shiftdesc')->caption('Description')
			->editable(false);
		$this->addField('timein')->type('datetime')->caption('Start of Shift')
			->required(true)
			->defaultValue(date($this->api->getConfig('locale/date','d/m/Y')));
		$this->addField('timeout')->type('datetime')->caption('End of Shift')
			->required(true)
			->defaultValue(date($this->api->getConfig('locale/date','d/m/Y')));
		$this->addField('shifttype')->caption('Type')
			->editable(false);
		//$this->addField('shiftstatus')->caption('Status')
		//	->editable(false);
	}
}
