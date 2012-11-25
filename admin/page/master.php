<?php
class page_master extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		$tabs = $this->add('Tabs');
		$subtabs = $tabs->addTabURL('emp','Employee Master Files');
		$subtabs = $tabs->addTabURL('shift','Shift Schedule Management');
		$subtabs = $tabs->addTabURL('comp','Company Master Files');
		$subtabs = $tabs->addTabURL('govt','Government Master Files');
	}
}
