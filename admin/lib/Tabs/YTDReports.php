<?php
class Tabs_YTDReports extends Tabs {
	var $main = null;

	function init() {
		parent::init();

		$this->main = $this
			->addTab('Year-to-Date Reports');
		$this->main
			->add('Menu')
			->addMenuItem('YTD Payroll Register','rpayytd')
			->addMenuItem('AlphaList','rtaxytd')
			;
		$this->addTab('Other Reports')
			->add('Menu_Report');
	}
}
