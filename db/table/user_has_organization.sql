CREATE TABLE user_has_organization (
  user_id INT(10) UNSIGNED NOT NULL,
  organization_id INT(10) UNSIGNED NOT NULL,
  update_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  create_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  PRIMARY KEY (user_id, organization_id),
  INDEX fk_organization_id (organization_id ASC),
  INDEX fk_user_id (user_id ASC),
  CONSTRAINT fk_user_has_organization_user_id
    FOREIGN KEY (user_id)
    REFERENCES cenozo.user (id)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT fk_user_has_organization_organization_id
    FOREIGN KEY (organization_id)
    REFERENCES dogwood.organization (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;
