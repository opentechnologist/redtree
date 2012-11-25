<?php
class Model_TimeTrans extends Model_Table {
	public $entity_code = 'timerectranslist';

	function init() {
		parent::init();

		$this->addField('empid')->caption('Employee#');
		$this->addField('employees_id')->caption('Full Name')->refModel('Model_FullName')->displayField('fullname');
		$this->addField('timerecid')->caption('TimeRec#');
		$this->addField('shiftdate')->type('date')->caption('Date');
		$this->addField('timein')->type('datetime')->caption('Start of Shift');
		$this->addField('timeout')->type('datetime')->caption('End of Shift');
		$this->addField('timerecdt')->type('datetime')->caption('Recorded Entry');
		$this->addField('trgroup')->type('list')->caption('Flag')//->caption('Tag')
			->listData(array(
				-2=>'No Pair',
				-1=>'No Shift',
				0=>'-',
				1=>'Regular In',
				2=>'Regular Out',
				3=>'Late In',
				4=>'Early Out',
				5=>'Undertime',
				6=>'Halfday In',
				7=>'Halfday Out',
				8=>'Break',
				9=>'Late Break'
				));
		//$this->addField('trstatus')->caption('Status');
		$this->addField('is_processed')->type('boolean')->caption('Processed?');
	}
}
