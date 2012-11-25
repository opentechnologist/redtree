<?php
class page_shifttr extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		//$obj = $this->add('MVCGrid')->setModel('ShiftRecord');
		$obj = $this->add('CRUD_NoAdd')->setModel('TimeFile');

		if($obj->owner->owner->grid){
			$obj->owner->owner->grid->dq->order('empid,timerecdt,calctag');
			$obj->owner->owner->grid->addPaginator(15);
		}
	}
}
