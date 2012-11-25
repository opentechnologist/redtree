<?php
class Admin extends ApiFrontend {
	public $is_admin = true;

	function init() {
		parent::init();
		$this->dbConnect();

		#if(empty($this->api->sql))
		#	$this->api->sql = new simpledb2(
		#		$this->api->getConfig('dbcfg/u','root'),
		#		$this->api->getConfig('dbcfg/p',''),
		#		$this->api->getConfig('dbcfg/d','information'),
		#		$this->api->getConfig('dbcfg/h','localhost'),
		#		3306);

		$this->addLocation('..',array('php' => array('lib')));
		$this->addLocation('../..',array('php' => array('atk4-addons/mvc','atk4-addons/misc/lib',)))
			->setParent($this->pathfinder->base_location);

		$this->add('jUI');
		$this->js()->_load('atk4_univ')->_load('ui.atk4_notify');

		// Allow user: "admin", with password: "demo" to use this application
		$this->add('BasicAuth')->allow('admin','demo')->check();

		$n = $this->add('Menu',null,'Menu');
		$this->api->menu = $n;
		//$n->addMenuItem('Schema Generator','sg');
		$n->addMenuItem('home');
		$n->addMenuItem('Payroll Generation','paygen');
		$n->addMenuItem('Payroll Transactions','trans');
		$n->addMenuItem('Payroll Reports','report');
		$n->addMenuItem('Payroll Master Files','master');
		$n->addMenuItem('logout');
	}
	function page_index($p) {
		$this->api->redirect('home');
	}
}
