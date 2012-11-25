<?php
class page_hdmfae extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		if($_GET['empid']){
			$this->api->stickyGET('empid');
			$empname=$this->api->sql->queryOneTableField('empname',
				'employeelist','id=%i',$_GET['empid']);
			$this->add('Text')->set('Assign HDMF Deduction Override for ');
			$this->add('HtmlElement')->setElement('B')->set($empname);
		}
		$obj = $this->add('MVCGrid')->setModel('HDMFTable');
		if($obj->owner){
			$obj->owner->addColumn('button','assign');
			$obj->owner->addPaginator(10);
		}
		if($_GET['empid']&&$_GET['assign']){
			$empid=$this->api->sql->queryOneTableField(
				'empid','employees','id=%i',$_GET['empid']);
			$this->api->sql->replaceOneTableRow('overrides',array(
					'empid'=>$empid,
					'employees_id'=>$_GET['empid'],
					'hdmftable_id'=>$_GET['assign']
				),'empid=%s AND employees_id=%i',$empid,$_GET['empid']);
			if($obj->owner)
				$obj->owner->js()->univ()
					->closeDialog()
					->getjQuery()
					->trigger('reloadgrid')
					->execute();
		}
	}
}
