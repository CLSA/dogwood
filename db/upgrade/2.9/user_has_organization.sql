DROP PROCEDURE IF EXISTS patch_user_has_organization;
DELIMITER //
CREATE PROCEDURE patch_user_has_organization()
  BEGIN

    -- determine the cenozo database name
    SET @cenozo = ( 
      SELECT unique_constraint_schema
      FROM information_schema.referential_constraints
      WHERE constraint_schema = DATABASE()
      AND constraint_name = "fk_access_site_id"
    );  

    SELECT "Creating new user_has_organization table" AS ""; 

    SET @sql = CONCAT(
      "CREATE TABLE IF NOT EXISTS user_has_organization ( ",
        "user_id INT(10) UNSIGNED NOT NULL, ",
        "organization_id INT(10) UNSIGNED NOT NULL, ",
        "update_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(), ",
        "create_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(), ",
        "PRIMARY KEY (user_id, organization_id), ",
        "INDEX fk_organization_id (organization_id ASC), ",
        "INDEX fk_user_id (user_id ASC), ",
        "CONSTRAINT fk_user_has_organization_user_id ",
          "FOREIGN KEY (user_id) ",
          "REFERENCES ", @cenozo, ".user (id) ",
          "ON DELETE CASCADE ",
          "ON UPDATE NO ACTION, ",
        "CONSTRAINT fk_user_has_organization_organization_id ",
          "FOREIGN KEY (organization_id) ",
          "REFERENCES organization (id) ",
          "ON DELETE NO ACTION ",
          "ON UPDATE NO ACTION) ",
      "ENGINE = InnoDB; ",
    );
    PREPARE statement FROM @sql;
    EXECUTE statement;
    DEALLOCATE PREPARE statement;

  END //
DELIMITER ;

CALL patch_user_has_organization();
DROP PROCEDURE IF EXISTS patch_user_has_organization;
SELECT "Creating new user_has_organization table" AS "";
