<?php
class Menu_YTDReports extends Menu {
	function init() {
		parent::init();

		$this
			->addMenuItem('YTD Payroll Register','rpayytd')
			->addMenuItem('AlphaList','rtaxytd')
			;
	}
}
