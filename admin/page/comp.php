<?php
class page_comp extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		$tabs = $this->add('Tabs');
		$obj = $tabs->addTab('Payroll Periods')->add('CRUD')->setModel('PayrollPeriod');
		if($obj->owner->owner->grid)
			$obj->owner->owner->grid->addPaginator(10);
		/*
		if($_GET[$obj->owner->owner->name]==1&&
			$_GET['submit']==$obj->owner->owner->form->name){
					echo var_export($_GET,true);
					echo var_export($_POST,true);
					exit;
				}
		*/

		$obj = $tabs->addTab('Pay Periods')->add('CRUD')->setModel('PayPeriod');

		$subtabs = $tabs->addTab('Payroll Reference Tables')->add('Tabs');
		$obj = $subtabs->addTab('Other Income Types')->add('CRUD')->setModel('IncomeTable');
		$obj = $subtabs->addTab('Other Deduction Types')->add('CRUD')->setModel('DeductTable');
		$obj = $subtabs->addTab('Overtime Rates')->add('CRUD')->setModel('OTTable');
		$obj = $subtabs->addTab('Leave Types')->set('Undergoing Customization');
		$obj = $subtabs->addTab('Loan Types')->add('CRUD')->setModel('LoanTable');

		$obj = $tabs->addTab('Departments')->add('CRUD')->setModel('Department');
		$obj = $tabs->addTab('Employment Status')->add('CRUD')->setModel('EmpStatus');
		// ** $obj = $tabs->addTab('Portal Access')->set('Undergoing Customization');
		$obj = $tabs->addTab('Company Info')->add('FormAndSave')->setModel('Company');
		if($obj->owner){
			$obj->loadData(1);
		}
	}
}
