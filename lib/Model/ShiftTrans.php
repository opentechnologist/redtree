<?php
class Model_ShiftTrans extends Model_Table {
	public $entity_code = 'shifttrans';

	function init() {
		parent::init();

		$this->addField('empid')->caption('Employee#')
			->editable(false);
		$this->addField('employees_id')->caption('Full Name')
			->required(true)
			->defaultValue($this->api->sql->queryOneTableField('id','employees'))
			->refModel('Model_FullName')->displayField('fullname');
		$this->addField('shifttable_id')->caption('Shift Schedule')
			->required(true)
			->refModel('Model_ShiftTable')->displayField('shiftdesc');
		$this->addField('shiftdate')->type('date')->caption('Date')
			->required(true)
			->defaultValue(date($this->api->getConfig('locale/date','d/m/Y')));
		$this->addField('shifttype')->caption('Type')
			->editable(false);
	}
}
