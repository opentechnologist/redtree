<?php
class Model_Employee extends Model_Table {
	public $entity_code = 'employees';

	function init() {
		parent::init();

		$this->addField('empid')->caption('Employee#');
		$this->addField('firstname')->caption('First Name');
		$this->addField('middlename')->caption('Middle Name');
		$this->addField('lastname')->caption('Last Name');
		$this->addField('position')->caption('Position');
		$this->addField('depttable_id')->caption('Department')->refModel('Model_Department')->displayField('deptdesc');
		$this->addField('paytype')->type('list')->caption('Pay Type')
			->listData(array('Salary'=>'Salary','Weekly'=>'Weekly','Daily'=>'Daily','Hourly'=>'Hourly'));
		$this->addField('taxstatustable_id')->caption('Tax Status')->refModel('Model_TaxStatus')->displayField('taxstatusdesc');
		$this->addField('payperiodtable_id')->caption('Pay Period')->refModel('Model_PayPeriod')->displayField('payperiod');
		$this->addField('empstatustable_id')->caption('Employee Status')->refModel('Model_EmpStatus')->displayField('empstatus');
		$this->addField('atm_no')->caption('ATM#');
		$this->addField('sss_no')->caption('SSS#');
		$this->addField('hdmf_no')->caption('HDMF#');
		$this->addField('ph_no')->caption('Philhealth');
		$this->addField('tin_no')->caption('TIN#');
		$this->addField('basicpay')->type('money')->caption('Basic Pay');
		$this->addField('dailyrate')->type('money')->caption('Daily Rate');
		$this->addField('hourlyrate')->type('money')->caption('Hourly Rate');
		$this->addField('timerecid')->type('int')->caption('Time Recorder#')->defaultValue(0);
		$this->addField('is_active')->type('boolean')->caption('Active?')->defaultValue(true);
	}
}
