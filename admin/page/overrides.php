<?php
class page_overrides extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		$tab = $this->add('Tabs');
		$obj = $tab->addTabURL('sssor','SSS Contribution Override');
		$obj = $tab->addTabURL('hdmfor','Pagibig/HDMF Override');
		$obj = $tab->addTabURL('phor','PhilHealth Override' );
		$obj = $tab->addTabURL('taxor','Withholding/Income Tax Override');
	}
}
