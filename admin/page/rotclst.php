<?php
class page_rotclst extends Page {
	function init() {
		parent::init();

		$this->add('Tabs_PayrollReports')
			->main
			->add('Form_ChoosePayrollPeriod')
			->report->set('ReportCashTrans');
	}
}
