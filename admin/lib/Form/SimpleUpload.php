<?php

class Form_SimpleUpload extends Form {
	function init() {
		parent::init();

		$f = $this->add('Form_Plain');
		$u = $f->addField('upload','file','Send a New Timesheet Text File')
			->setMode('simple');
		$f->addInput('submit','submit','Send');
		//$f->js_widget = false;
		//$f->addSubmit();
		//$f->onSubmit(array($this,'mysubmit'));
	}

	function mysubmit(){
		die(var_export($_FILES,true));
	}

	/*function lateSubmit() {
		if($_GET['submit']!=$this->name)return;
		//$this->add('Text')->set('Upload Successful..'.var_export($_FILES,true));
		echo var_export($_FILES,true);
		exit;
	}*/
}
