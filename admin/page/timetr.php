<?php
class page_timetr extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		$tab = $this->add('Tabs');
		//$obj = $tab->addTabURL('tsheet','Upload Timesheet');
		//$obj = $tab->addTabURL('upload','Upload Timesheet');
		$obj = $tab->addTab('Upload Timesheet');
		$obj->add('Button')
			->setLabel('Upload Time Recorder Timesheet')
			->js('click')->univ()
			->redirect($this->api->getDestinationUrl('upload'))
			;
		$obj = $tab->addTabURL('tsheettr','Attendance Record');
		$obj = $tab->addTabURL('shifttr','Time Computation');
		$obj = $tab->addTabURL('worktr','Work Declaration');
		$obj = $tab->addTabURL('latetr','Lates/Undertimes');
		$obj = $tab->addTabURL('absenttr','Halfdays/Absences');
		$obj = $tab->addTabURL('ottr','Overtimes');
	}
}
