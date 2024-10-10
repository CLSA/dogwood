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
      $db_account = $this->get_resource();

      if( !is_null( $db_account ) )
      {
        $db_user = lib::create( 'business\session' )->get_user();
        $db_organization = $db_account->get_organization();

        // restrict by user
        $user_mod = lib::create( 'database\modifier' );
        $user_mod->where( 'user.id', '=', $db_user->id );
        if( 0 == $db_organization->get_user_count( $user_mod ) ) $this->get_status()->set_code( 404 );
      }
    }
  }

  /**
   * Extend parent method
   */
  public function prepare_read( $select, $modifier )
  {
    parent::prepare_read( $select, $modifier );

    // restrict by user
    $db_user = lib::create( 'business\session' )->get_user();
    $modifier->join( 'organization', 'account.organization_id', 'organization.id' );
    $modifier->join( 'user_has_organization', 'organization.id', 'user_has_organization.organization_id' );
    $modifier->where( 'user_has_organization.user_id', '=', $db_user->id );
  }
}
