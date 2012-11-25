<?php
class page_print extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		if(isset($_GET['report'])||isset($_GET['payrollperiod'])||
			isset($_GET['fsmonth'])||isset($_GET['fsyear'])){
			$q = $this->api->sql;

			$url = null;

			if(isset($_GET['report'])) $url .= '&report='.$_GET['report'];
			if(isset($_GET['payrollperiod'])) $url .= '&payrollperiod='.$_GET['payrollperiod'];
			if(isset($_GET['fsmonth'])) $url .= '&fsmonth='.$_GET['fsmonth'];
			if(isset($_GET['fsyear'])) $url .= '&fsyear='.$_GET['fsyear'];

			$url = '../apps/reports/PayrollReports.php?'.$url;

			$this->add('IFRAME')
				->setSrc($url)
				->setSize(0,0)
				->setAttr('marginwidth','0')
				->setAttr('marginheight','0')
				->setAttr('scrolling','no')
				->setAttr('frameborder','0')
				->set(null)
				;

			$this->add('H5')->set('Generation Successful !!!');

			/*
			$f=$this->add('Form');
			$f->addSubmit('OK');

			if($f->isSubmitted()){
				$f->js()->univ()->closeDialog()
					//->getjQuery()->trigger('reloadgrid')
					->execute();
			}
			*/
		}
	}
}
