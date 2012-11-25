<?php
class Model_FileUpload extends Model_Table {
	public $entity_code = 'filestore_file';

	function init() {
		parent::init();

		$this->addField('filestore_volume_id')->type('reference')->caption('Volume')->refModel('Model_Filestore_Volume');
		//$this->addField('filestore_type_id')->type('reference')->caption('Type')->refModel('Model_Filestore_Type');
		$this->addField('original_filename')->type('text')->caption('File Name');
		$this->addField('filesize')->type('byte')->caption('Size');
		$this->addField('storedate')->type('datetime')->caption('Upload Date');
		$this->addField('filename')->type('text')->caption('Internal Name');
	}

	/*
	function beforeDelete(&$d){
		// Truncate but do not delete file completely
		parent::beforeDelete($d);
		$fd=fopen($this->getPath(),'w');
		fclose($fd);
	}
	*/
}
