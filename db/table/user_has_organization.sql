CREATE TABLE user_has_organization (
  user_id int(10) unsigned NOT NULL,
  organization_id int(10) unsigned NOT NULL,
  update_timestamp timestamp NOT NULL DEFAULT current_timestamp()
    ON UPDATE current_timestamp(),
  create_timestamp timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (user_id,organization_id),
  KEY fk_organization_id (organization_id),
  KEY fk_user_id (user_id),
  CONSTRAINT fk_user_has_organization_organization_id
    FOREIGN KEY (organization_id)
    REFERENCES organization (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_user_has_organization_user_id
    FOREIGN KEY (user_id)
    REFERENCES cenozo.user (id)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;