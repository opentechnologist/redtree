<?php
class page_rtax extends Page {
	function init() {
		parent::init();

		$this->add('Tabs_GovtReports')
			->main
			->add('Form_ChooseMonthYear')
			->report->set('ReportTaxFile');
	}
}
