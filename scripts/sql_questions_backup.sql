-- phpMyAdmin SQL Dump
-- version 3.4.10.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 13, 2014 at 06:40 PM
-- Server version: 5.5.20
-- PHP Version: 5.3.10

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `sql_questions`
--
CREATE DATABASE `sql_questions` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `sql_questions`;

-- --------------------------------------------------------

--
-- Table structure for table `address`
--
-- Creation: Jun 13, 2014 at 05:48 PM
--

CREATE TABLE IF NOT EXISTS `address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `street` varchar(256) DEFAULT NULL,
  `zip` char(10) DEFAULT NULL,
  `state` char(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`id`, `street`, `zip`, `state`) VALUES
(1, '123 Pine Meadow Rd', '10101', 'AL'),
(2, '234 Fresh Springs Way', '21212', 'CA'),
(3, '345 Blue Skies Blvd', '32323', 'DE'),
(4, '456 Dairy Farm St', '43434', 'FL'),
(5, '456 Forrest Brush Blvd', '10101', 'AL'),
(6, '678 Airy Breeze Ct', '21212', 'CA'),
(7, '789 Ocean Spray Ln', '32323', 'DE'),
(8, '890 Cow Poke Rd', '43434', 'FL');

-- --------------------------------------------------------

--
-- Table structure for table `employment_info`
--
-- Creation: Jun 13, 2014 at 05:57 PM
--

CREATE TABLE IF NOT EXISTS `employment_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL,
  `position` varchar(128) DEFAULT NULL,
  `salary` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_employment_info_person` (`person_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `employment_info`
--

INSERT INTO `employment_info` (`id`, `person_id`, `position`, `salary`) VALUES
(1, 1, 'Accountant', 49995),
(2, 2, 'Manager', 119250),
(3, 3, 'Bus Driver', 34795),
(4, 4, 'Teacher', 57495),
(5, 5, 'Developer', 135795),
(6, 6, 'Masoner', 51235),
(7, 8, 'Electrician', 62345),
(8, 7, 'Pilot', 79795);

-- --------------------------------------------------------

--
-- Table structure for table `person`
--
-- Creation: Jun 13, 2014 at 05:55 PM
--

CREATE TABLE IF NOT EXISTS `person` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `address_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_person_address` (`address_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `person`
--

INSERT INTO `person` (`id`, `name`, `address_id`) VALUES
(1, 'Alice', 1),
(2, 'Bobby', 5),
(3, 'Charlie', 2),
(4, 'Daniel', 6),
(5, 'Edward', 3),
(6, 'Francis', 7),
(7, 'George', 4),
(8, 'Heather', 8);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `employment_info`
--
ALTER TABLE `employment_info`
  ADD CONSTRAINT `employment_info_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`);

--
-- Constraints for table `person`
--
ALTER TABLE `person`
  ADD CONSTRAINT `person_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
