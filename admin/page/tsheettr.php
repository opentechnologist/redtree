<?php
class page_tsheettr extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		$obj=$this->add('MVCGrid')->setModel('TimeTrans');
		if($obj->owner){
			$b = $obj->owner->addButton('Process');
			$b->js('click')
				->univ()
				->frameURL('Schedule Generation',
					$this->api->getDestinationURL('gentrec'),
					array('width'=>250));
			$b->js('reloadgrid',$obj->owner->js()->reload());
			//$obj->owner->addButton('Post');
			$obj->owner->addPaginator(20);
		}
		//$this->add('Text')->set('Tag Legend: (1) Time-In, (2) Time-Out, (3) Late-In, (4) Early-Out, (5) Undertime');
	}
}
