<?php
class page_loantr extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		//$tab = $this->add('Tabs');
		//$obj = $tab->addTab('Loan Transactions')->add('MVCGrid')->setModel('LoanTrans');
		$obj = $this->add('MVCGrid')->setModel('LoanTrans');

		if($this->api->recall('payrollperiod'))
			$this->add('Text')->set('Filtered on Payroll Period: '.$this->api->recall('payrollperiod'));

		if($this->api->recall('payrollperiod'))
			$obj->addCondition('payrollperiod=',$this->api->recall('payrollperiod'));

		if($obj->owner){
			$obj->owner->addColumn('button','defer');
			$obj->owner->addColumn('button','reset');
			$obj->owner->addPaginator(10);
		}

		if($_GET['defer']){
			if($obj->owner){
				list($pp,$opp) = $this->api->sql->queryOneTableList('payrollperiod,origpayrollperiod','loantrans','id=%i',$_GET['defer']);
				$npp = $this->api->sql->queryOneTableField('payrollperiod','payrollperiodtable','payrollperiod>%s ORDER BY payrollperiod',$pp);
				$f = array();
				$f['payrollperiod'] = $npp;
				if(empty($opp)) $f['origpayrollperiod'] = $pp;
				$this->api->sql->update('loantrans',$f,'id=%i',$_GET['defer']);

				$obj->owner->js(null,
					$obj->owner->js(null,
						$obj->owner->js()
							->univ()->successMessage('Defer Successful..'))
							->atk4_grid('highlightRow',$_GET['defer']))
							->reload()->execute();
			}
		}

		if($_GET['reset']){
			if($obj->owner){
				list($pp,$opp) = $this->api->sql->queryOneTableList('payrollperiod,origpayrollperiod','loantrans','id=%i',$_GET['reset']);

				if(!empty($opp)){
					$f = array();
					$f['payrollperiod'] = $opp;
					$f['origpayrollperiod'] = null;
					$this->api->sql->update('loantrans',$f,'id=%i',$_GET['reset']);
				}

				$obj->owner->js(null,
					$obj->owner->js(null,
						$obj->owner->js()
							->univ()->successMessage('Reset Successful..'))
							->atk4_grid('highlightRow',$_GET['reset']))
							->reload()->execute();
			}
		}
	}
}
