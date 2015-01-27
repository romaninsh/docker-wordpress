<?php

$dsn=$_ENV['DATABASE_URL'];
preg_match( '|([a-z0-9]+)://([^:]*)(:(.*))?@([A-Za-z0-9\.-]*)(:([0-9]*))?(/([0-9a-zA-Z_/\.-]*))|', $dsn, $matches);

define('DB_HOST', $matches[5]);
define('DB_USER', $matches[2]);
define('DB_PASSWORD', $matches[4]);
define('DB_NAME',$matches[9]);

define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', ''     );

#define('WP_HOME','http://usblog.triumph.com');
#define('WP_SITEURL','http://usblog.triumph.com');


$table_prefix  = 'wp_';

define('WP_DEBUG', false);

if ( !defined('ABSPATH') )
  define('ABSPATH', dirname(__FILE__) . '/');

require_once(ABSPATH . 'wp-settings.php');
