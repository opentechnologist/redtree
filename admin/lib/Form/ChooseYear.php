<?php
class Form_ChooseYear extends Form {
	public $report = null;

	function init() {
		parent::init();

		$this->report = $this->addField('hidden','report');
		$this->addField('dropdown','fsyear')
			->setCaption('Select Year to Generate Report')
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
			$param['fsyear'] = $this->get('fsyear');
			$this->js()->univ()->frameURL('Report Generation',
				$this->api->getDestinationURL('print',$param),
					array('width' => 220,'height' => 150))
					->execute();
		}
	}
}
