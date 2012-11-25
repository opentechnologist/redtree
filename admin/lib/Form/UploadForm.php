<?php

class Form_UploadForm extends Form {
	protected $upldobj = null;
	protected $filedir = null;
	protected $filenm = null;
	protected $success = false;

	function init() {
		parent::init();

		$this->upldobj = $this->addField('sendfile','file')
			->setMode('iframe')
			->successMessage('Upload Successful..')
			->failMessage('Upload Failed..');
	}

	function isSubmitted(){
		return $this->isUploaded() && $this->success;
	}

	function uploadComplete() {
		if($this->isUploaded() && !empty($this->filedir))
			if(is_dir($this->filedir) && is_writeable($this->filedir)){
				$filedest = $this->filedir.'/'.$this->filenm;
				$filedest = str_replace('//','/',$filedest);
				$filedest .= date('YmdHis');
				$this->saveInto($filedest);
				$this->success=true;
			} else
				throw new BaseException('Unable to save file into '.$this->filedir);
	}

	function setLabel($newlabel=null){
		if(empty($newlabel))
			return $this->upldobj->caption;
		else {
			$this->upldobj->setCaption($newlabel);
			return $this;
		}
	}

	function isUploaded(){
		return isset($_FILES[$this->upldobj->name]) && !empty($_FILES[$this->upldobj->name]['name']);
	}

	function getOriginalName(){
		return $_FILES[$this->upldobj->name]['name'];
	}

	function getFilePath(){
		return $_FILES[$this->upldobj->name]['tmp_name'];
	}

	function getOriginalType(){
		if(function_exists('mime_content_type'))
			return mime_content_type($this->getFilePath());
		else
			return $_FILES[$this->upldobj->name]['type'];
	}

	function getFile(){
		return file_get_contents($this->getFilePath());
	}

	function getFileSize(){
		return filesize($this->getFilePath());
	}

	function setFolder($newdir){
		if(empty($newdir))
			return $this->filedir;
		else {
			$this->filedir=$newdir;
			return $this;
		}
	}

	function setFName($newname){
		if(empty($newname))
			return $this->filenm;
		else {
			$this->filenm=$newname;
			return $this;
		}
	}

	function saveInto($dest){
		if(!move_uploaded_file($this->getFilePath(),$dest))
				throw new BaseException('Unable to save file into '.$dest);
	}
}
