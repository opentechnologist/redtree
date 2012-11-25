<?php
class Form_SetPayrollPeriod extends Form {

	function init() {
		parent::init();

		$this->add('Text')->set('Currently Active Payroll Period:');
		$m = $this->add('Model_PayrollPeriodList');
		$e = $m->dsql()
					->field('payrollperiod')
					->field('payrollperioddesc')
					->do_getAll();

		$b[]='-- Clear the Currently Active Pay Period --';
		if(!empty($e))
			foreach($e as $a)
				$b[$a[0]]=$a[1];

		$d = $this->api->recall('payrollperioddesc');
		$t = $this->add('H5')->set(is_null($d)?'NONE':$d);

		$this->addField('dropdown','payrollperiod')
			->setCaption('Select a Payroll Period to Activate')
			->setValueList($b);
		$this->addSubmit('Make Active');

		if($this->isSubmitted()) {
			$this->api->forget('payrollperiod');
			$this->api->forget('payrollperioddesc');
			$s = $this->get('payrollperiod');
			if(!empty($s)){
				$s = $m->dsql()
							->field('payrollperiod')
							->where('payrollperiod=',$s)
							->do_getOne();
				$this->api->memorize('payrollperiod',$s);
				$s = $m->dsql()
							->field('payrollperioddesc')
							->where('payrollperiod=',$s)
							->do_getOne();
				$this->api->memorize('payrollperioddesc',$s);
				//$this->js()->reload()->execute();
			}
			$this->owner->js()->reload()->execute();
		}
		//$f->js_widget=false;
	}
}
