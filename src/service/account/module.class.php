<?php
/**
 * module.class.php
 * 
 * @author Patrick Emond <emondpd@mcmaster.ca>
 * @filesource
 */

namespace dogwood\service\account;
use cenozo\lib, cenozo\log, dogwood\util;

/**
 * Performs operations which effect how this module is used in a service
 */
class module extends \cenozo\service\module
{
  /**
   * Extend parent method
   */
  public function validate()
  {
    parent::validate();

    if( $this->service->may_continue() )
    {
      $db_organization = $this->get_resource()->get_organization();

      if( !is_null( $db_organization ) )
      {
        // restrict by server
        $allow = false;
        $address =
          array_key_exists( 'HTTP_X_FORWARDED_FOR', $_SERVER ) ?
          $_SERVER['HTTP_X_FORWARDED_FOR'] :
          'localhost';

        $select = lib::create( 'database\select' );
        $select->add_table_column( 'server', 'address' );
        $server_list = $db_organization->get_server_list( $select );
        foreach( $server_list as $server )
        {
          if( $address == $server['address'] )
          {
            $allow = true;
            break;
          }
        }

        if( !$allow ) $this->get_status()->set_code( 404 );
      }
    }
  }

  /**
   * Extend parent method
   */
  public function prepare_read( $select, $modifier )
  {
    parent::prepare_read( $select, $modifier );

    // restrict by server
    $address =
      array_key_exists( 'HTTP_X_FORWARDED_FOR', $_SERVER ) ?
      $_SERVER['HTTP_X_FORWARDED_FOR'] :
      'localhost';
    $modifier->join( 'organization', 'account.organization_id', 'organization.id' );
    $modifier->join( 'server_has_organization', 'organization.id', 'server_has_organization.organization_id' );
    $modifier->join( 'server', 'server_has_organization.server_id', 'server.id' );
    $modifier->where( 'server.address', '=', $address );
  }
}
