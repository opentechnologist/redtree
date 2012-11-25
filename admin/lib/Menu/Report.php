<?php
class Menu_Report extends Menu {
	function init() {
		parent::init();

		if(get_class($this->owner->owner)<>'Tabs_PayrollReports')$this->addMenuItem('Payroll Reports','rpayreg');
		if(get_class($this->owner->owner)<>'Tabs_GovtReports')$this->addMenuItem('Government Reports','rsss');
		if(get_class($this->owner->owner)<>'Tabs_YTDReports')$this->addMenuItem('Year-to-Date Reports','rpayytd');
	}
}
