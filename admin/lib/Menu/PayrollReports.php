<?php
class Menu_PayrollReports extends Menu {
	function init() {
		parent::init();

		$this
			->addMenuItem('Payroll Register','rpayreg')
			->addMenuItem('Pay Slip','rpayslp')
			->addMenuItem('Over the Counter Listing','rotclst')
			->addMenuItem('Bank Transmittal','ratmlst')
			;
	}
}
