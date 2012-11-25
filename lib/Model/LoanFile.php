<?php
class Model_LoanFile extends Model_Table {
	public $entity_code = 'loanfile';

	function init() {
		parent::init();

		$this->addField('empid')->caption('Employee#')->editable(false);
		$this->addField('employees_id')->caption('Full Name')->refModel('Model_FullName')->displayField('fullname');
		$this->addField('filedate')->type('date')->caption('Loan Date');
		$this->addField('loantable_id')->caption('Type of Loan')->refModel('Model_LoanTable')->displayField('loandesc');
		$this->addField('loandesc')->caption('Description');
		$this->addField('loanamt')->type('money')->caption('Loaned Amount');
		$this->addField('amortization')->type('money')->caption('Amortization');
		$this->addField('startdate')->type('date')->caption('Start Date');
		$this->addField('is_active')->type('boolean')->caption('Active?');
	}

	function afterModify($id) {
		$this->api->sql->query("UPDATE loanfile x, employees e SET x.empid=e.empid WHERE TRIM(x.empid)='' AND x.employees_id=e.id AND x.id=%i",$id);
		return parent::afterModify($id);
	}
}
