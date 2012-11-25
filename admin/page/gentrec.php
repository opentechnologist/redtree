<?php
class page_gentrec extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		$q = $this->api->sql;



		$onemin = 60; // seconds per minute
		$onehr = $onemin*$onemin; // seconds per hour
		$oneday = 24*$onehr; // seconds per day

		$t = new TimeRec();

		$ctr = 0;

		$q->updateCrossTables(
			'timerectrans','empid','employees','empid',
				'x.timerecid=y.timerecid AND x.empid=%s','');

		$q->updateCrossTablesMultiFields(
			'shifttrans','empid,timerecid','employees','empid,timerecid',
				'x.employees_id=y.id AND (x.empid=%s OR x.timerecid=0)','');

		//$schedule = $q->queryOneTableFieldsResource(
		//	null,'shifttrans','shiftstatus=%s AND startshift<>0 AND endshift<>0','Unprocessed');
		$schedule = $q->queryOneTableFieldsResource(
			null,'shifttrans','startshift<>0 AND endshift<>0');

		while($sched = $schedule->fetch_assoc()){
			if(empty($sched['startshift'])||
				empty($sched['endshift']))continue; // no schedule (possible overtime?)

			$boundary['from'] = $sched['startshift'] - (4*$onehr);
			$boundary['to']   = $sched['endshift']   + (12*$onehr);

			$count = $q->countTableRows('timerectrans',
				'timerecid=%i AND dtstamp BETWEEN %i AND %i',
					$sched['timerecid'],$boundary['from'],$boundary['to']);

			if(empty($count))continue; // possible absent

			$q->updateOneTableField('shifttrans_id',$sched['id'],'timerectrans',
				'timerecid=%i AND dtstamp BETWEEN %i AND %i',
					$sched['timerecid'],$boundary['from'],$boundary['to']);

			$t->load($q->queryOneTableFieldsResource(
				'id,dtstamp,trgroup','timerectrans',
					'timerecid=%i AND dtstamp BETWEEN %i AND %i ORDER BY dtstamp',
						$sched['timerecid'],$boundary['from'],$boundary['to']));

			$t->init($q,$sched);

			$t->timein();
			$t->latein();
			$t->undertime();

			$t->timeout();
			$t->earlyout();

			$t->halfdayin();
			$t->halfdayout();

			//$t->dump();
			$t->unload();

			$ctr++;
		}

		$schedule->free();



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

class TimeRec {
	var $sql = null;
	var $sched = null;

	var $trec1 = null;
	var $trec2 = null;

	var $count = null;

	var $timein = null;
	var $timeout = null;

	var $latein = null;
	var $earlyout = null;

	var $undertime = null;

	var $earlyin = null;
	var $lateout = null;

	var $otin = null;
	var $otout = null;

	var $halfdayin = null;
	var $halfdayout = null;

	var $breakout = null;
	var $breakin = null;

	var $lunchout = null;
	var $lunchin = null;

	var $realin = null;
	var $realout = null;

	var $fixedin = null;
	var $fixedout = null;

	var $start = null;
	var $end = null;

	var $halfday = null;

	var $onemin = null;
	var $onehr = null;
	var $oneday = null;

	function timein(){
		$timein=min($this->trec2['dtstamp']);
		if($timein<=($this->start+$this->onemin-1)){
			$key=array_search($timein,$this->trec2['dtstamp']);
			$this->timein=$timein;
			$this->trec1[$key]['trgroup']=1;
			$this->trec2['trgroup'][$key]=1;
		}
		return $this;
	}

	function latein(){
		$latein=min($this->trec2['dtstamp']);
		if(is_null($this->timein)&&$latein<($this->start+$this->onehr)){
			$key=array_search($latein,$this->trec2['dtstamp']);
			$this->latein=$latein;
			$this->trec1[$key]['trgroup']=3;
			$this->trec2['trgroup'][$key]=3;
		}
		return $this;
	}

	function undertime(){
		$undertime=min($this->trec2['dtstamp']);
		if(is_null($this->timein)&&is_null($this->latein)&&
				$undertime>=($this->start+$this->onehr)&&$undertime<$this->halfday){
			$key=array_search($undertime,$this->trec2['dtstamp']);
			$this->undertime=$undertime;
			$this->trec1[$key]['trgroup']=5;
			$this->trec2['trgroup'][$key]=5;
		}
		return $this;
	}

	function timeout(){
		$timeout=max($this->trec2['dtstamp']);
		if($timeout>=$this->end){
			$key=array_search($timeout,$this->trec2['dtstamp']);
			$this->timeout=$timeout;
			$this->trec1[$key]['trgroup']=2;
			$this->trec2['trgroup'][$key]=2;
		}
		return $this;
	}

	function earlyout(){
		$earlyout=max($this->trec2['dtstamp']);
		if(is_null($this->timeout)&&$earlyout<$this->end&&
				$earlyout>($this->end-($this->onehr*2))){
			$key=array_search($earlyout,$this->trec2['dtstamp']);
			$this->earlyout=$earlyout;
			$this->trec1[$key]['trgroup']=4;
			$this->trec2['trgroup'][$key]=4;
		}
		return $this;
	}

	function halfdayin(){
		$halfdayin=min($this->trec2['dtstamp']);
		$grace=intval($this->onemin*40*(($this->end-$this->start)/($this->onehr*8)));
		if(is_null($this->timein)&&is_null($this->latein)&&is_null($this->undertime)&&
				$count>1&&!(is_null($this->timeout)||is_null($this->earlyout))&&
				$halfdayin>=$this->halfday&&$halfdayin<=($this->halfday+$grace)){
			$key=array_search($halfdayin,$this->trec2['dtstamp']);
			$this->halfdayin=$halfdayin;
			$this->trec1[$key]['trgroup']=6;
			$this->trec2['trgroup'][$key]=6;
		}
		return $this;
	}

	function halfdayout(){
		$halfdayout=max($this->trec2['dtstamp']);
		$grace=intval($this->onemin*40*(($this->end-$this->start)/($this->onehr*8)));
		if(is_null($this->timeout)&&is_null($this->earlyout)&&$count>1&&
				!(is_null($this->timein||is_null($this->latein)||is_null($this->undertime))&&
				$halfdayout>=$this->halfday)&&$halfdayout<=($this->halfday+$grace)){
			$key=array_search($halfdayout,$this->trec2['dtstamp']);
			$this->halfdayout=$halfdayout;
			$this->trec1[$key]['trgroup']=7;
			$this->trec2['trgroup'][$key]=7;
		}
		return $this;
	}

	function cleartag($tag){
		for($i=0;$i<count($this->trec1);$i++){
			if($this->trec1[$i]['trgroup']==$tag)
				$this->trec1[$i]['trgroup']=0;
			if($this->trec2['trgroup'][$i]==$tag)
				$this->trec2['trgroup'][$i]=0;
		}
		return $this;
	}

	function init(&$sql,&$sched){
		$this->sql=$sql;
		$this->sched=$sched;

		for($i=0;$i<count($this->trec1);$i++){
			$this->trec1[$i]['trgroup']=0;
			$this->trec1[$i]['lgap']=0;
			$this->trec1[$i]['rgap']=0;
			$this->trec2['id'][$i]=$this->trec1[$i]['id'];
			$this->trec2['dtstamp'][$i]=$this->trec1[$i]['dtstamp'];
			$this->trec2['trgroup'][$i]=$this->trec1[$i]['trgroup'];
			$this->trec2['lgap'][$i]=0;
			$this->trec2['rgap'][$i]=0;
		}

		$this->start = $sched['startshift'];
		$this->end = $sched['endshift'];

		$this->halfday = $sched['endshift'];
		$this->halfday -= $sched['startshift'];
		$this->halfday /= 2;
		$this->halfday += $sched['startshift'];

		$this->onemin = 60; // seconds per minute
		$this->onehr = $this->onemin*$this->onemin; // seconds per hour
		$this->oneday = 24*$this->onehr; // seconds per day

		$this->timein = null;
		$this->timeout = null;
		$this->latein = null;
		$this->earlyout = null;
		$this->undertime = null;
		$this->earlyin = null;
		$this->lateout = null;
		$this->otin = null;
		$this->otout = null;
		$this->halfdayin = null;
		$this->halfdayout = null;
		$this->breakout = null;
		$this->breakin = null;
		$this->lunchout = null;
		$this->lunchin = null;
		$this->realin = null;
		$this->realout = null;
		$this->fixedin = null;
		$this->fixedout = null;

		return $this;
	}

	function append($t){
		if($t!==false||is_array($t)){
			$this->trec1[]=$t;
			$this->count++;
		}
		return($t!==false);
	}

	function load($q){
		$this->count=0;
		while($this->append($q->fetch_assoc()));
		//$this->count=count($this->trec1);
		return $this;
	}

	function unload(){
		foreach($this->trec1 as $trec)
			$this->sql->update('timerectrans',array('trgroup'=>$trec['trgroup']),
				'id=%i AND dtstamp=%i',$trec['id'],$trec['dtstamp']);
		// TODO: unload calculated late, undertime, absent,

		$this->sql->delete('timereccalc','employees_id=%i AND timerecdt=%y',
			$this->sched['employees_id'],$this->sched['shiftdate']);

		if(!is_null($this->latein)){
			$calcmins=$this->latein;
			$calcmins-=$this->start;
			$calcmins=abs($calcmins)/60;
			$this->save(1,$calcmins);
		}

		if(!is_null($this->undertime)){
			$calcmins=$this->undertime;
			$calcmins-=$this->start;
			$calcmins=abs($calcmins)/60;
			$this->save(2,$calcmins);
		}

		if(!is_null($this->earlyout)){
			$calcmins=$this->end;
			$calcmins-=$this->earlyout;
			$calcmins=abs($calcmins)/60;
			$this->save(2,$calcmins);
		}

		if(!is_null($this->timein)){
			$calcmins=$this->start;
			$calcmins-=$this->timein;
			$calcmins=abs($calcmins)/60;
			if($calcmins>120) // 2 hours minimum overtime
				$this->save(4,$calcmins);
		}

		if(!is_null($this->timeout)){
			$calcmins=$this->timeout;
			$calcmins-=$this->end;
			$calcmins=abs($calcmins)/60;
			if($calcmins>120) // 2 hours minimum overtime
				$this->save(4,$calcmins);
		}

		unset($this->trec1);
		unset($this->trec2);
		$this->trec1=array();
		$this->trec2=array();
		return $this;
	}

	function save($calctag,$calcmins){
		$this->sql->insert('timereccalc',array(
			'empid'=>$this->sched['empid'],
			'employees_id'=>$this->sched['employees_id'],
			'timerecid'=>$this->sched['timerecid'],
			'timerecdt'=>$this->sched['shiftdate'],
			'calcmins'=>intval($calcmins),
			'calchrs'=>$calcmins/60,
			'calctag'=>$calctag,
			'timerectrans_id'=>$this->trec1['id'],
			'shifttrans_id'=>$this->sched['id'],
			'shiftfile_id'=>$this->sched['shiftfile_id']
			));
	}

	function dump(){
		echo '<HR>';
		var_dump($this->trec1);
		echo '<HR>';
		var_dump($this->trec2);
		return $this;
	}
}
