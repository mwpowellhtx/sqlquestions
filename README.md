# SQL Questions

## Solutions Approach

I am using [WampServer](http://www.wampserver.com/en/), I do not recall which version specifically, MySQL 5.5.

I have committed the script used to generate the original tables, populate test data, and so on, as well as capture a backup from the database itself.

## Question 4 Select Candidates, their salaries, and zip codes

Consider you have a database that has three tables:

|table:|address|
|field:|id, street, zip, state|

|table:|person|
|field:|id, address_id, name|

|table:|employment_info|
|field:|id, person_id, position, salary|

What SQL statement would be necessary to pull all persons out of this database and sort from highest salary to lowest grouped by zip code.

### Solution

Creating the tables is fairly straightforward. Some decisions have to be made about capacity, desired types, lengths, widths, and that sort of thing.

``` sql
CREATE TABLE `address` (
`id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
`street` VARCHAR(256),
`zip` CHAR(10),
`state` CHAR(2)
)
```

``` sql
CREATE TABLE `person` (
`id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
`name` VARCHAR(128),
`address_id` INT NOT NULL,
FOREIGN KEY `fk_person_address` (`address_id`) REFERENCES `address` (`id`))
```

``` sql
CREATE TABLE `employment_info` (
`id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
`person_id` INT NOT NULL,
`position` VARCHAR(128),
`salary` DOUBLE,
FOREIGN KEY `fk_employment_info_person` (`person_id`) REFERENCES `person` (`id`))
```

### Populate the Test Data

Then populate the test data. Again, some decisions have to be made. Under ordinary, production circumstances, this sort of thing is being filled in via surveys, data entry procedures, things of this nature. However, for test purposes, we intentionally keep the data set small, and we expose a couple of duplicate zip codes in order to demonstrate the solution is functioning properly.

``` sql
INSERT INTO `address` (`street`, `zip`, `state`) VALUES ('123 Pine Meadow Rd', '10101', 'AL');
INSERT INTO `address` (`street`, `zip`, `state`) VALUES ('456 Forrest Brush Blvd', '10101', 'AL');
INSERT INTO `address` (`street`, `zip`, `state`) VALUES ('234 Fresh Springs Way', '21212', 'CA');
INSERT INTO `address` (`street`, `zip`, `state`) VALUES ('678 Airy Breeze Ct', '21212', 'CA');
INSERT INTO `address` (`street`, `zip`, `state`) VALUES ('345 Blue Skies Blvd', '32323', 'DE');
INSERT INTO `address` (`street`, `zip`, `state`) VALUES ('789 Ocean Spray Ln', '32323', 'DE');
INSERT INTO `address` (`street`, `zip`, `state`) VALUES ('456 Dairy Farm St', '43434', 'FL');
INSERT INTO `address` (`street`, `zip`, `state`) VALUES ('890 Cow Poke Rd', '43434', 'FL');
```

``` sql
INSERT INTO `person` (`name`, `address_id`) VALUES ('Alice', (SELECT `id` FROM `address` WHERE `street`='123 Pine Meadow Rd'));
INSERT INTO `person` (`name`, `address_id`) VALUES ('Bobby', (SELECT `id` FROM `address` WHERE `street`='456 Forrest Brush Blvd'));
INSERT INTO `person` (`name`, `address_id`) VALUES ('Charlie', (SELECT `id` FROM `address` WHERE `street`='234 Fresh Springs Way'));
INSERT INTO `person` (`name`, `address_id`) VALUES ('Daniel', (SELECT `id` FROM `address` WHERE `street`='678 Airy Breeze Ct'));
INSERT INTO `person` (`name`, `address_id`) VALUES ('Edward', (SELECT `id` FROM `address` WHERE `street`='345 Blue Skies Blvd'));
INSERT INTO `person` (`name`, `address_id`) VALUES ('Francis', (SELECT `id` FROM `address` WHERE `street`='789 Ocean Spray Ln'));
INSERT INTO `person` (`name`, `address_id`) VALUES ('George', (SELECT `id` FROM `address` WHERE `street`='456 Dairy Farm St'));
INSERT INTO `person` (`name`, `address_id`) VALUES ('Heather', (SELECT `id` FROM `address` WHERE `street`='890 Cow Poke Rd'));
```

``` sql
INSERT INTO `employment_info` (`position`, `salary`, `person_id`) VALUES ('Accountant', '49995', (SELECT `id` FROM `person` WHERE `name`='Alice'));
INSERT INTO `employment_info` (`position`, `salary`, `person_id`) VALUES ('Manager', '119250', (SELECT `id` FROM `person` WHERE `name`='Bobby'));
INSERT INTO `employment_info` (`position`, `salary`, `person_id`) VALUES ('Bus Driver', '34795', (SELECT `id` FROM `person` WHERE `name`='Charlie'));
INSERT INTO `employment_info` (`position`, `salary`, `person_id`) VALUES ('Teacher', '57495', (SELECT `id` FROM `person` WHERE `name`='Daniel'));
INSERT INTO `employment_info` (`position`, `salary`, `person_id`) VALUES ('Developer', '135795', (SELECT `id` FROM `person` WHERE `name`='Edward'));
INSERT INTO `employment_info` (`position`, `salary`, `person_id`) VALUES ('Masoner', '51235', (SELECT `id` FROM `person` WHERE `name`='Francis'));
INSERT INTO `employment_info` (`position`, `salary`, `person_id`) VALUES ('Electrician', '62345', (SELECT `id` FROM `person` WHERE `name`='Heather'));
INSERT INTO `employment_info` (`position`, `salary`, `person_id`) VALUES ('Pilot', '79795', (SELECT `id` FROM `person` WHERE `name`='George'));
```

### The Answer

Finally, once the tables have been created, and test data populated, then we may present the response:

``` sql
SELECT p.name, e.salary, a.zip
    FROM `address` a INNER JOIN `person` p ON a.id=p.address_id
        INNER JOIN `employment_info` e ON p.id=e.person_id
    ORDER BY a.zip, e.salary DESC
```

And which result yields:

|name|salary|zip|
|---|---|---|
|Bobby|119250|10101|
|Alice|49995|10101|
|Daniel|57495|21212|
|Charlie|34795|21212|
|Edward|135795|32323|
|Francis|51235|32323|
|George|79795|43434|
|Heather|62345|43434|
