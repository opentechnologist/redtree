<?php
class page_filed extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		$tabs = $this->add('Tabs');

		$obj = $tabs->addTab('Loan Declarations')->add('CRUD')->setModel('LoanFile');
		$obj = $tabs->addTab('Filed Other Incomes')->add('CRUD')->setModel('IncomeFile');
		$obj = $tabs->addTab('Filed Other Deductions')->add('CRUD')->setModel('DeductFile');
		// ** $obj = $tabs->addTab('Leave Credits Allocation')->set('Undergoing Customization');
	}
}
