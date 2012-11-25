<?php
class page_taxor extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		$obj = $this->add('MVCGrid')->setModel('TaxOverRide');
		if($obj->owner){
			$obj->owner->addColumn('button','override');
			$obj->owner->addColumn('button','reset');
			$obj->owner->addPaginator(10);
			$obj->owner->js('reloadgrid',
				$obj->owner->js()->reload());
		}
		if($_GET['override']){
			if($obj->owner)
				$obj->owner->js()->univ()
					->frameURL('Deduction Override',
						$this->api->getDestinationURL('taxae',
						array('empid'=>$_GET['override'])))
					->execute();
		}
		if($_GET['reset']){
			$empid=$this->api->sql->queryOneTableField(
				'empid','employees','id=%i',$_GET['reset']);
			$this->api->sql->updateOneTableField('taxtable_id',0,'overrides',
				'empid=%s AND employees_id=%i',$empid,$_GET['reset']);
			if($obj->owner)
				$obj->owner->js(null,
					$obj->owner->js(null,
						$obj->owner->js()
							->univ()->successMessage('Reset Successful..'))
							->atk4_grid('highlightRow',$_GET['reset']))
							->reload()->execute();
		}
	}
}
