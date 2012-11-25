<?php
class page_paylist extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		$tab = $this->add('Tabs');
		$obj = $tab->addTab('Payroll Register')->add('MVCGrid')->setModel('PayrollTrans');
		if($obj->owner)
			$obj->owner->addPaginator(10);
		$obj = $tab->addTab('Over the Counter Listing')->add('MVCGrid')->setModel('PayrollOTCList');
		if($obj->owner)
			$obj->owner->addPaginator(10);
		$obj = $tab->addTab('Bank Transmittal')->add('MVCGrid')->setModel('PayrollATMList');
		if($obj->owner)
			$obj->owner->addPaginator(10);
	}
}
