/*
Navicat MySQL Data Transfer

Source Server         : mysql5.6
Source Server Version : 50620
Source Host           : localhost:3306
Source Database       : print_db

Target Server Type    : MYSQL
Target Server Version : 50620
File Encoding         : 65001

Date: 2020-06-05 15:21:43
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a');

-- ----------------------------
-- Table structure for `t_notice`
-- ----------------------------
DROP TABLE IF EXISTS `t_notice`;
CREATE TABLE `t_notice` (
  `noticeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告id',
  `title` varchar(80) NOT NULL COMMENT '标题',
  `content` varchar(800) NOT NULL COMMENT '公告内容',
  `publishDate` varchar(20) DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`noticeId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_notice
-- ----------------------------
INSERT INTO `t_notice` VALUES ('1', '小程序打印平台成立', '各位同学，欢迎来这里寻找打印店打印你的资料！', '2020-05-10 18:05:00');
INSERT INTO `t_notice` VALUES ('2', '打印多多，实惠多多', '大家多多来打印，我们入住的都是最实惠的打印店', '2020-05-14 00:12:34');

-- ----------------------------
-- Table structure for `t_orderinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_orderinfo`;
CREATE TABLE `t_orderinfo` (
  `orderId` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单编号',
  `productObj` int(11) NOT NULL COMMENT '打印套餐',
  `orderNum` int(11) NOT NULL COMMENT '订单数量',
  `totalMoney` float NOT NULL COMMENT '订单总金额',
  `payWay` varchar(20) NOT NULL COMMENT '支付方式',
  `orderStateObj` varchar(20) NOT NULL COMMENT '订单状态',
  `receiveName` varchar(20) NOT NULL COMMENT '收货人',
  `telephone` varchar(20) NOT NULL COMMENT '收货人电话',
  `address` varchar(80) NOT NULL COMMENT '收货人地址',
  `orderMemo` varchar(500) DEFAULT NULL COMMENT '订单备注',
  `userObj` varchar(30) NOT NULL COMMENT '下单用户',
  `orderTime` varchar(20) DEFAULT NULL COMMENT '下单时间',
  PRIMARY KEY (`orderId`),
  KEY `productObj` (`productObj`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_orderinfo_ibfk_1` FOREIGN KEY (`productObj`) REFERENCES `t_product` (`productId`),
  CONSTRAINT `t_orderinfo_ibfk_2` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_orderinfo
-- ----------------------------
INSERT INTO `t_orderinfo` VALUES ('1', '1', '2', '20', '微信', '已下单', '李晓彤', '13985012083', '芙蓉8宿舍224寝室', '快递打印吧', '13910831234', '2020-05-10 11:20:11');
INSERT INTO `t_orderinfo` VALUES ('2', '2', '2', '30', '支付宝', '已下单', '黄小琥', '13980224234', '香樟小区4栋1203', '快哦', '13688886666', '2020-05-12 23:08:56');
INSERT INTO `t_orderinfo` VALUES ('3', '3', '3', '36', '支付宝', '送货中', '李明堂', '13598010834', '南校区12宿舍', '来吧', '13688886666', '2020-05-13 00:34:00');

-- ----------------------------
-- Table structure for `t_printshop`
-- ----------------------------
DROP TABLE IF EXISTS `t_printshop`;
CREATE TABLE `t_printshop` (
  `shopUserName` varchar(30) NOT NULL COMMENT 'shopUserName',
  `password` varchar(30) NOT NULL COMMENT '登录密码',
  `shopName` varchar(20) NOT NULL COMMENT '打印店名称',
  `shopPhoto` varchar(60) NOT NULL COMMENT '打印店照片',
  `shopDesc` varchar(800) NOT NULL COMMENT '打印店介绍',
  `bornDate` varchar(20) DEFAULT NULL COMMENT '成立日期',
  `connectPerson` varchar(50) NOT NULL COMMENT '联系人',
  `telephone` varchar(20) NOT NULL COMMENT '联系电话',
  `address` varchar(80) DEFAULT NULL COMMENT '打印店地址',
  PRIMARY KEY (`shopUserName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_printshop
-- ----------------------------
INSERT INTO `t_printshop` VALUES ('shop1', '123', '雨音打印店', 'upload/5767e463-6ee1-427f-b542-28ef08f72019.jpg', '打印请帖，彩色名片，上网打印', '2020-05-05', '黄先生', '13420182861', '滨江路10号');
INSERT INTO `t_printshop` VALUES ('shop2', '123', '图文快印店', 'upload/0ae397e9-fbaf-43b7-a422-07f130749793.jpg', '证件快照，冲洗照片，宣传彩页，名片证卡，喷绘写真，高速复印', '2020-05-13', '张先生', '13784504082', '红星路10号');

-- ----------------------------
-- Table structure for `t_product`
-- ----------------------------
DROP TABLE IF EXISTS `t_product`;
CREATE TABLE `t_product` (
  `productId` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `productClassObj` int(11) NOT NULL COMMENT '套餐类别',
  `productName` varchar(50) NOT NULL COMMENT '服务名称',
  `mainPhoto` varchar(60) NOT NULL COMMENT '服务图片',
  `price` float NOT NULL COMMENT '套餐价格',
  `productDesc` varchar(800) NOT NULL COMMENT '服务描述',
  `printShopObj` varchar(30) NOT NULL COMMENT '打印店',
  `addTime` varchar(20) DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`productId`),
  KEY `productClassObj` (`productClassObj`),
  KEY `printShopObj` (`printShopObj`),
  CONSTRAINT `t_product_ibfk_1` FOREIGN KEY (`productClassObj`) REFERENCES `t_productclass` (`classId`),
  CONSTRAINT `t_product_ibfk_2` FOREIGN KEY (`printShopObj`) REFERENCES `t_printshop` (`shopUserName`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_product
-- ----------------------------
INSERT INTO `t_product` VALUES ('1', '1', '身份证打印', 'upload/fa89d46f-c4f1-4906-a49f-6aecec0599c9.jpg', '10', '身份证正反面打印', 'shop1', '2020-05-10 18:04:04');
INSERT INTO `t_product` VALUES ('2', '1', '户口簿打印', 'upload/b00e5d4d-3814-4dd4-8366-587f5a902d0b.jpg', '15', '户口簿A4打印', 'shop1', '2020-05-11 00:10:47');
INSERT INTO `t_product` VALUES ('3', '2', '名片打印', 'upload/f42e7a89-05b9-4989-96ed-8a2dc1d2eb6b.jpg', '12', '各种广告打印，名片打印', 'shop2', '2020-05-12 23:51:17');

-- ----------------------------
-- Table structure for `t_productclass`
-- ----------------------------
DROP TABLE IF EXISTS `t_productclass`;
CREATE TABLE `t_productclass` (
  `classId` int(11) NOT NULL AUTO_INCREMENT COMMENT '类别id',
  `className` varchar(40) NOT NULL COMMENT '类别名称',
  `classDesc` varchar(500) NOT NULL COMMENT '类别描述',
  PRIMARY KEY (`classId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_productclass
-- ----------------------------
INSERT INTO `t_productclass` VALUES ('1', '证件快印', '各种证件打印');
INSERT INTO `t_productclass` VALUES ('2', '广告打印', '各种广告卡片打印');

-- ----------------------------
-- Table structure for `t_userinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_userinfo`;
CREATE TABLE `t_userinfo` (
  `user_name` varchar(30) NOT NULL COMMENT 'user_name',
  `password` varchar(30) NOT NULL COMMENT '登录密码',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `gender` varchar(4) NOT NULL COMMENT '性别',
  `birthDate` varchar(20) DEFAULT NULL COMMENT '出生日期',
  `userPhoto` varchar(60) NOT NULL COMMENT '用户照片',
  `telephone` varchar(20) NOT NULL COMMENT '联系电话',
  `email` varchar(50) NOT NULL COMMENT '邮箱',
  `address` varchar(80) DEFAULT NULL COMMENT '家庭地址',
  `regTime` varchar(20) DEFAULT NULL COMMENT '注册时间',
  `openid` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_userinfo
-- ----------------------------
INSERT INTO `t_userinfo` VALUES ('13688886666', '--', '鼠鼠', '男', '2020-01-01', 'upload/4b68b224b63d4c92a9e63916ebf1ca1f', '13688886666', '--', '--', '2020-05-10 23:14:39', 'oM7Mu5XyeVJSc8roaUCRlcz_IP9k');
INSERT INTO `t_userinfo` VALUES ('13910831234', '123', '张若曦', '女', '2020-05-06', 'upload/9e6cca88-d7c6-46df-8eb4-5a9dd12840a5.jpg', '13910831234', 'wagnxiagging@126.com', '四川成都红星路', '2020-05-10 18:00:45', null);
