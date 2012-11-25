<?php
class page_rtaxytd extends Page {
	function init() {
		parent::init();

		$this->add('Tabs_YTDReports')
			->main
			->add('Form_ChooseYear')
			->report->set('ReportTaxYTD');
	}
}
