<?php
class page_genpay extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		$obj = $this->add('MVCGrid')->setModel('GeneratePayroll');
		//$obj->addCondition('is_closed=','N');
		if($this->api->recall('payrollperiod'))
			$obj->addCondition('payrollperiod=',$this->api->recall('payrollperiod'));

		if($obj->owner){
			$obj->owner->addColumn('button','generate')
				->js('reloadgrid',$obj->owner->js()->reload());

			$obj->owner->addColumn('button','open');
			$obj->owner->addColumn('button','close');
			$obj->owner->addPaginator(10);
		}

		if($_GET['generate']){
			if($obj->owner){
				$payrollperiod=$this->api->sql->queryOneTableField(
					'payrollperiod','payrollperiodtable','id=%i',$_GET['generate']);
				$obj->owner->js()->univ()
					->frameURL('Payroll Generation',
						$this->api->getDestinationURL('calc',
						array('payrollperiod'=>$payrollperiod)),
						array('width'=>250,'height'=>360))
					->execute();
			}
		}

		if($_GET['open']){
			if($obj->owner){
				$this->api->sql->updateOneTableField('is_closed','N','payrollperiodtable','id=%i',$_GET['close']);
				$s=$this->api->sql->queryOneTableField('payrollperioddesc','payrollperiodlist','id=%i',$_GET['close']);

				$obj->owner->js(null,
					$obj->owner->js(null,
						$obj->owner->js()
							->univ()->successMessage("Payroll Period '$s' Successfully Opened.."))
							->atk4_grid('highlightRow',$_GET['generate']))
							->reload()->execute();
			}
		}

		if($_GET['close']){
			if($obj->owner){
				$this->api->sql->updateOneTableField('is_closed','Y','payrollperiodtable','id=%i',$_GET['close']);
				$s=$this->api->sql->queryOneTableField('payrollperioddesc','payrollperiodlist','id=%i',$_GET['close']);

				$obj->owner->js(null,
					$obj->owner->js(null,
						$obj->owner->js()
							->univ()->successMessage("Payroll Period '$s' Successfully Closed.."))
							->atk4_grid('highlightRow',$_GET['generate']))
							->reload()->execute();
			}
		}
	}
}
