<?php
class page_tsheet extends Page {
	function init() {
		parent::init();
		$this->api->auth->check();

		$f = $this->add('Form');
		$u = $f->addField('upload','file','Upload a Time Recorder Timesheet Data File?');
		$u->setController('Controller_Filestore_File');
		$f->addSubmit();

		$g=$this->add('MVCGrid');
		$g->setModel('FileUpload');
		$g->addColumn('button','process')
			->addColumn('delete','delete')
			->addPaginator(5);

		//if($f->isSubmitted() && $u->isUploaded()){
		if($f->isSubmitted()){
			//$f->js()->univ()->alert('File ID: '.$f->get('file'))->execute();
			$g->js()->reload()->execute();
		}
	}
}
