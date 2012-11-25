<?php
class Model_DeductFile extends Model_Table {
	public $entity_code = 'deductfile';

	function init() {
		parent::init();

		$this->addField('empid')->caption('Employee#')->editable(false);
		$this->addField('employees_id')->caption('Full Name')->refModel('Model_FullName')->displayField('fullname');
		$this->addField('filedate')->type('date')->caption('File Date');
		$this->addField('deducttable_id')->caption('Reference')->refModel('Model_DeductTable')->displayField('deductdesc');
		$this->addField('deductdesc')->caption('Description');
		$this->addField('payamt')->type('money')->caption('Amount for Deduction');
		$this->addField('startdate')->type('date')->caption('Start Date');
		$this->addField('is_active')->type('boolean')->caption('Active?');
	}

	function afterModify($id) {
		$this->api->sql->query("UPDATE deductfile x, employees e SET x.empid=e.empid WHERE TRIM(x.empid)='' AND x.employees_id=e.id AND x.id=%i",$id);
		return parent::afterModify($id);
	}
}
