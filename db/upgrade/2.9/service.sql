SELECT "Creating new service table" AS "";

CREATE TABLE IF NOT EXISTS service (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  update_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  create_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  method ENUM('DELETE', 'GET', 'PATCH', 'POST', 'PUT') NOT NULL,
  subject VARCHAR(45) NOT NULL,
  resource TINYINT(1) NOT NULL DEFAULT 0,
  restricted TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (id),
  UNIQUE INDEX uq_method_subject_resource (method ASC, subject ASC, resource ASC))
ENGINE = InnoDB;

SELECT 'Adding new services' AS '';

INSERT IGNORE INTO service ( subject, method, resource, restricted ) VALUES
( 'account', 'DELETE', 1, 1 ),
( 'account', 'GET', 0, 1 ),
( 'account', 'GET', 1, 1 ),
( 'account', 'PATCH', 1, 1 ),
( 'account', 'POST', 0, 1 );
