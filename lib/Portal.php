<?php
class Portal extends ApiFrontend {
	function init() {
		parent::init();

		$this->addLocation('.',array('php' => array('lib')));
		$this->addLocation('../atk4-1/core',array('php' => array('lib',)));
		$this->addLocation('../atk4-1/addons',array('php' => array('mvc','misc/lib',)))->setParent($this->pathfinder->base_location);

		$this->add('jUI');
		$this->js()->_load('atk4_univ')->_load('ui.atk4_notify');
		$this->dbConnect();

		#if(empty($this->api->sql))
		#	$this->api->sql = new simpledb2(
		#		$this->api->getConfig('dbcfg/u','root'),
		#		$this->api->getConfig('dbcfg/p',''),
		#		$this->api->getConfig('dbcfg/d','information'),
		#		$this->api->getConfig('dbcfg/h','localhost'),
		#		3306);

		//$this->auth=$this->add('SiteAuth');
		//$this->add('BasicAuth')->allow('demo','demo')->check();
		$this->auth = $this->add('BasicAuth');
		$this->auth->allow('demo','demo');

		$menu = $this->add('Menu',null,'Menu');
		if($this->auth->isLoggedIn()) {
			$menu->addMenuItem('Home','home');
			$menu->addMenuItem('logout');
		}
		/*if($this->auth){
		$menu->addMenuItem('Home','home');
		//$menu->addMenuItem('account');
		}else{
		$menu->addMenuItem('Home','home');
		}*/
	}
	/*function page_index($p){
	$this->api->redirect('home');
	}*/
}
