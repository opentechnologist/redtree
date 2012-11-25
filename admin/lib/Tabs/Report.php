<?php
class Tabs_Report extends Tabs {
	function init() {
		parent::init();

		$this->addTab('Payroll Reports')->add('Menu')
			->addMenuItem('Payroll Register','rpayreg')
			->addMenuItem('Pay Slip','rpayslp')
			->addMenuItem('Over the Counter Listing','rotclst')
			->addMenuItem('Bank Transmittal','ratmlst')
			;
		$this->addTab('Government Reports')->add('Menu')
			->addMenuItem('SSS Monthly Remittance','rsss')
			->addMenuItem('HDMF Monthly Remittance','rhdmf')
			->addMenuItem('Philhealth Monthly Remittance','rph')
			->addMenuItem('Monthly Tax Return','rtax')
			;
		$this->addTab('Year-to-Date Reports')->add('Menu')
			->addMenuItem('YTD Payroll Register','rpayytd')
			->addMenuItem('AlphaList','rtaxytd')
			;
	}
}
