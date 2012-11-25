<?php
class Model_Calendar extends Model_Table {
	public$entity_code = 'calendar';

	function init() {
		parent::init();

		//$this->addField('caldate')->type('date')->caption('Event Date')
		$this->addField('rangefrom')->type('date')->caption('Range from')
			->required(true)
			->defaultValue(date('Y-m-d'));
		$this->addField('rangeto')->type('date')->caption('Range to');
		$this->addField('caldesc')->caption('Event Description')
			->required(true);
		$this->addField('regrate')->type('real')->caption('Minimum Rate')
			->defaultValue(0);
		$this->addField('otrate')->type('real')->caption('Overtime Rate')
			->defaultValue(0);
		//$this->addField('ottable_id')->caption('Overtime Reference')->refModel('Model_OTTable')->displayField('otdesc');
		$this->addField('fsmonth')->type('list')->caption('Month')
			->editable(false)
			->listData(array(
				1 => 'Jan',
				2 => 'Feb',
				3 => 'Mar',
				4 => 'Apr',
				5 => 'May',
				6 => 'Jun',
				7 => 'Jul',
				8 => 'Aug',
				9 => 'Sep',
				10 => 'Oct',
				11 => 'Nov',
				12 => 'Dec'));
		$this->addField('fsyear')->caption('Year')
			->editable(false);
	}

	function beforeModify(&$data) {
		if(empty($data['rangeto']) || $data['rangeto'] < $data['rangefrom'])
			$data['rangeto'] = $data['rangefrom'];

		if(empty($data['regrate']))
			$data['regrate'] = 1;

		if(empty($data['otrate']))
			$data['otrate'] = 1;

		$re = "/\((Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d{1,2} (Sun|Mon|Tue|Wed|Thu|Fri|Sat)\)/";

		$desc = $data['caldesc'];
		$desc = preg_replace($re,null,$desc);
		$desc = trim($desc);

		//$dt = $data['caldate'];
		$dt = $data['rangefrom'];
		$dt = strtotime($dt);
		//$dt = split('\-',$dt);
		//$dt = mktime(0,0,0,$dt[1],$dt[2],$dt[0]);

		$dd = getdate($dt);
		$data['fsmonth'] = $dd['mon'];
		$data['fsyear'] = $dd['year'];

		$dt = date('(M j D)',$dt);
		$data['caldesc'] = $desc.' '.$dt;

		return parent::beforeModify($data);
	}

	/*
	function afterModify($id) {

		$q->updateCrossTables('calendar','calrate','ottable','empid',
			'x.ottable_id=y.id AND x.id=%i',$id);

		return parent::afterModify($id);
	}
	*/
}
