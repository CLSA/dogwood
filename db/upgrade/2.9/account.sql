SELECT "Creating new account table" AS "";

CREATE TABLE IF NOT EXISTS account (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  update_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  create_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  organization_id INT(10) UNSIGNED NOT NULL,
  username VARCHAR(45) NOT NULL,
  password VARCHAR(255) NOT NULL,
  password_type ENUM('whirlpool', 'bcrypt') NULL DEFAULT NULL,
  email VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (id),
  INDEX fk_organization_id (organization_id ASC),
  UNIQUE INDEX uq_organization_id_name (organization_id ASC, username ASC),
  CONSTRAINT fk_user_organization_id
    FOREIGN KEY (organization_id)
    REFERENCES organization (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
