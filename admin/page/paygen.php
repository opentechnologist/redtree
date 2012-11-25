<?php
class page_paygen extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		$tabs = $this->add('Tabs');
		$subtab = $tabs->addTabURL('active','Activate Payroll Period');
		$subtab = $tabs->addTabURL('genpay','Generate Payroll');
	}
}
