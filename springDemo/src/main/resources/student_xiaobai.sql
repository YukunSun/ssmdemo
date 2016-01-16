/*
Navicat MySQL Data Transfer

Source Server         : mysql--1
Source Server Version : 50045
Source Host           : localhost:3306
Source Database       : student_xiaobai

Target Server Type    : MYSQL
Target Server Version : 50045
File Encoding         : 65001

Date: 2016-01-16 00:33:26
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `sid` bigint(20) NOT NULL auto_increment COMMENT '主键id',
  `name` varchar(225) NOT NULL,
  `password` varchar(255) NOT NULL,
  `age` int(11) NOT NULL,
  `sex` varchar(20) NOT NULL,
  `address` varchar(255) NOT NULL,
  `come_time` datetime NOT NULL COMMENT '注册时间',
  PRIMARY KEY  (`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('38', 'ssssss', 'af15d5fdacd5fdfea300e88a8e253e82', '12', '男', 'ssssss', '2015-12-27 00:00:00');
INSERT INTO `user` VALUES ('39', 'dff', 'af15d5fdacd5fdfea300e88a8e253e82', '54', '男', 'ssssss', '2015-12-27 00:00:00');
INSERT INTO `user` VALUES ('40', '小明', 'a64957cb919e442a72250d8128e9928a', '45', '男', '上海市黄浦区', '2015-12-28 00:00:00');
INSERT INTO `user` VALUES ('41', 't', 'e10adc3949ba59abbe56e057f20f883e', '13', '女', '123456', '2016-01-05 00:00:00');
