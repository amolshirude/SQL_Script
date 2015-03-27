/*
SQLyog Community v8.55 
MySQL - 5.0.27-community-nt : Database - liferay4me
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`liferay4me` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `liferay4me`;

/*Table structure for table `t_admin_info` */

DROP TABLE IF EXISTS `t_admin_info`;

CREATE TABLE `t_admin_info` (
  `Admin_Id` int(25) NOT NULL,
  `Organization_Id` int(25) NOT NULL,
  `Email_Id` varchar(30) NOT NULL,
  `Password` varchar(25) NOT NULL,
  `Reg_Date_Time` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `Last_Login_Date_Time` timestamp NOT NULL default '0000-00-00 00:00:00',
  `Dept_Id` varchar(25) NOT NULL,
  `Validity_date` timestamp NOT NULL default '0000-00-00 00:00:00',
  `Is_Active` varchar(5) NOT NULL,
  PRIMARY KEY  (`Admin_Id`),
  KEY `Organization_Id` (`Organization_Id`),
  CONSTRAINT `t_admin_info_ibfk_1` FOREIGN KEY (`Organization_Id`) REFERENCES `t_org_info` (`Organization_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_admin_info` */

LOCK TABLES `t_admin_info` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_campaign` */

DROP TABLE IF EXISTS `t_campaign`;

CREATE TABLE `t_campaign` (
  `Campaign_Id` int(10) NOT NULL,
  `Campaign_Name` varchar(25) NOT NULL,
  `Admin_Id` int(25) NOT NULL,
  `Start_Date` date NOT NULL,
  `End_Date` date NOT NULL,
  `Notify_Freqency` int(5) NOT NULL,
  PRIMARY KEY  (`Campaign_Id`),
  KEY `Admin_Id` (`Admin_Id`),
  CONSTRAINT `t_campaign_ibfk_1` FOREIGN KEY (`Admin_Id`) REFERENCES `t_admin_info` (`Admin_Id`),
  CONSTRAINT `t_campaign_ibfk_2` FOREIGN KEY (`Admin_Id`) REFERENCES `t_admin_info` (`Admin_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_campaign` */

LOCK TABLES `t_campaign` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_campaign_category` */

DROP TABLE IF EXISTS `t_campaign_category`;

CREATE TABLE `t_campaign_category` (
  `Campaign_Id` int(10) NOT NULL,
  `Category` varchar(25) NOT NULL,
  `As_Active` varchar(10) NOT NULL,
  KEY `Campaign_Id` (`Campaign_Id`),
  CONSTRAINT `t_campaign_category_ibfk_1` FOREIGN KEY (`Campaign_Id`) REFERENCES `t_campaign` (`Campaign_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_campaign_category` */

LOCK TABLES `t_campaign_category` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_comment_opinion` */

DROP TABLE IF EXISTS `t_comment_opinion`;

CREATE TABLE `t_comment_opinion` (
  `Comment_Id` int(10) NOT NULL,
  `user_Id` int(10) NOT NULL,
  `Opinion` int(2) NOT NULL,
  KEY `FK_CommentId` (`Comment_Id`),
  KEY `FK_user3Id` (`user_Id`),
  CONSTRAINT `FK_CommentId` FOREIGN KEY (`Comment_Id`) REFERENCES `t_idea_comment` (`Comment_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_user3Id` FOREIGN KEY (`user_Id`) REFERENCES `t_user_info` (`User_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_comment_opinion` */

LOCK TABLES `t_comment_opinion` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_dept_campaign` */

DROP TABLE IF EXISTS `t_dept_campaign`;

CREATE TABLE `t_dept_campaign` (
  `Campaign_Id` int(10) NOT NULL,
  `Dept_Id` int(10) NOT NULL,
  KEY `FK_campaignId` (`Campaign_Id`),
  KEY `FK_deptId` (`Dept_Id`),
  CONSTRAINT `FK_Campaign_Id` FOREIGN KEY (`Campaign_Id`) REFERENCES `t_campaign` (`Campaign_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_deptId` FOREIGN KEY (`Dept_Id`) REFERENCES `t_dept_info` (`Dept_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_dept_campaign` */

LOCK TABLES `t_dept_campaign` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_dept_info` */

DROP TABLE IF EXISTS `t_dept_info`;

CREATE TABLE `t_dept_info` (
  `Dept_Id` int(10) NOT NULL,
  `Dept_Name` varchar(25) NOT NULL,
  PRIMARY KEY  (`Dept_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_dept_info` */

LOCK TABLES `t_dept_info` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_idea_comment` */

DROP TABLE IF EXISTS `t_idea_comment`;

CREATE TABLE `t_idea_comment` (
  `Idea_Id` int(10) default NULL,
  `Comment_Id` int(10) NOT NULL,
  `Comment_Text` varchar(100) NOT NULL,
  `User_Id` int(10) NOT NULL,
  `Parent_Comment_Id` int(10) NOT NULL,
  `Like_Count` int(10) NOT NULL,
  `Dislike_count` int(10) NOT NULL,
  `Comment_Date` date NOT NULL,
  `Last_Updated_Date` date NOT NULL,
  PRIMARY KEY  (`Comment_Id`),
  KEY `FK_Idea1Id` (`Idea_Id`),
  KEY `FK_user2Id` (`User_Id`),
  CONSTRAINT `FK_Idea1Id` FOREIGN KEY (`Idea_Id`) REFERENCES `t_ideas` (`Idea_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_user2Id` FOREIGN KEY (`User_Id`) REFERENCES `t_user_info` (`User_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_idea_comment` */

LOCK TABLES `t_idea_comment` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_ideas` */

DROP TABLE IF EXISTS `t_ideas`;

CREATE TABLE `t_ideas` (
  `Idea_Id` int(10) NOT NULL,
  `Idea_Name` varchar(25) NOT NULL,
  `Idea_Description` int(10) NOT NULL,
  `Idea_Tags` varchar(15) default NULL,
  `User_Id` int(15) NOT NULL,
  `Team_Id` int(5) NOT NULL,
  `Sub_Date_Time` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `Last_Update_Date_Time` timestamp NOT NULL default '0000-00-00 00:00:00',
  `Like_Count` int(5) default NULL,
  `Dislike_Count` int(5) default NULL,
  `Rating` int(5) default NULL,
  `Activate` varchar(5) NOT NULL,
  PRIMARY KEY  (`Idea_Id`),
  KEY `FK_user_Id` (`User_Id`),
  KEY `FK_team_Id` (`Team_Id`),
  CONSTRAINT `FK_team_Id` FOREIGN KEY (`Team_Id`) REFERENCES `t_ideas_team` (`Team_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_user_Id` FOREIGN KEY (`User_Id`) REFERENCES `t_user_info` (`User_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_ideas` */

LOCK TABLES `t_ideas` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_ideas_member` */

DROP TABLE IF EXISTS `t_ideas_member`;

CREATE TABLE `t_ideas_member` (
  `Idea_Id` int(10) NOT NULL,
  `User_Id` int(25) NOT NULL,
  KEY `FK_Idea3Id` (`Idea_Id`),
  KEY `FK_user4Id` (`User_Id`),
  CONSTRAINT `FK_Idea3Id` FOREIGN KEY (`Idea_Id`) REFERENCES `t_ideas` (`Idea_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_user4Id` FOREIGN KEY (`User_Id`) REFERENCES `t_user_info` (`User_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_ideas_member` */

LOCK TABLES `t_ideas_member` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_ideas_opinion` */

DROP TABLE IF EXISTS `t_ideas_opinion`;

CREATE TABLE `t_ideas_opinion` (
  `Idea_Id` int(10) NOT NULL,
  `User_Id` int(10) NOT NULL,
  `Opinion` int(2) NOT NULL,
  `Star_Rating` int(5) NOT NULL,
  KEY `FK_IdeaId` (`Idea_Id`),
  KEY `FK_user1Id` (`User_Id`),
  CONSTRAINT `FK_IdeaId` FOREIGN KEY (`Idea_Id`) REFERENCES `t_ideas` (`Idea_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_user1Id` FOREIGN KEY (`User_Id`) REFERENCES `t_user_info` (`User_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_ideas_opinion` */

LOCK TABLES `t_ideas_opinion` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_ideas_team` */

DROP TABLE IF EXISTS `t_ideas_team`;

CREATE TABLE `t_ideas_team` (
  `Team_Id` int(10) NOT NULL,
  `Team_Name` varchar(15) NOT NULL,
  `Creation_Date` date NOT NULL,
  PRIMARY KEY  (`Team_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_ideas_team` */

LOCK TABLES `t_ideas_team` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_org_info` */

DROP TABLE IF EXISTS `t_org_info`;

CREATE TABLE `t_org_info` (
  `Organization_Id` int(25) NOT NULL,
  `Organization_Name` varchar(25) NOT NULL,
  `Email_Id` varchar(25) NOT NULL,
  `Contact_No` int(15) NOT NULL,
  `Location` varchar(20) NOT NULL,
  `No_Of_Users` int(5) NOT NULL,
  `Registration_date_Time` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `Trial_Period_EndDate_Time` timestamp NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`Organization_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_org_info` */

LOCK TABLES `t_org_info` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_team_member` */

DROP TABLE IF EXISTS `t_team_member`;

CREATE TABLE `t_team_member` (
  `Team_Id` int(10) NOT NULL,
  `User_Id` int(25) NOT NULL,
  KEY `FK_teamId` (`Team_Id`),
  KEY `FK_userId` (`User_Id`),
  CONSTRAINT `FK_teamId` FOREIGN KEY (`Team_Id`) REFERENCES `t_ideas_team` (`Team_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_userId` FOREIGN KEY (`User_Id`) REFERENCES `t_user_info` (`User_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_team_member` */

LOCK TABLES `t_team_member` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_user_info` */

DROP TABLE IF EXISTS `t_user_info`;

CREATE TABLE `t_user_info` (
  `User_Id` int(25) NOT NULL,
  `Organization_Id` int(25) NOT NULL,
  `Email_Id` varchar(30) NOT NULL,
  `Password` varchar(25) NOT NULL,
  `Reg_Date_Time` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `Last_login_Date_Time` timestamp NOT NULL default '0000-00-00 00:00:00',
  `Dept_Id` varchar(25) NOT NULL,
  `Validity_Date` timestamp NOT NULL default '0000-00-00 00:00:00',
  `Is_Active` varchar(5) NOT NULL,
  PRIMARY KEY  (`User_Id`),
  KEY `Organization_Id` (`Organization_Id`),
  CONSTRAINT `t_user_info_ibfk_1` FOREIGN KEY (`Organization_Id`) REFERENCES `t_org_info` (`Organization_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_user_info` */

LOCK TABLES `t_user_info` WRITE;

UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
