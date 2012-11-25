<?php
class page_shiftae extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		if($_GET['empid']){
			$this->api->stickyGET('empid');
			$this->api->stickyGET('startdate');
			$this->api->stickyGET('enddate');
			//$this->api->stickyGET('refresh');
			list($empname,$deptname)=$this->api->sql->queryOneTableList(
				'fullname,deptdesc','empname','id=%i',$_GET['empid']);
			$this->add('Text')->set('Shift Assignment for ');
			$this->add('HtmlElement')->setElement('B')->set($empname);
			$this->add('Text')->set(' in Department ');
			$this->add('HtmlElement')->setElement('B')->set($deptname);
			$this->add('Text')->set(' from ');
			$this->add('HtmlElement')->setElement('B')->set($_GET['startdate']);
			$this->add('Text')->set(' to ');
			$this->add('HtmlElement')->setElement('B')->set($_GET['enddate']);
		}
		$obj = $this->add('MVCGrid')->setModel('ShiftTable',
			array('id','depttable_id','shiftdesc'));
		if($obj->owner){
			$obj->owner->addColumn('button','assign');
			if($_GET['empid']){
				$depttableid=$this->api->sql->queryOneTableField(
					'depttable_id','employees','id=%i',$_GET['empid']);
				if(!is_null($depttableid))
					$obj->addCondition('depttable_id=',$depttableid);
			}
			$obj->owner->addPaginator(10);
		}
		if($_GET['empid']&&$_GET['assign']){
			$empid=$this->api->sql->queryOneTableField(
				'empid','employees','id=%i',$_GET['empid']);
			$this->api->sql->replaceOneTableRow('shiftfile',array(
					'empid'=>$empid,
					'employees_id'=>$_GET['empid'],
					'shifttable_id'=>$_GET['assign'],
					'startdate'=>$_GET['startdate'],
					'enddate'=>$_GET['enddate']
				),'empid=%s AND employees_id=%i',$empid,$_GET['empid']);
			if($obj->owner)
				$obj->owner->js()->univ()
					->closeDialog()
					->getjQuery()
					//->trigger($_GET['refresh'])
					->trigger('reloadgrid')
					->execute();
		}
		$this->add('View_Info')
			->set('Make sure entries in Shift Definition has Departments for Filtering here');
	}
}
