<?php
class page_home extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		$this->add('Text')->set('Welcome to the Payroll Administration Portal');
	}
}
