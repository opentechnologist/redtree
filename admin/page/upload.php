<?php
class page_upload extends Page {
	function init() {
		parent::init();

		//$d = getcwd();
		//$d = $d.'/../upload/';
		//$d = realpath($d).'/';
		//$this->add('P')->set($d);

		$f = $this->add('Form_PlainUpload')
			->setLabel('Upload a Time Recorder Timesheet Text File')
			//->setFolder('/home/~mariorey/projects/atk4/redtree/upload/')
			->setFolder(realpath(getcwd().'/../upload/').'/')
			->setFName('timesheet')->setFExt('txt');

		if($f->isSubmitted()){
			$this->add('P')->set(null);
			$this->add('P')->set('Timesheet Successfully Uploaded!');
			$this->add('P')->set('Processing Timesheet File..');

			$ctr = 0;
			$f = fopen($f->getUploadedFile(),'r');
			while(!feof($f)) {
				$entry = fgets($f);
				if(is_bool($entry))continue;

				$entry=trim($entry);
				if(empty($entry))continue;

				// TODO: once format is determined, set a flag to skip determining entry format
				if(!is_bool(strpos($entry,"\t")))
					$tmp = split("\t",$entry);
				else
					$tmp = split(',',$entry);
				$tmp = array_map('trim',$tmp);

				$trec = array();

				if(is_numeric($tmp[0]) && $tmp[0]>0 && $tmp[0]<500){
					$trec[] = intval(array_shift($tmp));

					for($i=0;$i<count($tmp);$i++)
						if(isset($tmp[0]) &&
							!preg_match("/^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$/",$tmp[0]))
								array_shift($tmp);

					if(!empty($tmp)){
						$trec[] = array_shift($tmp);
						if(count($trec)==2){
							$chksum = var_export($trec,true);
							$trec[] = sprintf('%u',crc32(str_pad($chksum,32)));
							$trec[] = strtotime($trec[1],0);

							$ok = $this->api->sql
								->insertNoDuplicates('timerectrans',array(
									'timerecid' => $trec[0],
									'timerecdt' => $trec[1],
									'dtstamp'   => $trec[3],
									'entry'     => $entry,
									'chksum'    => $trec[2],
									),
								'timerecid=%s AND timerecdt=%s AND dtstamp=%i AND chksum=%n',
									$trec[0],$trec[1],$trec[3],$trec[2]);
							if($ok)$ctr++;
						}
					}
				}
			}
			fclose($f);
			$ctr=number_format($ctr);
			$this->add('P')->set($ctr.' Timesheet Records Processed..');
			$this->add('P')->set('DONE!');
			$this->add('Button')
				->setLabel('View Attendance Record')
				->js('click')->univ()
				->redirect($this->api->getDestinationUrl('tsheettr'))
				;
		}else
			if($_SERVER['REQUEST_METHOD']=='POST')
				$this->add('P')->set('There is a problem uploading file..');
	}
}
