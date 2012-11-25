<?php
class Menu_GovtReports extends Menu {
	function init() {
		parent::init();

		$this
			->addMenuItem('Bank Transmittal','ratmlst')
			->addMenuItem('SSS Monthly Remittance','rsss')
			->addMenuItem('HDMF Monthly Remittance','rhdmf')
			->addMenuItem('Philhealth Monthly Remittance','rph')
			->addMenuItem('Monthly Tax Return','rtax')
			;
	}
}
