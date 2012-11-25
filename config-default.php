<?php

$config['atk']['base_path']='../atk4-1/core/';

$config['locale']['date']='Y-m-d';
$config['locale']['datetime']='Y-m-d H:i:s';
$config['locale']['date_js']='yy-mm-dd';

$dbt=$config['dbcfg']['t']='mysql';     // db type
$dbu=$config['dbcfg']['u']='root';      // db user
$dbp=$config['dbcfg']['p']='root';      // db pass
$dbh=$config['dbcfg']['h']='localhost'; // db host
$dbd=$config['dbcfg']['d']='redtree';   // db data

$config['dsn']="$dbt://$dbu:$dbp@$dbh/$dbd";

$config['url_postfix']='';
$config['url_prefix']='?page=';
$config['auth']['key']='secret';

$config['logger']['log_dir']='./logs/';

# Agile Toolkit attempts to use as many default values for config file,
# and you only need to add them here if you wish to re-define default
# values. For more options look at:
#
#  http://www.atk4.com/doc/config

setlocale(LC_MONETARY, 'en_PH');
