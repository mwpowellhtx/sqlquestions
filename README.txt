
12:37 PM 6/13/2014

CREATE TABLE `address` (
`id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
`street` VARCHAR(256),
`zip` CHAR(10),
`state` CHAR(2))

CREATE TABLE `person` (
`id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
`name` VARCHAR(128),
`address_id` INT NOT NULL,
FOREIGN KEY `fk_person_address` (`address_id`) REFERENCES `address` (`id`))

CREATE TABLE `employment_info` (
`id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
`person_id` INT NOT NULL,
`position` VARCHAR(128),
`salary` DOUBLE,
FOREIGN KEY `fk_employment_info_person` (`person_id`) REFERENCES `person` (`id`))

INSERT INTO `address` (`street`, `zip`, `state`) VALUES ('123 Pine Meadow Rd', '10101', 'AL');
INSERT INTO `address` (`street`, `zip`, `state`) VALUES ('456 Forrest Brush Blvd', '10101', 'AL');
INSERT INTO `address` (`street`, `zip`, `state`) VALUES ('234 Fresh Springs Way', '21212', 'CA');
INSERT INTO `address` (`street`, `zip`, `state`) VALUES ('678 Airy Breeze Ct', '21212', 'CA');
INSERT INTO `address` (`street`, `zip`, `state`) VALUES ('345 Blue Skies Blvd', '32323', 'DE');
INSERT INTO `address` (`street`, `zip`, `state`) VALUES ('789 Ocean Spray Ln', '32323', 'DE');
INSERT INTO `address` (`street`, `zip`, `state`) VALUES ('456 Dairy Farm St', '43434', 'FL');
INSERT INTO `address` (`street`, `zip`, `state`) VALUES ('890 Cow Poke Rd', '43434', 'FL');

INSERT INTO `person` (`name`, `address_id`) VALUES ('Alice', (SELECT `id` FROM `address` WHERE `street`='123 Pine Meadow Rd'));
INSERT INTO `person` (`name`, `address_id`) VALUES ('Bobby', (SELECT `id` FROM `address` WHERE `street`='456 Forrest Brush Blvd'));
INSERT INTO `person` (`name`, `address_id`) VALUES ('Charlie', (SELECT `id` FROM `address` WHERE `street`='234 Fresh Springs Way'));
INSERT INTO `person` (`name`, `address_id`) VALUES ('Daniel', (SELECT `id` FROM `address` WHERE `street`='678 Airy Breeze Ct'));
INSERT INTO `person` (`name`, `address_id`) VALUES ('Edward', (SELECT `id` FROM `address` WHERE `street`='345 Blue Skies Blvd'));
INSERT INTO `person` (`name`, `address_id`) VALUES ('Francis', (SELECT `id` FROM `address` WHERE `street`='789 Ocean Spray Ln'));
INSERT INTO `person` (`name`, `address_id`) VALUES ('George', (SELECT `id` FROM `address` WHERE `street`='456 Dairy Farm St'));
INSERT INTO `person` (`name`, `address_id`) VALUES ('Heather', (SELECT `id` FROM `address` WHERE `street`='890 Cow Poke Rd'));

INSERT INTO `employment_info` (`position`, `salary`, `person_id`) VALUES ('Accountant', '49995', (SELECT `id` FROM `person` WHERE `name`='Alice'));
INSERT INTO `employment_info` (`position`, `salary`, `person_id`) VALUES ('Manager', '119250', (SELECT `id` FROM `person` WHERE `name`='Bobby'));
INSERT INTO `employment_info` (`position`, `salary`, `person_id`) VALUES ('Bus Driver', '34795', (SELECT `id` FROM `person` WHERE `name`='Charlie'));
INSERT INTO `employment_info` (`position`, `salary`, `person_id`) VALUES ('Teacher', '57495', (SELECT `id` FROM `person` WHERE `name`='Daniel'));
INSERT INTO `employment_info` (`position`, `salary`, `person_id`) VALUES ('Developer', '135795', (SELECT `id` FROM `person` WHERE `name`='Edward'));
INSERT INTO `employment_info` (`position`, `salary`, `person_id`) VALUES ('Masoner', '51235', (SELECT `id` FROM `person` WHERE `name`='Francis'));
INSERT INTO `employment_info` (`position`, `salary`, `person_id`) VALUES ('Electrician', '62345', (SELECT `id` FROM `person` WHERE `name`='Heather'));
INSERT INTO `employment_info` (`position`, `salary`, `person_id`) VALUES ('Pilot', '79795', (SELECT `id` FROM `person` WHERE `name`='George'));

SELECT p.name, e.salary, a.zip FROM `address` a INNER JOIN `person` p ON a.id=p.address_id INNER JOIN `employment_info` e ON p.id=e.person_id ORDER BY a.zip, e.salary DESC


Can you answer the following question?

Consider you have a database that has three tables:

table: address
fields: id, street, zip, state


table: person
fields: id, address_id, name


table: employment_info
fields: id, person_id, position, salary

What SQL statement would be necessary to pull all persons out of this database
and sort from highest salary to lowest grouped by zip code.

Example output:

candidate1, $zillion, 10110
candidate2, $billion, 10110
candidate3, $zillion, 40110
candidate4, $billion, 40110
candidate5, $zillion, 70110
candidate6, $billion, 70110
