<?php
class Controller_ModuleLoader extends AbstractController {
	protected $global = null;
	protected $debug = false;
	protected $basedir = null;
	protected $locations = null;
	protected $modules = null;
	protected $output = null;

	function init() {
		parent::init();
		$this->locations = array();
		$this->modules = array();
	}

	public function setvar($global) {
		$this->global = $global;
		return $this;
	}

	public function getvar() {
		return $this->global;
	}

	public function setBaseDir($basedir) {
		if(is_dir($basedir) && is_readable($basedir))
			$this->basedir = realpath($basedir);
		else
			$this->fatal('directory path provided is missing or invalid ['.$basedir.'|'.realpath($basedir).']');
		return $this;
	}

	public function setLocation() {
		if(func_num_args())
			for($i = 0; $i < func_num_args(); $i++)
				if(is_dir(func_get_arg($i)) && is_readable(func_get_arg($i)) &&
					!in_array(realpath(func_get_arg($i)),$this->locations))
						$this->locations[] = realpath(func_get_arg($i));
				else
					$this->fatal('directory path provided is missing or invalid ['.
						func_get_arg($i).'|'.realpath(func_get_arg($i)).']');
		return $this;
	}

	public function load($file = null) {
		$found = false;
		foreach($this->locations as $location)
			if(!$found && file_exists($location.'/'.$file.'.php') &&
				is_readable($location.'/'.$file.'.php')) {
					$this->modules[$file] = $location.'/'.$file.'.php';
					$found = true;
			}
		if(!$found)
			$this->fatal('named module cannot be located ['.
				$file.'|'.split('|',$this->locations).']');
		return $this;
	}

	public function call($file = null) {
		return $this->func($file);
	}

	public function func($file = null, $func = null, &$obj = null) {
		$result = null;
		if(empty($file) || !isset($this->modules[$file]) ||
				empty($this->modules[$file]) ||
					!file_exists($this->modules[$file]))
			$this->fatal('call to missing or invalid loadable module ['.
				$file.'], use $this->load() first!');
		else {
			ob_start();
			require $this->modules[$file];
			if(!is_null($func))
				if(function_exists($func) && is_callable($func)){
					$args = func_get_args();
					$args = array_merge($this,array_slice($args,3));
					$result = call_user_func_array($func,$args);
				}else
					$this->fatal('call to missing or invalid module function ['.
						$file.'|'.$func.'()], check module first!');
			ob_clean();
			if($this->debug)
				dump();
		}
		if(is_null($func))
			return $this;
		else
			return $result;
	}

	public function redirect($file = null) {
		if(!empty($file) || isset($this->modules[$file]) || !empty($this->modules[$file]) || file_exists($this->modules[$file]))
			return $this->modules[$file];
		$this->warning('call to missing or invalid loadable module ['.$file.'], use $this->load() first!');
	}

	public function debug($newvalue = false) {
		$newvalue = $newvalue === true?true:false;
		$this->debug = $newvalue;
		return $this;
	}

	public function out() {
		if(func_num_args() > 0) {
			for($i = 0; $i < func_num_args(); $i++) {
				$s = func_get_arg($i);
				$this->output .= '<li>'.$s."</li>";
			}
		}
	}

	private function dump() {
		if(!is_null($this->output)) {
			if(!$this->mute && strlen($this->output) > 0)
				echo '<pre><hr><ul>'.$this->output.'</ul><hr></pre>';
			$this->output = null;
		}
	}
}
