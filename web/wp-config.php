<?php

require __DIR__ . '/../phpdotenv/src/Dotenv.php';
require __DIR__ . '/../phpdotenv/src/Loader.php';
require __DIR__ . '/../phpdotenv/src/Validator.php';

$dotenv = new Dotenv\Dotenv( dirname( __DIR__ ) );
$dotenv->load();
$dotenv->required( array(
  'DB_NAME',
  'DB_USER',
  'DB_PASSWORD',
  'DB_HOST',
  'WP_ENV',
  'WP_HOME',
  'WP_SITEURL'
) );


// ** MySQL settings ** //
/** The name of the database for WordPress */
define( 'DB_NAME', $_ENV['DB_NAME'] );

/** MySQL database username */
define( 'DB_USER', $_ENV['DB_USER'] );

/** MySQL database password */
define( 'DB_PASSWORD', $_ENV['DB_PASSWORD'] );

/** MySQL hostname */
define( 'DB_HOST', $_ENV['DB_HOST'] );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

define('AUTH_KEY',         '');
define('SECURE_AUTH_KEY',  '');
define('LOGGED_IN_KEY',    '');
define('NONCE_KEY',        '');
define('AUTH_SALT',        '');
define('SECURE_AUTH_SALT', '');
define('LOGGED_IN_SALT',   '');
define('NONCE_SALT',       '');

$table_prefix = 'wp_';

define( 'WP_CONTENT_DIR', dirname( __FILE__ ) . '/app' );
define( 'WP_CONTENT_URL', 'http://' . $_SERVER['HTTP_HOST'] . '/app' );
define( 'WPMU_PLUGIN_DIR', dirname( __FILE__ ) . '/app/mu-plugins' );
define( 'WPMU_PLUGIN_URL', 'http://' . $_SERVER['HTTP_HOST'] . '/app/mu-plugins' );

define( 'WP_HOME', $_ENV['WP_HOME'] );
define( 'WP_SITEURL', $_ENV['WP_SITEURL'] );

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once( ABSPATH . 'wp-settings.php' );
