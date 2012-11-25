<?php
class Model_Company extends Model_Table {
	public $entity_code ='companies';

	function init() {
		parent::init();

		$this->addField('companyname')->caption('Company Name')->required(true);
		$this->addField('companyaltname')->caption('Alternate Name');
		$this->addField('companydesc')->type('text')->caption('Products/Services/Contact Info');
		$this->addField('companyaddr')->type('text')->caption('Company Address')->required(true);

		$this->addField('sss_no')->caption('SSS Number')->required(true);
		$this->addField('tin_no')->caption('TIN Number')->required(true);

		$this->addField('sss_acctcode')->caption('SSS G/L Account Code');
		$this->addField('sss_contraacct')->caption('Contra Account Code');
		$this->addField('sss_normalbal')->type('list')->caption('Normal Balance')
			->listData(array('Debit'=>'Debit','Credit'=>'Credit'));

		$this->addField('hdmf_acctcode')->caption('HDMF G/L Account Code');
		$this->addField('hdmf_contraacct')->caption('Contra Account Code');
		$this->addField('hdmf_normalbal')->type('list')->caption('Normal Balance')
			->listData(array('Debit'=>'Debit','Credit'=>'Credit'));

		$this->addField('ph_acctcode')->caption('PhilHealth G/L Account Code');
		$this->addField('ph_contraacct')->caption('Contra Account Code');
		$this->addField('ph_normalbal')->type('list')->caption('Normal Balance')
			->listData(array('Debit'=>'Debit','Credit'=>'Credit'));

		$this->addField('tax_acctcode')->caption('Tax G/L Account Code');
		$this->addField('tax_contraacct')->caption('Contra Account Code');
		$this->addField('tax_normalbal')->type('list')->caption('Normal Balance')
			->listData(array('Debit'=>'Debit','Credit'=>'Credit'));
	}
}
