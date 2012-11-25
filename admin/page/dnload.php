<?php
class page_dnload extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		$this->add('Menu_Report');
	}
}
