<?php
class IFRAME extends HtmlElement {
	function setSrc($src) {
		$this->template->trySet('src',$src);
		return $this;
	}
	function setSize($width,$height) {
		$this->template->trySet('width',$width);
		$this->template->trySet('height',$height);
		return $this;
	}
	function defaultTemplate() {
		return array('iframe');
	}
}
