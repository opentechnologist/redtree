<?php
class Tabs_PayrollReports extends Tabs {
	var $main = null;

	function init() {
		parent::init();

		$this->main = $this
			->addTab('Payroll Reports');
		$this->main
			->add('Menu')
			->addMenuItem('Payroll Register','rpayreg')
			->addMenuItem('Pay Slip','rpayslp')
			->addMenuItem('Over the Counter Listing','rotclst')
			->addMenuItem('Bank Transmittal','ratmlst')
			;
		$this->addTab('Other Reports')
			->add('Menu_Report');
	}
}
