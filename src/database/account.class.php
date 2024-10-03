<?php
/**
 * account.class.php
 * 
 * @author Patrick Emond <emondpd@mcmaster.ca>
 * @filesource
 */

namespace dogwood\database;
use cenozo\lib, cenozo\log, dogwood\util;

/**
 * account: record
 */
class account extends \cenozo\database\record
{
  /** 
   * Override parent method
   */
  public function __set( $column_name, $value )
  {
    // hash the password
    parent::__set( $column_name, $column_name == 'password' ? password_hash( $value, PASSWORD_BCRYPT ) : $value );
  }
}
