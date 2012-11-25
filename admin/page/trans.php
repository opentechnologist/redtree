<?php
class page_trans extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		$this->add('Text')->set('Currently Active Payroll Period:');
		$d = $this->api->recall('payrollperioddesc');
		$t = $this->add('H5')->set(is_null($d)?'NONE':$d);

		$tabs = $this->add('Tabs');
		$subtabs = $tabs->addTabURL('timetr','Time and Attendance Transactions');
		$subtabs = $tabs->addTabURL('filetr','Filed Income/Deduction Transactions');
		$subtabs = $tabs->addTabURL('govttr','Government Mandated Transactions');
	}
}
