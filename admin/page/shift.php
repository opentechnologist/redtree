<?php
class page_shift extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		$tab = $this->add('Tabs');

		$obj = $tab->addTab('Shift Schedule')->add('MVCGrid')->setModel('ShiftList');

		if($obj->owner){
			$b1 = $obj->owner->addButton('Generate');
			$b1->js('click')
				->univ()
				->frameURL('Schedule Generation',
					$this->api->getDestinationURL('gensched'),
					array('width'=>250));
			//$b1->js('reloadgrid',$obj->owner->js()->reload());
			$b2 = $obj->owner->addButton('Manage');
			$b2->js('click')
				->univ()
				->frameURL('Manage Generated Shifts',
					$this->api->getDestinationURL('shiftmg'),
					array('width'=>370,'height'=>295));
			$obj->owner->js('reloadgrid',$obj->owner->js()->reload());
			$obj->owner->addPaginator(15);
		}

		$obj = $tab->addTab('Shift Assignments')->add('CRUD')->setModel('ShiftFile');
		if($obj->owner->owner->grid)
			$obj->owner->owner->grid->addPaginator(10);

		$tab->addTabURL('shiftal','Shift Assignment Per Employee');

		$obj = $tab->addTab('Shift Definition')->add('CRUD')->setModel('ShiftTable');
		if($obj->owner->owner->grid)
			$obj->owner->owner->grid->addPaginator(10);

		//$obj = $tab->addTab('Specific Date Rates')->add('CRUD')->setModel('Calendar');
		$obj = $tab->addTab('Specific Date Rates')->add('CRUD_Fork')
			->setFormAndGridModels('Calendar','CalendarList')
			//->setButtonOrder()
			;
		if($obj->grid)
			$obj->grid->addPaginator(10);
	}
}
