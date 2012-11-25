<?php
class page_latetr extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		$obj=$this->add('CRUD')->setModel('LateTrans');
		if($this->api->recall('payrollperiod'))
			$this->add('Text')->set('Filtered on Payroll Period: '.
				$this->api->recall('payrollperioddesc'));
		if($this->api->recall('payrollperiod'))
			$obj->addCondition('payrollperiod=',$this->api->recall('payrollperiod'));
		if($obj->owner->owner->grid)
			$obj->owner->owner->grid->addPaginator(10);
	}
}
