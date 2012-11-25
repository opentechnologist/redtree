<?php
class page_calc extends Page {
	protected $out = null;

	function init() {
		parent::init();
		$this->api->auth->check();
		$this->out = $this
			->add('HtmlElement')
			->setElement('DIV')
			->setStyle('width','200px')
			->setStyle('height','200px')
			->setStyle('overflow','auto')
			->add('UL')->set(null)
			//->setStyle('display','inline')
			//->setStyle('list-style-type','none')
			//->setStyle('padding-right','20px')
			;

		$modules=array(
			'GenerateData',
			'ComputeBasicPay',
			'ComputeAttendance',
			'ComputeIncome',
			'ComputeLates',
			'ComputeAbsent',
			'ComputeOvertime',
			'ComputeGrossPay',
			'ComputeDeduction',
			'ComputeLoan',
			'ComputeSSS',
			'ComputeHDMF',
			'ComputePH',
			'ComputeTax',
			'ComputeNetPay');
		foreach($modules as $m)
			$this->load($m);

		list($s,$yn)=$this->api->sql->queryOneTableList('payrollperiod,is_closed','payrollperiodtable','id=%i',$_GET['generate']);
		$this->api->sql->updateOneTableField('is_generated','Y','payrollperiodtable','id=%i',$_GET['generate']);

		$this->add('H5')->set('Generation Successful !!!');

		$f=$this->add('Form');
		$f->addSubmit('OK');
		if($f->isSubmitted()){
			$f->js()->univ()->closeDialog()
				->getjQuery()->trigger('reloadgrid')
				->execute();
		}
	}

	function load($m){ // simulated BaseCLIClass function
		$q=$this->api->sql;
		$p='../apps/modules/'.$m.'.php';
		if(!file_exists($p) || !is_file($p) || !is_readable($p))
			throw $this->Exception('Unable to load: ['.
				$m.'] starting from ['.realpath('.').']');
		include($p);
	}

	function out(){ // simulated BaseCLIClass function
		if(func_num_args() > 0) {
			for($i = 0; $i < func_num_args(); $i++) {
				$s = func_get_arg($i);
				$this->out->add('LI')->set($s)
					//->setStyle('display','inline')
					//->setStyle('list-style-type','square')
					//->setStyle('padding-right','20px')
				;
			}
		}
	}

	function dbgout(){ // empty stub
	}

	function error(){ // empty stub
	}

}
