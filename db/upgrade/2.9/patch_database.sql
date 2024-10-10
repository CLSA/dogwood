-- Patch to upgrade database to version 2.9

SET AUTOCOMMIT=0;

SOURCE custom_report.sql
SOURCE role_has_custom_report.sql
SOURCE setting.sql
SOURCE writelog.sql

SOURCE organization.sql
SOURCE user_has_organization.sql
SOURCE account.sql

SOURCE service.sql
SOURCE role_has_service.sql

SOURCE update_version_number.sql

COMMIT;
