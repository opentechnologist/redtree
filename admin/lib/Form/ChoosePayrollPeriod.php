<?php
class Form_ChoosePayrollPeriod extends Form {
	public $report = null;

	function init() {
		parent::init();

		$m = $this->add('Model_PayrollPeriodList');
		$e = $m->dsql()
			->field('payrollperiod')
			->field('payrollperioddesc')
			->do_getAll();

		if(!empty($e))
			foreach($e as $a)
				$b[$a[0]] = $a[1];

		$this->report = $this->addField('hidden','report');
		$payrollperiod = $this->addField('dropdown','payrollperiod')
			->setCaption('Select Period to Generate Report')
			->setAttr('style','width: 240px;')
			->setValueList($b)
			//->add('Form_Submit',null,'after_field')
			//->setLabel('Ok')
			//->setNoSave()
			;
		$this->addSubmit('Ok')
			//->setAttr('style','relative; margin-left: 400px;')
			;

		if($this->isSubmitted()) {
			$param['report'] = $this->get('report');
			$param['payrollperiod'] = $this->get('payrollperiod');
			$this->js()->univ()->frameURL('Report Generation',
				$this->api->getDestinationURL('print',$param),
					array('width' => 220,'height' => 150))
					->execute();
		}

	}
}
