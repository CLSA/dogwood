SELECT "Creating new server_has_organization table" AS "";

CREATE TABLE IF NOT EXISTS server_has_organization (
  server_id INT(10) UNSIGNED NOT NULL,
  organization_id INT(10) UNSIGNED NOT NULL,
  update_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  create_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  PRIMARY KEY (server_id, organization_id),
  INDEX fk_organization_id (organization_id ASC),
  INDEX fk_server_id (server_id ASC),
  CONSTRAINT fk_server_has_organization_server_id
    FOREIGN KEY (server_id)
    REFERENCES server (id)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT fk_server_has_organization_organization_id
    FOREIGN KEY (organization_id)
    REFERENCES organization (id)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
