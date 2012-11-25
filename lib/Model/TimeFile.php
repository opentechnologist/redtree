<?php
class Model_TimeFile extends Model_Table {
	public $entity_code = 'timereccalc';

	function init() {
		parent::init();

		$this->addField('empid')->type('readonly')->caption('Employee#')->editable(false);
		$this->addField('employees_id')->caption('Full Name')->editable(false)
			->refModel('Model_FullName')->displayField('fullname');
		$this->addField('timerecdt')->type('date')->caption('Date');

		$this->addField('calcmins')->type('int')->caption('In Mins');
		$this->addField('calchrs')->type('int')->caption('In Hours')->editable(false);
		$this->addField('calctag')->type('list')->caption('Flag')//->caption('Tag')
			->listData(array(
				0=>'Unprocessed',
				1=>'Late',
				2=>'Undertime',
				3=>'Absent',
				4=>'Overtime',
				99=>'Exception'
				));
		
		//$this->setOrder(null,'id');
	}
}
