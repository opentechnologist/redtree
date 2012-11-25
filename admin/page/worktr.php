<?php
class page_worktr extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		$obj=$this->add('CRUD')->setModel('WorkTrans');
		if($this->api->recall('payrollperiod'))
			$this->add('Text')->set('Filtered on Payroll Period: '.
				$this->api->recall('payrollperioddesc'));
		if($this->api->recall('payrollperiod'))
			$obj->addCondition('payrollperiod=',$this->api->recall('payrollperiod'));
		if($obj->owner->owner->grid)
			$obj->owner->owner->grid->addPaginator(10);
	}
}
