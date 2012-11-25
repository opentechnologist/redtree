<?php
class Model_ShiftTable extends Model_Table {
	public $entity_code = 'shifttable';

	function init() {
		parent::init();

		$this->addField('depttable_id')->caption('Department')
			->refModel('Model_Department')
			->displayField('deptdesc');

		$this->addField('shiftdesc')->caption('Description')
			->required(true);

		$this->addField('day1hhmm')->caption('SUN [hh:mm]')
			->length(8);
		$this->addField('day1work')->caption('Hrs')
			->length(10);
		$this->addField('day1dt')->visible(false);
		$this->addField('day1mins')->visible(false);

		$this->addField('day2hhmm')->caption('MON [hh:mm]')
			//->defaultValue('07:00')
			->length(8);
		$this->addField('day2work')->caption('Hrs')
			//->defaultValue(8)
			->length(10);
		$this->addField('day2dt')->visible(false);
		$this->addField('day2mins')->visible(false);

		$this->addField('day3hhmm')->caption('TUE [hh:mm]')
			//->defaultValue('07:00')
			->length(8);
		$this->addField('day3work')->caption('Hrs')
			//->defaultValue(8)
			->length(10);
		$this->addField('day3dt')->visible(false);
		$this->addField('day3mins')->visible(false);

		$this->addField('day4hhmm')->caption('WED [hh:mm]')
			//->defaultValue('07:00')
			->length(8);
		$this->addField('day4work')->caption('Hrs')
			//->defaultValue(8)
			->length(10);
		$this->addField('day4dt')->visible(false);
		$this->addField('day4mins')->visible(false);

		$this->addField('day5hhmm')->caption('THU [hh:mm]')
			//->defaultValue('07:00')
			->length(8);
		$this->addField('day5work')->caption('Hrs')
			//->defaultValue(8)
			->length(10);
		$this->addField('day5dt')->visible(false);
		$this->addField('day5mins')->visible(false);

		$this->addField('day6hhmm')->caption('FRI [hh:mm]')
			//->defaultValue('07:00')
			->length(8);
		$this->addField('day6work')->caption('Hrs')
			//->defaultValue(8)
			->length(10);
		$this->addField('day6dt')->visible(false);
		$this->addField('day6mins')->visible(false);

		$this->addField('day7hhmm')->caption('SAT [hh:mm]')
			->length(8);
		$this->addField('day7work')->caption('Hrs')
			->length(10);
		$this->addField('day7dt')->visible(false);
		$this->addField('day7mins')->visible(false);
	}

	function beforeModify(&$data){
		$basedt = mktime(0,0,0,1,2,1970);

		for($i=1;$i<=7;$i++){
			$prefix = 'day'.$i;

			$hhmm = trim($data[$prefix.'hhmm']);

			if(empty($hhmm)){
				$data[$prefix.'hhmm']=null;
				$data[$prefix.'work']=null;
				$data[$prefix.'dt']=null;
				$data[$prefix.'mins']=null;
			}else{
				$timedt = strtotime($hhmm,$basedt);
				$timear = getdate($timedt);
				$hhmm = date('H:i',$timedt);

				if(strtotime($hhmm,$basedt)<>$timedt)
					$data[$prefix.'hhmm'] = $hhmm;

				$timedt = strtotime($hhmm,$basedt);
				$timedt -= $basedt;
				$data[$prefix.'dt'] = $timedt;

				$work = trim($data[$prefix.'work']);
				$work = str_replace('hrs','',$work);
				$work = str_replace('mns','',$work);
				$work = trim($work);

				$f=array();$v=array();

				if(is_numeric($work)){
					$work*=1;
					if(empty($work))
							$mmm=null;
					else{
						if(is_float($work)){
							if(!empty($work)){$f[]=	$this->dynamicDecimal
								($work,5).'hrs';$v[]=$work;}
						}else{
							if(!empty($work)){$f[]='%dhrs';$v[]=$work;}
						}
						$mmm=intval($work*60);
					}
				}elseif(strpos($work,':')===false || count(split(':',$work))<>2)
					$mmm=null;
				else{
					list($hh,$mm)=split(':',$work);
					if(!empty($hh)){$f[]='%dhrs';$v[]=$hh;}
					if(!empty($mm)){$f[]='%dmns';$v[]=$mm;}
					$mmm=($hh*60)+$mm;
				}

				$f=join(' ',$f);
				$data[$prefix.'work'] = sprintf($f,$v[0],$v[1]);

				$data[$prefix.'mins'] = $mmm;
			}
		}

		return parent::beforeModify($data);
	}

	function dynamicDecimal($x,$n){ // DynamicDecimalPlaces
		$s=number_format($x,$n);
		$i=strlen($s)-$n;
		$s=preg_replace('/\.*0+$/','',$s);
		$i=strlen($s)-$i;
		$s=$i<0?'%d':'%01.'.$i.'f';
		return $s;
	}

}
