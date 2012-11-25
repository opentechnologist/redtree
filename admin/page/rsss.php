<?php
class page_rsss extends Page {
	function init() {
		parent::init();

		$this->add('Tabs_GovtReports')
			->main
			->add('Form_ChooseMonthYear')
			->report->set('ReportSSSFile');
	}
}
