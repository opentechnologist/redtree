<?php
class Model_CalendarList extends Model_Table {
	public$entity_code = 'calendarlist';

	function init() {
		parent::init();

		$this->addField('rangefrom')->type('date')->caption('Range from');
		$this->addField('rangeto')->type('date')->caption('Range to');
		$this->addField('noofdays')->caption('No of Days');
		$this->addField('caldesc')->type('check')->caption('Description');
		//$this->addField('regrate')->type('real')->caption('Regular Rate');
		//$this->addField('otrate')->type('real')->caption('Overtime Rate');
		$this->addField('fsmonth')->type('list')->caption('Month')
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
		$this->addField('fsyear')->caption('Year');
	}
}
