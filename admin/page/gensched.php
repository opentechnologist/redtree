<?php
class page_gensched extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		$q = $this->api->sql;

		$schedule = $q->queryOneTableFieldsResource(null,'shiftfilelist','is_generated=%s','N');

		$count=0;

		while($sched = $schedule->fetch_assoc()){
			$startdt = strtotime($sched['startdate'],0);
			$enddt = strtotime($sched['enddate'],0);
			$oneday = 24*60*60; // seconds per day

			while($startdt<=$enddt){
				$count++;

				list(,,,,$week) = array_values(getdate($startdt));
				$prefix = 'day'.($week+1);

				$date = date('Y-m-d',$startdt);
				$work = $sched[$prefix.'mins'];

				if(empty($work)){
					$timein=$timeout=0;
					$type = 'No Schedule';
				}else{
					$timein = $sched[$prefix.'dt'];
					$timein += $startdt;
					$timeout = $work;
					$timeout *= 60;
					$timeout += $timein;
					$type = 'Regular Shift';
				}

				$q->replaceOneTableRow('shifttrans',array(
					'shiftdate'    => date('Y-m-d',$startdt),

					'empid'        => $sched['empid'],
					'employees_id' => $sched['employees_id'],

					'shiftfile_id' => $sched['id'],
					'shifttable_id'=> $sched['shifttable_id'],

					'startshift'   => $timein,
					'endshift'     => $timeout,

					'shifttype'    => $type,
					),
					'shiftdate=%y AND employees_id=%i',
					$date,$sched['employees_id']);

				$startdt += $oneday;
			}

			$q->updateOneTableField('is_generated','Y','shiftfile','id=%i',$sched['id']);
		}

		$schedule->free();

		$this->add('H5')->set('Generation Successful !!!');
		$this->add('Text')->set($count.' Records Processed');

		$f=$this->add('Form');
		$f->addSubmit('OK');
		if($f->isSubmitted()){
			$f->js()->univ()->closeDialog()
				->getjQuery()->trigger('reloadgrid')
				->execute();
		}
	}
}
