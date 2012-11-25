<?php
class page_active extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		$this->add('Form_SetPayrollPeriod');
	}
}
