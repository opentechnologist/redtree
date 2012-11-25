<?php
class page_rhdmf extends Page {
	function init() {
		parent::init();

		$this->add('Tabs_GovtReports')
			->main
			->add('Form_ChooseMonthYear')
			->report->set('ReportHDMFFile');
	}
}
