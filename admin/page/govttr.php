<?php
class page_govttr extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		$tab = $this->add('Tabs');

		$obj = $tab->addTab('SSS Contribution')->add('MVCGrid')->setModel('SSSTrans');
		if($this->api->recall('payrollperiod'))
			$obj->addCondition('payrollperiod=',$this->api->recall('payrollperiod'));
		if($obj->owner)
			$obj->owner->addPaginator(10);

		$obj = $tab->addTab('Pagibig/HDMF')->add('MVCGrid')->setModel('HDMFTrans');
		if($this->api->recall('payrollperiod'))
			$obj->addCondition('payrollperiod=',$this->api->recall('payrollperiod'));
		if($obj->owner)
			$obj->owner->addPaginator(10);

		$obj = $tab->addTab('PhilHealth')->add('MVCGrid')->setModel('PHTrans');
		if($this->api->recall('payrollperiod'))
			$obj->addCondition('payrollperiod=',$this->api->recall('payrollperiod'));
		if($obj->owner)
			$obj->owner->addPaginator(10);

		$obj = $tab->addTab('Withholding/Income Tax')->add('MVCGrid')->setModel('TaxTrans');
		if($this->api->recall('payrollperiod'))
			$obj->addCondition('payrollperiod=',$this->api->recall('payrollperiod'));
		if($obj->owner)
			$obj->owner->addPaginator(10);

		if($this->api->recall('payrollperiod'))
			$tab->add('Text')->set('Filtered on Payroll Period: '.$this->api->recall('payrollperiod'));
	}
}
