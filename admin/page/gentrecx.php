<?php
class page_gentrec extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		$q = $this->api->sql;

		$ctr = 0;

		$onemin = 60; // seconds per minute
		$onehr = $onemin*$onemin; // seconds per hour
		$oneday = 24*$onehr; // seconds per day

		$q->updateCrossTables(
			'timerectrans','empid','employees','empid',
				'x.timerecid=y.timerecid AND x.empid=%s','');

		$q->updateCrossTablesMultiFields(
			'shifttrans','empid,timerecid','employees','empid,timerecid',
				'x.employees_id=y.id AND (x.empid=%s OR x.timerecid=0)','');

		$schedule = $q->queryOneTableFieldsResource(
			null,'shifttrans','shiftstatus=%s AND startshift<>0 AND endshift<>0','Unprocessed');

		while($sched = $schedule->fetch_assoc()){
			if(empty($sched['startshift'])||
				empty($sched['endshift']))continue;

			$boundary['from'] = $sched['startshift'] - (4*$onehr);
			$boundary['to']   = $sched['endshift']   + (12*$onehr);

			$count = $q->countTableRows('timerectrans',
				'timerecid=%i AND dtstamp BETWEEN %i AND %i',
					$sched['timerecid'],$boundary['from'],$boundary['to']);

			if(empty($count))continue;

			$halfday = $sched['endshift'];
			$halfday -= $sched['startshift'];
			$halfday /= 2;
			$halfday += $sched['startshift'];

			$timein = null;
			$timeout = null;
			$latein = null;
			$undertime = null;
			$halfdayin = null;
			$halfdayout = null;
			$earlyout = null;
			$breakout = null;
			$breakin = null;
			$realin = null;
			$realout = null;

			// identify attendance record shift by time boundaries
			/*$q->updateOneTableField('shifttrans_id',sched['id'],'timerectrans',
					'timerecid=%i AND dtstamp BETWEEN %i AND %i',
						$sched['timerecid'],$boundary['from'],$boundary['to']);*/

			// group attendance record by time boundaries
			/*$q->update('timerectrans',
				array('shifttrans_id'=>$sched['id'],'trgroup'=>0),
					'timerecid=%i AND shifttrans_id=%i AND dtstamp BETWEEN %i AND %i',
						$sched['timerecid'],$sched['id'],$boundary['from'],$boundary['to']);*/
			$q->update('timerectrans',
				array('shifttrans_id'=>$sched['id'],'trgroup'=>0),
					'timerecid=%i AND dtstamp BETWEEN %i AND %i',
						$sched['timerecid'],$boundary['from'],$boundary['to']);





			// tag attendance record by the start of shift boundary (group 11)
			$q->updateOneTableField('trgroup',11,'timerectrans',
				'timerecid=%i AND shifttrans_id=%i AND dtstamp<=%i AND trgroup=0',
					$sched['timerecid'],$sched['id'],$sched['startshift']+$onemin-1); // tag up to the 59th seconds

			// tag the first entry in the attendance record as FIRST time-in (ALWAYS 1)
			$dt = $q->aggregateOneTableField('min','dtstamp','timerectrans',
					'timerecid=%i AND shifttrans_id=%i AND dtstamp<=%i AND trgroup=11',
						$sched['timerecid'],$sched['id'],$sched['startshift']);
			if(!empty($dt)){
				$q->updateOneTableField('trgroup',1,'timerectrans',
					'timerecid=%i AND shifttrans_id=%i AND dtstamp=%i',
						$sched['timerecid'],$sched['id'],$dt);
				$q->updateOneTableField('trgroup',0,'timerectrans',
					'timerecid=%i AND shifttrans_id=%i AND trgroup=11',
						$sched['timerecid'],$sched['id']);
				$timein = $dt;
				if($count==1)continue;
			}

			// check if this attendance time records has TIMEIN
			if(empty($timein)){ // attendance does not have time-in
				// tag first hour of attendance record (group 13)
				$q->updateOneTableField('trgroup',13,'timerectrans',
					'timerecid=%i AND shifttrans_id=%i AND dtstamp BETWEEN %i AND %i AND trgroup=0',
						//$sched['timerecid'],$sched['id'],$sched['startshift'],$halfday);
						$sched['timerecid'],$sched['id'],$sched['startshift']+$onemin,$sched['startshift']+$onehr-1); // 1st hour
				// tag the first entry in the late group as FIRST late-in (ALWAYS 3)
				$dt = $q->aggregateOneTableField('min','dtstamp','timerectrans',
						'timerecid=%i AND shifttrans_id=%i AND dtstamp>%i AND trgroup=13',
							$sched['timerecid'],$sched['id'],$sched['startshift']);
				if(!empty($dt)){
					$q->updateOneTableField('trgroup',3,'timerectrans',
						'timerecid=%i AND shifttrans_id=%i AND dtstamp=%i',
							$sched['timerecid'],$sched['id'],$dt);
					$q->updateOneTableField('trgroup',0,'timerectrans',
						'timerecid=%i AND shifttrans_id=%i AND trgroup=13',
							$sched['timerecid'],$sched['id']);
					$latein = $dt;
					if($count==1)continue;
				}
			}

			// ELSE check if this attendance time records has TIMEIN or LATE
			if(empty($timein)&&empty($latein)){ // attendance does not have time-in and late-in
				// tag undertime part (+1 hour) of first half of attendance record (group 15)
				$q->updateOneTableField('trgroup',15,'timerectrans',
					'timerecid=%i AND shifttrans_id=%i AND dtstamp BETWEEN %i AND %i AND trgroup=0',
						$sched['timerecid'],$sched['id'],$sched['startshift']+$onehr,$halfday);
				// tag the first entry in the undertime group as FIRST undertime (ALWAYS 5)
				$dt = $q->aggregateOneTableField('min','dtstamp','timerectrans',
						'timerecid=%i AND shifttrans_id=%i AND dtstamp>%i AND trgroup=15',
							$sched['timerecid'],$sched['id'],$sched['startshift']+$onehr);
				if(!empty($dt)){
					$q->updateOneTableField('trgroup',5,'timerectrans',
						'timerecid=%i AND shifttrans_id=%i AND dtstamp=%i',
							$sched['timerecid'],$sched['id'],$dt);
					$q->updateOneTableField('trgroup',0,'timerectrans',
						'timerecid=%i AND shifttrans_id=%i AND trgroup=15',
							$sched['timerecid'],$sched['id']);
					$undertime = $dt;
					if($count==1)continue;
				}
			}

			// ELSE check if this attendance time records has TIMEIN or LATE or UNDERTIME
			if(empty($timein)&&empty($latein)&&empty($undertime)){ // assume as HALFDAY
				// look for the first entry and tag it as halfday-in (ALWAYS 6)
				$dt = $q->aggregateOneTableField('min','dtstamp','timerectrans',
						'timerecid=%i AND shifttrans_id=%i AND trgroup=0',
							$sched['timerecid'],$sched['id']);
				if(!empty($dt)){
					$q->updateOneTableField('trgroup',6,'timerectrans',
						'timerecid=%i AND shifttrans_id=%i AND dtstamp=%i',
							$sched['timerecid'],$sched['id'],$dt);
					$halfdayin = $dt;
					if($count==1)continue;
				}
			}

			if(!empty($timein))
				$realin = $timein; else
			if(!empty($late))
				$realin = $late; else
			if(!empty($undertime))
				$realin = $undertime; else
			if(!empty($halfdayin))
				$realin = $halfdayin;

			if($count==1)continue; // only 1 record, no need to proceed





			// tag attendance record by the end of shift boundary (group 12)
			$q->updateOneTableField('trgroup',12,'timerectrans',
				'timerecid=%i AND shifttrans_id=%i AND dtstamp>=%i AND trgroup=0',
					$sched['timerecid'],$sched['id'],$sched['endshift']);

			// tag the last entry in the attendance record as LAST time-out (ALWAYS 2)
			$dt = $q->aggregateOneTableField('max','dtstamp','timerectrans',
					'timerecid=%i AND shifttrans_id=%i AND dtstamp>=%i AND trgroup=12',
						$sched['timerecid'],$sched['id'],$sched['endshift']);
			if(!empty($dt)){
				$q->updateOneTableField('trgroup',2,'timerectrans',
					'timerecid=%i AND shifttrans_id=%i AND dtstamp=%i',
						$sched['timerecid'],$sched['id'],$dt);
				$q->updateOneTableField('trgroup',0,'timerectrans',
					'timerecid=%i AND shifttrans_id=%i AND trgroup=12',
						$sched['timerecid'],$sched['id']);
				$timeout = $dt;
				if($count==2)continue;
			}

			// check if this attendance time records has TIMEOUT
			if(empty($timeout)){ // attendance does not have time-out
				// tag second half of attendance record (group 14)
				$q->updateOneTableField('trgroup',14,'timerectrans',
					'timerecid=%i AND shifttrans_id=%i AND dtstamp BETWEEN %i AND %i AND trgroup=0',
						$sched['timerecid'],$sched['id'],$halfday,$sched['endshift']-1); // less 1 second
				// tag the last entry in the early out group as FIRST early-out (ALWAYS 4)
				$dt = $q->aggregateOneTableField('max','dtstamp','timerectrans',
						'timerecid=%i AND shifttrans_id=%i AND dtstamp<%i AND trgroup=14',
							$sched['timerecid'],$sched['id'],$sched['endshift']);
				if(!empty($dt)){
					$q->updateOneTableField('trgroup',4,'timerectrans',
						'timerecid=%i AND shifttrans_id=%i AND dtstamp=%i',
							$sched['timerecid'],$sched['id'],$dt);
					$q->updateOneTableField('trgroup',0,'timerectrans',
						'timerecid=%i AND shifttrans_id=%i AND trgroup=14',
							$sched['timerecid'],$sched['id']);
					$earlyout = $dt;
					if($count==2)continue;
				}
			}

			// ELSE check if this attendance time records has TIMEOUT or EARLY OUT
			if(empty($timeout)&&empty($earlyout)){ // assume as HALFDAY
				// look for the last entry and tag it as halfday-out (ALWAYS 7)
				$dt = $q->aggregateOneTableField('max','dtstamp','timerectrans',
						'timerecid=%i AND shifttrans_id=%i AND trgroup=0',
							$sched['timerecid'],$sched['id']);
				if(!empty($dt)){
					$q->updateOneTableField('trgroup',7,'timerectrans',
						'timerecid=%i AND shifttrans_id=%i AND dtstamp=%i',
							$sched['timerecid'],$sched['id'],$dt);
					$earlyout = $dt;
					if($count==2)continue;
				}
			}

			if(!empty($timeout))
				$realout = $timeout; else
			if(!empty($earlyout))
				$realout = $earlyout; else
			if(!empty($halfdayout))
				$realout = $halfdayout;

			if($count==2)continue; // only 2 records, no need to proceed





			$pair = false;

			if(in_array($count,array(4,6,8))){
				$data = $q->queryAllTableRows('timerectrans',
					'timerecid=%i AND shifttrans_id=%i AND trgroup=0',
						$sched['timerecid'],$sched['id']);
				 // simple pairing algorithm and decision making
				switch($count){
					case 6:
						$gap = $data[5]['dtstamp'] - $data[4]['dtstamp'];
						if($gap <= $onehr){
							$data[4]['trgroup']=8;
							$data[5]['trgroup']=8;
							$pair = true;
						}elseif($gap < ($onehr + ($onemin*45))){
							$data[4]['trgroup']=9;
							$data[5]['trgroup']=9;
							$pair = true;
						}
					case 4:
						$gap = $data[3]['dtstamp'] - $data[2]['dtstamp'];
						if($gap <= $onehr){
							$data[2]['trgroup']=8;
							$data[3]['trgroup']=8;
							$pair = true;
						}elseif($gap < ($onehr + ($onemin*45))){
							$data[2]['trgroup']=9;
							$data[3]['trgroup']=9;
							$pair = true;
						}
					case 2:
						$gap = $data[1]['dtstamp'] - $data[0]['dtstamp'];
						if($gap <= $onehr){
							$data[0]['trgroup']=8;
							$data[1]['trgroup']=8;
							$pair = true;
						}elseif($gap < ($onehr + ($onemin*45))){
							$data[0]['trgroup']=9;
							$data[1]['trgroup']=9;
							$pair = true;
						}
				}
			}

			// tag the rest of entries as exception for manual processing
			if($pair===false)
				$q->updateOneTableField('trgroup',-2,'timerectrans',
					'timerecid=%i AND shifttrans_id=%i AND trgroup=0',
						$sched['timerecid'],$sched['id']);
			else
				foreach($data as $d)
					$q->updateOneTableField('trgroup',$d['trgroup'],
						'timerectrans','id=%i',$d['id']);


			// clear all group tags for further processing
			//$q->updateOneTableField('trgroup',0,'timerectrans','trgroup BETWEEN 11 AND 15');

			$ctr++;
		}

		$schedule->free();

		// tag the rest as no defined shift
		$q->updateOneTableField('trgroup',-1,'timerectrans','shifttrans_id=0');

		$this->add('H5')->set('Processing Successful !!!');
		$this->add('Text')->set($ctr.' Records Processed');

		$f=$this->add('Form');
		$f->addSubmit('OK');
		if($f->isSubmitted()){
			$f->js()->univ()->closeDialog()
				->getjQuery()->trigger('reloadgrid')
				->execute();
		}
	}
}
