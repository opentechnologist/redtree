<?php
class page_ytdlist extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		$tab = $this->add('Tabs');
		$obj = $tab->addTab('YTD Payroll Register')->add('MVCGrid')->setModel('PayrollYTDList');
		if($obj->owner)
			$obj->owner->addPaginator(10);
		$obj = $tab->addTab('AlphaList')->add('MVCGrid')->setModel('TaxYTDFile');
		if($obj->owner){
			$obj->owner->addButton('Recalculate');
			$obj->owner->addPaginator(10);
		}
	}
}
