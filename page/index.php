<?php
class page_index extends Page {
	function init() {
		parent::init();

		$form = $this->add('Form',null,'LoginForm');
		$form->setFormClass('vertical');
		$form->addField('line','login');
		$form->addfield('password','password');
		$form->addSubmit('Login');
		/*
		$form->addButton('Request')->js('click')
		->univ()->location($this->api->getDestinationURL('signup'));
		*/

		if($form->isSubmitted()) {

			$auth = $this->api->auth;
			$l = $form->get('login');
			$p = $form->get('password');

			// Manually encrypt password
			//$enc_p = $auth->encryptPassword($p,$l);

			// Manually verify login
			//if($auth->verifyCredentials($l,$enc_p)){
			if($auth->verifyCredentials($l,$p)) {

				// Manually log-in
				$auth->login($l);
				$form->js()->univ()->redirect('home')->execute();
			}
			$form->getElement('password')->displayFieldError('Incorrect login');
		}
	}
	function defaultTemplate() {
		return array('page/index');
	}
}
