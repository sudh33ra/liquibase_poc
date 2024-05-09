-- liquibase formatted sql
-- changeset author:changesetid
CREATE TABLE test_table (id INT AUTO_INCREMENT NOT NULL, mycol0 VARCHAR(40) NOT NULL, mycol1 VARCHAR(40) NOT NULL, mycol2 VARCHAR(3) DEFAULT 'foo' NOT NULL, CONSTRAINT PK_G_forkey1 PRIMARY KEY (id));
