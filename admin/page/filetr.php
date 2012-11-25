<?php
class page_filetr extends Page {
	var $grid = array();

	function init() {
		parent::init();
		$this->api->auth->check();

		$tab = $this->add('Tabs');
		// ** $obj = $tab->addTab('Overtime Application')->set('Undergoing Customization');
		$subtab = $tab->addTabURL('incometr','Other Income');
		$subtab = $tab->addTabURL('deducttr','Other Deductions');
		$subtab = $tab->addTabURL('loantr','Loan Transactions');
	}
}
