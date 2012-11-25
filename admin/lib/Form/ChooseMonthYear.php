<?php
class Form_ChooseMonthYear extends Form {
	public $report = null;

	function init() {
		parent::init();

		$this->report = $this->addField('hidden','report');
		$this->addField('dropdown','fsmonth')
			->setCaption('Select Month to Generate Report')
			->setAttr('style','width: 100px;')
			->setValueList(array(
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
		$this->addField('dropdown','fsyear')
			->setCaption('Select Corresponding Year')
			->setAttr('style','width: 100px;')
			->setValueList(array(
				2011 => 2011,
				2012 => 2012,
				2013 => 2013,
				2014 => 2014,
				2015 => 2015));
		$this->addSubmit('Ok');

		if($this->isSubmitted()) {
			$param['report'] = $this->get('report');
			$param['fsmonth'] = $this->get('fsmonth');
			$param['fsyear'] = $this->get('fsyear');
			$this->js()->univ()->frameURL('Report Generation',
				$this->api->getDestinationURL('print',$param),
					array('width' => 220,'height' => 150))
					->execute();
		}
	}
}
