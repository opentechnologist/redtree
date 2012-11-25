<?php
class page_govtlist extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		$tab = $this->add('Tabs');
		//$obj = $tab->add('Form')->addButton('Button')->set('Print');
		$obj = $tab->addTab('SSS Monthly Remittance')->add('MVCGrid')->setModel('SSSReport');
		if($obj->owner)
			$obj->owner->addPaginator(10);
		$obj = $tab->addTab('HDMF Monthly Remittance')->add('MVCGrid')->setModel('HDMFReport');
		if($obj->owner)
			$obj->owner->addPaginator(10);
		$obj = $tab->addTab('Philhealth Monthly Remittance')->add('MVCGrid')->setModel('PHReport');
		if($obj->owner)
			$obj->owner->addPaginator(10);
		$obj = $tab->addTab('Monthly Tax Return')->add('MVCGrid')->setModel('TaxReport');
		if($obj->owner)
			$obj->owner->addPaginator(10);
	}
}
