<?php
class Model_HDMFTable extends Model_Table {
	public $entity_code = 'hdmftable';

	function init() {
		parent::init();

		$this->addField('rangefrom')->type('money')->caption('Range from');
		$this->addField('rangeto')->type('money')->caption('Range to');
		$this->addField('employershareamt')->type('money')->caption('Employer Share');
		$this->addField('employersharetype')->type('list')->caption('Share Type')
			->listData(array('Percent'=>'Percent','Percent'=>'Fixed Amount'));
		$this->addField('employeeshareamt')->type('money')->caption('Employee Share');
		$this->addField('employeesharetype')->type('list')->caption('Share Type')
			->listData(array('Percent'=>'Percent','Percent'=>'Fixed Amount'));
	}
}
