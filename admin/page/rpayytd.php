<?php
class page_rpayytd extends Page {
	function init() {
		parent::init();

		$this->add('Tabs_YTDReports')
			->main
			->add('Form_ChooseYear')
			->report->set('ReportPayRegisterYTD');
	}
}
