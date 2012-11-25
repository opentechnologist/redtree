<?php
class page_emp extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		$tabs = $this->add('Tabs');

		$obj = $tabs->addTab('Employee Master')->add('CRUD')->setModel('Employee');
		if($obj->owner->owner->grid)
			$obj->owner->owner->grid->addPaginator(10);

		// ** $subtabs = $tabs->addTab('Employee Applications')->add('Tabs');
		// ** $obj = $subtabs->addTab('Late/Undertime Applications')->set('Undergoing Customization');
		// ** $obj = $subtabs->addTab('Halfdays/Absences Applications')->set('Undergoing Customization');
		// ** $obj = $subtabs->addTab('Overtime Applications')->set('Undergoing Customization');
		// ** $obj = $subtabs->addTab('Leave Applications')->set('Undergoing Customization');

		$subtabs = $tabs->addTabURL('filed','Filed Income and Deductions');
		$subtabs = $tabs->addTabURL('overrides','Deduction Calculation Overrides');
	}
}
