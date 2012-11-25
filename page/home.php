<?php
class page_home extends Page {
	function init() {
		parent::init();
		//$this->api->auth->check();
		if(!$this->api->auth->isLoggedIn())
			$this->api->redirect('index');

		$this->add('P')->add('Text')->set('Welcome to the Employee Portal, Demo User!');

		$tabs = $this->add('Tabs');
		$obj = $tabs->addTab('Late/Undertime Applications');
		$obj = $tabs->addTab('Halfdays/Absences Applications');
		$obj = $tabs->addTab('Overtime Applications');
		$obj = $tabs->addTab('Leave Applications');
	}
}
