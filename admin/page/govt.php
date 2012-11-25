<?php
class page_govt extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		$tabs = $this->add('Tabs');
		$obj = $tabs->addTab('SSS Contribution')->add('CRUD')->setModel('SSSTable');
		if($obj->owner->owner->grid)
			$obj->owner->owner->grid->addPaginator(10);
		$obj = $tabs->addTab('Pagibig/HDMF')->add('CRUD')->setModel('HDMFTable');
		$obj = $tabs->addTab('PhilHealth')->add('CRUD')->setModel('PHTable');
		if($obj->owner->owner->grid)
			$obj->owner->owner->grid->addPaginator(10);
		$obj = $tabs->addTab('Tax Status & Exemptions')->add('CRUD')->setModel('TaxStatus');
		$obj = $tabs->addTab('Tax Rates')->add('CRUD')->setModel('TaxTable');
		if($obj->owner->owner->grid)
			$obj->owner->owner->grid->addPaginator(10);
	}
}
