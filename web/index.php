<?php
/**
 * Main web script which drives the application
 */

// load web-script common code
require_once '../settings.ini.php';
require_once '../settings.local.ini.php';
require_once '../src/bootstrap.class.php';
$bootstrap = new \dogwood\bootstrap();
$bootstrap->initialize();
