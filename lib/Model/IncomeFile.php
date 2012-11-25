<?php
class Model_IncomeFile extends Model_Table {
	public $entity_code = 'incomefile';

	function init() {
		parent::init();

		$this->addField('empid')->caption('Employee#')->editable(false);
		$this->addField('employees_id')->caption('Full Name')->refModel('Model_FullName')->displayField('fullname');
		$this->addField('filedate')->type('date')->caption('File Date')->defaultValue(date('Y-m-d'));
		$this->addField('incometable_id')->caption('Reference')->refModel('Model_IncomeTable')->displayField('incomedesc');
		$this->addField('incomedesc')->caption('Description');
		$this->addField('payamt')->type('money')->caption('Additional Income');
		$this->addField('startdate')->type('date')->caption('Start Date');
		$this->addField('is_active')->type('boolean')->caption('Active?');
	}

	function afterModify($id) {
		$this->api->sql->query("UPDATE incomefile x, employees e SET x.empid=e.empid WHERE TRIM(x.empid)='' AND x.employees_id=e.id AND x.id=%i",$id);
		return parent::afterModify($id);
	}
}
