<?php
class page_shiftal extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		$f=$this->add('Form')->setFormClass('horizontal');
		$v=$f->addField('hidden','empid');
		//$f->addField('hidden','refresh')->set($this->name.'_reload');
		$f->addField('DatePicker','startdate','Shift Start Date');
		//$f->addField('DatePicker','enddate','End Date','after_field');
		$f->addField('DatePicker','enddate','Shift End Date');

		if($f->isSubmitted()){
			if($f->get('startdate')<>''&&$f->get('enddate')<>'')
				$f->js()->univ()
					->frameURL('Shift Assignment',
						$this->api->getDestinationURL('shiftae',/*array(
							'empid'=>$f->get('empid'),
							'startdate'=>$f->get('startdate'),
							'enddate'=>$f->get('enddate'),
							'refresh'=>$f->get('refresh'))*/
							$f->getAllData()))
						->execute();
			else
				$f->js()->univ()
					->dialogError('ERROR: Start Date and/or End Date is Empty')
					->execute();
		}

		$obj = $this->add('MVCGrid')->setModel('EmpShiftList');
		if($obj->owner){
			$obj->owner->addColumn('button','assign');
			$obj->owner->addQuickSearch(array('fullname','empid'));
			$obj->owner->addPaginator(10);
			//$obj->owner->js($this->name.'_reload',
			$obj->owner->js('reloadgrid',
				$obj->owner->js()->reload());
		}

		if($_GET['assign']){
			$f->js(null,array(
					$v->js()->val($_GET['assign'])
				))->submit()->execute();
		}
	}
}
