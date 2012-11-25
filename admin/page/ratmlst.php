<?php
class page_ratmlst extends Page {
	function init() {
		parent::init();

		$this->add('Tabs_PayrollReports')
			->main
			->add('Form_ChoosePayrollPeriod')
			->report->set('ReportBankTrans');
	}
}
