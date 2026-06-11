CREATE TABLE account (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  update_timestamp timestamp NOT NULL DEFAULT current_timestamp()
    ON UPDATE current_timestamp(),
  create_timestamp timestamp NOT NULL DEFAULT current_timestamp(),
  organization_id int(10) unsigned NOT NULL,
  username varchar(45) NOT NULL,
  password varchar(255) NOT NULL,
  password_type enum('whirlpool','bcrypt') DEFAULT NULL,
  email varchar(255) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_organization_id_name (organization_id,username),
  KEY fk_organization_id (organization_id),
  CONSTRAINT fk_user_organization_id
    FOREIGN KEY (organization_id)
    REFERENCES organization (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;