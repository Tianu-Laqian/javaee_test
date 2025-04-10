/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80033 (8.0.33)
 Source Host           : localhost:3306
 Source Schema         : demo_test

 Target Server Type    : MySQL
 Target Server Version : 80033 (8.0.33)
 File Encoding         : 65001

 Date: 10/04/2025 09:13:37
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for contactperson
-- ----------------------------
DROP TABLE IF EXISTS `contactperson`;
CREATE TABLE `contactperson`  (
  `contact_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `gender` enum('男','女') CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `department` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `contact_info` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `remarks` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL,
  `created_by` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `record_count` int NULL DEFAULT 0,
  PRIMARY KEY (`contact_id`) USING BTREE,
  INDEX `customer_id`(`customer_id` ASC) USING BTREE,
  INDEX `FK_ContactPerson_TUser`(`created_by` ASC) USING BTREE,
  CONSTRAINT `contactperson_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `FK_ContactPerson_TUser` FOREIGN KEY (`created_by`) REFERENCES `tuser` (`aname`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contactperson
-- ----------------------------
INSERT INTO `contactperson` VALUES (1, 1, '李华', '男', '销售部经理', '13800000001', '联系方式有效', 'admin', 9);
INSERT INTO `contactperson` VALUES (2, 2, '张三', '男', '市场部主管', '13800000002', '', 'asir', 2);
INSERT INTO `contactperson` VALUES (3, 2, '李四', '男', '技术部经理', '13800000003', '长期联系', 'asir', 1);
INSERT INTO `contactperson` VALUES (4, 4, '王五', '女', '人事部主管', '26131223@qq.com', '', 'admin', 2);
INSERT INTO `contactperson` VALUES (5, 3, '舟程程', '男', '财务部经理', '13800000005', '近期有合作需求', 'admin', 1);
INSERT INTO `contactperson` VALUES (6, 4, '周杰纶', '男', '产品部主管', '13800000006', '正在商讨合作开发项目', 'asir', 1);
INSERT INTO `contactperson` VALUES (7, 7, 'vedal', '女', '客户服务经理', '13800000007', '', 'admin', 1);
INSERT INTO `contactperson` VALUES (8, 5, '艾叶', '男', '销售部主管', '13800000008', '合作进行中', 'admin', 1);
INSERT INTO `contactperson` VALUES (9, 6, '陈婷', '女', '法务部主管', '13800000009', '暂无备注', 'admin', 1);
INSERT INTO `contactperson` VALUES (10, 6, '维维', '男', '研发部经理', '13800000010', '长期合作', 'admin', 1);
INSERT INTO `contactperson` VALUES (11, 7, '王丽', '女', '项目管理部经理', '13800000011', NULL, 'admin', 1);
INSERT INTO `contactperson` VALUES (12, 7, '周飞翔', '男', '行政部主管', '13800000012', '参与慈善活动', 'admin', 1);
INSERT INTO `contactperson` VALUES (13, 8, '李阳', '男', '社会服务部经理', '13800000013', '', 'admin', 1);
INSERT INTO `contactperson` VALUES (14, 8, '丛苁', '女', '基金会管理部主管', '13800000014', '公益项目洽谈中', 'admin', 1);
INSERT INTO `contactperson` VALUES (15, 22, '李天天', '女', '行政部主管', '26653535@qq.com', '', 'admin', 1);
INSERT INTO `contactperson` VALUES (19, 17, '三三', '男', '行政部主管', '1380003432', 'null', 'asir', 0);
INSERT INTO `contactperson` VALUES (20, 1, '二语', '女', '播音室', '15633442266', '', 'asir', 0);
INSERT INTO `contactperson` VALUES (21, 1, '李一', '男', '行政部主管', '2665353@qq.com', 'null', 'asir', 0);

-- ----------------------------
-- Table structure for contactrecord
-- ----------------------------
DROP TABLE IF EXISTS `contactrecord`;
CREATE TABLE `contactrecord`  (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `contact_person_id` int NULL DEFAULT NULL,
  `department_contact` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `contact_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `contact_content` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL,
  `remarks` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL,
  PRIMARY KEY (`record_id`) USING BTREE,
  INDEX `contact_person_id`(`contact_person_id` ASC) USING BTREE,
  INDEX `department_contact`(`department_contact` ASC) USING BTREE,
  CONSTRAINT `contactrecord_ibfk_1` FOREIGN KEY (`contact_person_id`) REFERENCES `contactperson` (`contact_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `contactrecord_ibfk_2` FOREIGN KEY (`department_contact`) REFERENCES `tuser` (`aname`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 71 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contactrecord
-- ----------------------------
INSERT INTO `contactrecord` VALUES (41, 1, 'admin', '2025-01-04 23:50:19', '讨论了合作事宜，双方达成初步共识，期待下一步合作。联系记录测试：壬戌之秋，七月既望，苏子与客泛舟游于赤壁之下。清风徐来，水波不兴。举酒属客，诵明月之诗，歌窈窕之章。少焉，月出于东山之上，徘徊于斗牛之间。白露横江，水光接天。纵一苇之所如，凌万顷之茫然。浩浩乎如冯虚御风，而不知其所止；飘飘乎如遗世独立，羽化而登仙。', '合作潜力大');
INSERT INTO `contactrecord` VALUES (42, 2, 'admin', '2025-01-04 23:50:19', '商讨市场推广方案，讨论了新市场的开拓策略，已形成了较为完备的方案。', '方案已初步定型');
INSERT INTO `contactrecord` VALUES (43, 3, 'as546', '2025-01-04 23:50:19', '讨论了新市场的开拓策略', NULL);
INSERT INTO `contactrecord` VALUES (44, 4, 'as546', '2025-01-04 23:50:19', '确定了合作的具体细节', '有后续跟进计划');
INSERT INTO `contactrecord` VALUES (45, 5, 'asfrwe', '2025-01-04 23:50:19', '商议技术支持方案', '需要做进一步的技术对接');
INSERT INTO `contactrecord` VALUES (46, 6, 'asfrwe', '2025-01-04 23:50:19', '确认了技术测试的日期', '已安排技术支持人员');
INSERT INTO `contactrecord` VALUES (47, 7, 'asir', '2025-01-04 23:50:19', '联系记录测试：崇祯五年十二月，余住西湖。大雪三日，湖中人鸟声俱绝。是日更定矣，余挐一小舟，拥毳衣炉火，独往湖心亭看雪。雾凇沆砀，天与云与山与水，上下一白。湖上影子，惟长堤一痕、湖心亭一点、与余舟一芥、舟中人两三粒而已。到亭上，有两人铺毡对坐，一童子烧酒炉正沸。见余，大喜曰：“湖中焉得更有此人？”拉余同饮。余强饮三大白而别。问其姓氏，是金陵人，客此。及下船，舟子喃喃曰：“莫说相公痴，更有痴似相公者！', '希望尽快启动招聘');
INSERT INTO `contactrecord` VALUES (48, 8, 'asir', '2025-01-04 23:50:19', '商定了招聘流程和时间表，确保按时完成招聘，完成任务。', '确保按时完成招聘');
INSERT INTO `contactrecord` VALUES (49, 9, 'admin', '2025-01-04 23:50:19', '确认了财务结算流程', '对方已同意我们的结算条款');
INSERT INTO `contactrecord` VALUES (50, 10, 'admin', '2025-01-04 23:50:19', '商讨了税务相关问题', '税务方案已经敲定');
INSERT INTO `contactrecord` VALUES (51, 11, 'as546', '2025-01-04 23:50:19', '商讨产品改进方案', '方案正在修改中');
INSERT INTO `contactrecord` VALUES (52, 12, 'as546', '2025-01-04 23:50:19', '确认了产品测试的时间', '客户已同意测试安排');
INSERT INTO `contactrecord` VALUES (53, 13, 'asfrwe', '2025-01-04 23:50:19', '讨论了客户反馈问题', '需要进一步改进产品质量');
INSERT INTO `contactrecord` VALUES (54, 14, 'asfrwe', '2025-01-04 23:50:19', '确认了售后服务改进措施', '售后人员已安排');
INSERT INTO `contactrecord` VALUES (55, 1, 'asir', '2025-01-04 23:50:19', '商讨了新的销售合同', '合同已完成，等待签署');
INSERT INTO `contactrecord` VALUES (56, 1, 'asir', '2025-01-04 23:50:19', '确认了签约日期', '签约前沟通顺畅');
INSERT INTO `contactrecord` VALUES (57, 1, 'admin', '2025-01-04 23:50:19', '讨论了法律条款的修改', '需要再次审核合同条款');
INSERT INTO `contactrecord` VALUES (58, 1, 'admin', '2025-01-04 23:50:19', '确认了合同条款细节', '所有条款已确认');
INSERT INTO `contactrecord` VALUES (59, 1, 'as546', '2025-01-04 23:50:19', '商讨了研发计划的执行', '研发计划已启动');
INSERT INTO `contactrecord` VALUES (60, 1, 'as546', '2025-01-04 23:50:19', '确认了技术难题的解决方案', '技术问题已解决');
INSERT INTO `contactrecord` VALUES (61, 1, 'asir', '2025-01-09 23:22:24', '反馈已解决，确认完毕。', '已解决');
INSERT INTO `contactrecord` VALUES (63, 15, 'admin', '2025-01-10 13:28:17', '确认了产品测试的时间', '');
INSERT INTO `contactrecord` VALUES (65, 2, 'admin', '2025-01-17 14:26:33', '增加一条联系记录', 'null');
INSERT INTO `contactrecord` VALUES (69, 4, 'admin', '2025-01-17 15:45:20', '练习测试222', 'null');
INSERT INTO `contactrecord` VALUES (70, 1, 'asir', '2025-01-17 16:52:42', '测试1111', 'null');

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`  (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `customer_type` enum('国有企业','民营企业','外资企业','公益事业') CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `contact_count` int NULL DEFAULT 0,
  `record_count` int NULL DEFAULT 0,
  `customer_address` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL,
  `city` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `remarks` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL,
  `created_by` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  PRIMARY KEY (`customer_id`) USING BTREE,
  INDEX `FK_Customer_TUser`(`created_by` ASC) USING BTREE,
  CONSTRAINT `FK_Customer_TUser` FOREIGN KEY (`created_by`) REFERENCES `tuser` (`aname`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES (1, '中央电视台', '国有企业', 3, 9, '北京市朝阳区东三环中路32号', '北京', '重要客户', 'admin');
INSERT INTO `customer` VALUES (2, '中国移动通信集团有限公司', '国有企业', 2, 2, '北京市西城区金融大街29号', '北京', '', 'admin');
INSERT INTO `customer` VALUES (3, '奇安信科技集团股份有限公司', '民营企业', 1, 1, '北京市西城区西直门外南路26号院1号楼', '北京', '创新型企业1', 'admin');
INSERT INTO `customer` VALUES (4, '南京钢铁集团有限公司', '民营企业', 2, 2, '江苏省南京市六合区幸福路8号', '南京', '发展潜力大', 'admin');
INSERT INTO `customer` VALUES (5, '上海萨莉亚餐饮有限公司', '外资企业', 1, 1, '上海市徐汇区上中西路280号310室', '上海', '外资项目', 'asir');
INSERT INTO `customer` VALUES (6, '可口可乐', '外资企业', 2, 1, '美国佐治亚州亚特兰大市', '国外', '跨国公司', 'admin');
INSERT INTO `customer` VALUES (7, '清华大学', '公益事业', 3, 2, '北京市海淀区双清路30号', '北京', '', 'admin');
INSERT INTO `customer` VALUES (8, '北京大学', '公益事业', 2, 1, '北京市海淀区颐和园路5号', '北京', '', 'admin');
INSERT INTO `customer` VALUES (17, '华为技术有限公司', '民营企业', 1, 0, '深圳市龙岗区坂田华为总部办公楼', '深圳', '近期合作', 'asir');
INSERT INTO `customer` VALUES (22, '南京大学', '公益事业', 1, 1, '江苏省南京市鼓楼区汉口路22号', '南京', '', 'asir');
INSERT INTO `customer` VALUES (23, '南京航空航天大学', '公益事业', 0, 0, '江苏省南京市江宁区将军大道29号', '南京', '近期合作', 'admin');

-- ----------------------------
-- Table structure for trole
-- ----------------------------
DROP TABLE IF EXISTS `trole`;
CREATE TABLE `trole`  (
  `RoleID` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `RoleName` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  PRIMARY KEY (`RoleID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of trole
-- ----------------------------
INSERT INTO `trole` VALUES ('1', '普通用户');
INSERT INTO `trole` VALUES ('2', '高级用户');
INSERT INTO `trole` VALUES ('3', '网站管理员');
INSERT INTO `trole` VALUES ('4', '超级管理员');

-- ----------------------------
-- Table structure for tuser
-- ----------------------------
DROP TABLE IF EXISTS `tuser`;
CREATE TABLE `tuser`  (
  `aname` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `aword` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `realname` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `avalid` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `RoleID` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  PRIMARY KEY (`aname`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tuser
-- ----------------------------
INSERT INTO `tuser` VALUES ('admin', '123456', '管理员', '是', '4');
INSERT INTO `tuser` VALUES ('as546', '123456', '丛從', '是', '3');
INSERT INTO `tuser` VALUES ('asfrwe', '123456', '炸鸡', '是', '2');
INSERT INTO `tuser` VALUES ('asir', '123456', '小明', '是', '1');
INSERT INTO `tuser` VALUES ('cvbn', '123456', '浅羽', '是', '1');
INSERT INTO `tuser` VALUES ('dfgaew8845', '123456', '丛苁', '是', '2');
INSERT INTO `tuser` VALUES ('dfghj', '123456', '饭团', '是', '1');
INSERT INTO `tuser` VALUES ('djfhsiuf444', '123456', '煎饼', '否', '2');
INSERT INTO `tuser` VALUES ('dsjfhdius55', '123456', '炒饭', '是', '1');
INSERT INTO `tuser` VALUES ('klzx', '123456', '神木', '是', '3');
INSERT INTO `tuser` VALUES ('neuro987', '123456', '牛肉ai', '是', '1');
INSERT INTO `tuser` VALUES ('opas', '123456', '苹果', '否', '1');
INSERT INTO `tuser` VALUES ('qwer', '123456', '炒面', '是', '2');
INSERT INTO `tuser` VALUES ('shuihs', '123456', '汤面', '否', '1');
INSERT INTO `tuser` VALUES ('ssyvv', '123456', '张三', '是', '2');
INSERT INTO `tuser` VALUES ('tyui', '123456', '煎饼果子', '是', '1');
INSERT INTO `tuser` VALUES ('user01', '123456', '李泗', '是', '1');
INSERT INTO `tuser` VALUES ('user01222', '123456', '李太白', '否', '2');
INSERT INTO `tuser` VALUES ('user02', '123456', '李思', '否', '1');
INSERT INTO `tuser` VALUES ('user03', '123456', '李斯', '是', '2');
INSERT INTO `tuser` VALUES ('user04', '123456', '李司', '否', '1');
INSERT INTO `tuser` VALUES ('vedal987', '123456', '韦德', '是', '3');
INSERT INTO `tuser` VALUES ('wangwu1122', '123456', '王唔', '是', '2');
INSERT INTO `tuser` VALUES ('wangwu3438', '123456', '王舞', '是', '1');
INSERT INTO `tuser` VALUES ('wangwu8899', '123456', '王悟', '是', '1');
INSERT INTO `tuser` VALUES ('xczgfdg77', '123456', '提拉米苏', '是', '3');
INSERT INTO `tuser` VALUES ('yuiop6666', '123456', '冰激凌', '是', '2');
INSERT INTO `tuser` VALUES ('zzz3579', '123456', '正整', '是', '1');

-- ----------------------------
-- Triggers structure for table contactperson
-- ----------------------------
DROP TRIGGER IF EXISTS `update_contact_count_after_insert`;
delimiter ;;
CREATE TRIGGER `update_contact_count_after_insert` AFTER INSERT ON `contactperson` FOR EACH ROW BEGIN
    UPDATE Customer
    SET contact_count = (SELECT COUNT(*) FROM ContactPerson WHERE customer_id = NEW.customer_id)
    WHERE customer_id = NEW.customer_id;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table contactrecord
-- ----------------------------
DROP TRIGGER IF EXISTS `update_record_count_after_insert`;
delimiter ;;
CREATE TRIGGER `update_record_count_after_insert` AFTER INSERT ON `contactrecord` FOR EACH ROW BEGIN
    UPDATE Customer
    SET record_count = (SELECT COUNT(*) FROM ContactRecord WHERE contact_person_id = NEW.contact_person_id)
    WHERE customer_id = (SELECT customer_id FROM ContactPerson WHERE contact_id = NEW.contact_person_id);
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table contactrecord
-- ----------------------------
DROP TRIGGER IF EXISTS `update_record_count_after_insert2`;
delimiter ;;
CREATE TRIGGER `update_record_count_after_insert2` AFTER INSERT ON `contactrecord` FOR EACH ROW BEGIN
    -- 更新ContactPerson表中的record_count列
    UPDATE ContactPerson
    SET record_count = (SELECT COUNT(*) FROM ContactRecord WHERE contact_person_id = NEW.contact_person_id)
    WHERE contact_id = NEW.contact_person_id;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
