<?php
class Form_PlainUpload extends Form_Plain {
	protected $upldobj = null;
	protected $filedir = null;
	protected $filenm = null;
	protected $fileext = null;
	protected $newfile = null;
	protected $label = null;
	var $success = false;
	var $complete = false;

	function init() {
		parent::init();

		//$this->label = $this->add('P')->set(null);
		$this->label = $this->add('H5')->set(null);

		$this->setAttr('method','post');
		$this->setAttr('enctype','multipart/form-data');

		$this->upldobj = $this->addInput('file','file',null);

		$this->addInput('submit','submit','Send');
	}

	function isSubmitted(){
		if($this->isUploaded() && !$this->complete)
			$this->uploadComplete();

		return $this->success && $this->complete;
	}

	private function uploadComplete() {
		if(!empty($this->filedir))
			if(is_dir($this->filedir) && is_writeable($this->filedir)){
				$this->complete=true;
				$filedest = $this->filedir.'/'.$this->filenm;
				$filedest = str_replace('//','/',$filedest);
				$filedest .= date('YmdHis');
				$filedest .= $this->fileext;
				$this->saveInto($filedest);
				$this->newfile = $filedest;
				$this->success=true;
			} else
				throw new BaseException('Unable to save file into folder: '.$this->filedir);
	}

	function setLabel($newlabel=null){
		$this->label->set($newlabel);
		return $this;
	}

	private function isUploaded(){
		return $_SERVER['REQUEST_METHOD']=='POST' &&
			isset($_FILES[$this->upldobj->name]) &&
			empty($_FILES[$this->upldobj->name]['error']) &&
			!empty($_FILES[$this->upldobj->name]['name']) &&
			!empty($_FILES[$this->upldobj->name]['size']);
	}

	function getUploadedFile(){
		return $this->newfile;
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

	function setFExt($newname){
		if(empty($newname))
			return $this->fileext;
		else {
			$newname='.'.$newname;
			$newname=str_replace('..','.',$newname);
			$this->fileext=$newname;
			return $this;
		}
	}

	function saveInto($dest){
		if(!move_uploaded_file($this->getFilePath(),$dest))
		//if(!copy($this->getFilePath(),$dest))
				throw new BaseException('Unable to save file into file: '.$dest);
	}

}
