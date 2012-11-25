<?php
class Tabs_GovtReports extends Tabs {
	var $main = null;

	function init() {
		parent::init();

		$this->main = $this
			->addTab('Government Reports');
		$this->main
			->add('Menu')
			->addMenuItem('Bank Transmittal','ratmlst')
			->addMenuItem('SSS Monthly Remittance','rsss')
			->addMenuItem('HDMF Monthly Remittance','rhdmf')
			->addMenuItem('Philhealth Monthly Remittance','rph')
			->addMenuItem('Monthly Tax Return','rtax')
			;
		$this->addTab('Other Reports')
			->add('Menu_Report');
	}
}
