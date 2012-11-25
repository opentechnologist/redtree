<?php
class page_shiftmg extends Page {
	function init() {
		parent::init();

		$m = $this->add('Model_EmployeeList');
		$e = $m->dsql()
			->field('id')
			->field('empid')
			->field('empname')
			->do_getAll();

		if(!empty($e))
			foreach($e as $a)
				$b[$a[0]] = $a[2];

		$f=$this->add('Form');
		$f->addField('dropdown','empid')->setCaption('Employee Name')
			->setAttr('style','width: 240px;')
			->setValueList($b)
			;
		$f->addField('DatePicker','startdate')->setCaption('Start Date');
		$f->addField('DatePicker','enddate')->setCaption('End Date');
		$f->addSubmit('Remove Date Range');

		$this->add('View_Error')
			->set('this function will not ask for user confirmation');

		if($f->isSubmitted()){
			$this->api->sql->delete('shifttrans',
				'employees_id=%i AND shiftdate BETWEEN %y AND %y',
					$f->get('empid'),$f->get('startdate'),$f->get('enddate'));
			$f->js()->univ()
				->closeDialog()
				->getjQuery()->trigger('reloadgrid')
				->execute();
		}
	}
}
