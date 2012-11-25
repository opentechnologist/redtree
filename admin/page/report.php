<?php
class page_report extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		$this->add('Text')->set('Currently Active Payroll Period:');
		$d = $this->api->recall('payrollperioddesc');
		$t = $this->add('H5')->set(is_null($d)?'NONE':$d);

		$tabs = $this->add('Tabs');
		$subtab = $tabs->addTabURL('paylist','Payroll Reports');
		$subtab = $tabs->addTabURL('govtlist','Government Reports');
		$subtab = $tabs->addTabURL('ytdlist','Year-to-Date Reports');

		//$subtab = $tabs->addTabURL('dnload','Printable Reports');
		$subtab = $tabs->addTab('Downloadable / Printable Reports')
			->add('Menu_Report');
;
	}
}
