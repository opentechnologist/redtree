<?php
class CRUD_Fork extends CRUD {

	//var $grid_class = 'NewMVCGrid';

	function setFormClass($formclass = 'MVCForm') {
		$this->form_class = $formclass;
		return $this;
	}

	function setGridClass($gridclass = 'MVCGrid') {
		$this->grid_class = $gridclass;
		return $this;
	}

	function setFormModel($formmodel,$formfields = null) {
		if($this->form) {
			$m = $this->form
				->setModel($formmodel,$formfields);
			$this->form->addSubmit();
		}
		return $this;
	}

	function setGridModel($gridmodel,$gridfields = null) {
		if($this->grid)
			$m = $this->grid
				->setModel($gridmodel,$gridfields);
		return $this;
	}

	function setFormAndGridModels($formmodel,$gridmodel,$formfields = null,$gridfields = null) {
		$this->setFormModel($formmodel,$formfields);
		$this->setGridModel($gridmodel,$gridfields);
		$this->initComponents();
		return $this;
	}

	function setButtonOrder() {
		//$this->initComponents();
		if($this->grid) {
			$this->grid
				->addOrder()
			//	->move('edit','first')
				->move('edit','after','id')
				->move('delete','after','edit')
				->now();
		}
	}
}

/*
class NewMVCGrid extends MVCGrid {
	function init_delete($field){ // override init_delete
		$this->columns[$field]['button_class']='red';
	}
}
*/
