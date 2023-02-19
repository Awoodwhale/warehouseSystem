/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.7.26 : Database - warehouse_system
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`warehouse_system` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `warehouse_system`;

/*Table structure for table `tb_bill` */

DROP TABLE IF EXISTS `tb_bill`;

CREATE TABLE `tb_bill` (
  `id` varchar(20) NOT NULL COMMENT '台账id',
  `warehouse_id` varchar(20) NOT NULL COMMENT '仓库id',
  `operation` varchar(1) NOT NULL COMMENT '借贷属性，0表示借，1表示贷',
  `item_id` varchar(20) NOT NULL COMMENT '商品id',
  `item_deal_count` int(11) NOT NULL COMMENT '商品交易数量',
  `is_dispatch` varchar(1) NOT NULL COMMENT '1表示仓库调度，0表示供货商交易',
  `direction_id` varchar(20) NOT NULL COMMENT '货物来源/去向，通过借贷、是否是仓库调度决定',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `fk_on_warehouse_id_2` (`warehouse_id`),
  KEY `fk_on_item_id_2` (`item_id`),
  KEY `fk_on_direction_id_2` (`direction_id`),
  CONSTRAINT `fk_on_item_id_2` FOREIGN KEY (`item_id`) REFERENCES `tb_item` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_on_warehouse_id_2` FOREIGN KEY (`warehouse_id`) REFERENCES `tb_warehouse_info` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `tb_bill` */

insert  into `tb_bill`(`id`,`warehouse_id`,`operation`,`item_id`,`item_deal_count`,`is_dispatch`,`direction_id`,`create_time`,`update_time`) values ('977157146128941056','975724961236779008','0','976216735440961536',100,'0','976150368083771392','2022-05-20 10:33:35','2022-05-20 10:33:38'),('977157605283594240','975724961236779008','1','976216735440961536',50,'0','976627164789080064','2022-05-20 10:35:26','2022-05-20 10:35:27'),('977157898046013440','975724961236779008','1','976216735440961536',10,'1','976627048929820672','2022-05-20 10:36:36','2022-05-20 10:36:37'),('977944438045147136','977887848797569024','0','977942596733108224',114,'0','977932619465359360','2022-05-22 14:41:47','2022-05-22 14:42:03'),('977945253971492864','977887848797569024','1','977942596733108224',100,'0','976150368083771392','2022-05-22 14:45:11','2022-05-22 14:45:17'),('977947115957256192','977887848797569024','1','977942596733108224',5,'1','977158285851361280','2022-05-22 14:52:34','2022-05-22 14:52:41');

/*Table structure for table `tb_item` */

DROP TABLE IF EXISTS `tb_item`;

CREATE TABLE `tb_item` (
  `id` varchar(20) NOT NULL COMMENT '商品id',
  `item_name` varchar(32) NOT NULL COMMENT '商品名称',
  `item_price` double NOT NULL COMMENT '商品价格',
  `state` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `tb_item` */

insert  into `tb_item`(`id`,`item_name`,`item_price`,`state`,`create_time`,`update_time`) values ('958717483273947090','破伤风疫苗',899,1,'2022-05-16 19:02:51','2022-12-09 18:31:49'),('958717483273947091','抗原自测试剂',2999,1,'2022-05-16 19:02:59','2022-12-09 18:31:22'),('958717483273947092','核酸检测试剂',214,1,'2022-05-16 19:03:03','2022-12-09 18:31:13'),('976216735440961536','测试材料',114.51,1,'2022-05-17 20:16:46','2022-05-18 15:04:18'),('976624498738462720','测试材料2',2000,1,'2022-05-18 23:17:05','2022-05-20 09:45:44'),('977159177912713216','test3',1000,1,'2022-05-20 10:41:42','2022-05-20 10:41:50'),('977942596733108224','新冠疫苗',114514,1,'2022-05-22 14:34:44','2022-12-09 18:32:16');

/*Table structure for table `tb_supplier` */

DROP TABLE IF EXISTS `tb_supplier`;

CREATE TABLE `tb_supplier` (
  `id` varchar(20) NOT NULL COMMENT '供货商id',
  `supplier_name` varchar(32) NOT NULL COMMENT '供货商名称',
  `supplier_address` varchar(32) NOT NULL COMMENT '供货商住址',
  `supplier_email` varchar(32) NOT NULL COMMENT '供货商邮箱',
  `state` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `tb_supplier` */

insert  into `tb_supplier`(`id`,`supplier_name`,`supplier_address`,`supplier_email`,`state`,`create_time`,`update_time`) values ('958717483273946089','西江公司','江西省九江市浔阳区开发区大道588号','xijiang@163.com',0,'2022-05-16 18:48:23','2022-05-16 18:48:23'),('958717483273946090','北田公司','湖北省武汉市孝感区寻滨大道366号','beiqi@yeah.net',1,'2022-05-16 18:48:23','2022-05-17 15:52:23'),('958717483273946091','上南公司','浙江省金华市婺城区爱国路355号','shangnan@foxmail.net',0,'2022-05-16 18:48:23','2022-05-16 18:48:23'),('976150368083771392','测试供货商','浙江省金华市婺城区浙师大','1234@zjun.cn',1,'2022-05-17 15:53:03','2022-05-20 10:41:12'),('976627164789080064','测试供货商2','测试供货商2','测试供货商2',1,'2022-05-18 23:27:40','2022-05-18 23:27:40'),('977158892259639296','test3','test3','test3@qq.com',1,'2022-05-20 10:40:34','2022-05-20 10:40:34'),('977932619465359360','测试供货商4','浙江省金华市婺城区迎宾大道688号','test3@qq.com',1,'2022-05-22 13:55:05','2022-05-22 14:08:50');

/*Table structure for table `tb_warehouse_info` */

DROP TABLE IF EXISTS `tb_warehouse_info`;

CREATE TABLE `tb_warehouse_info` (
  `id` varchar(20) NOT NULL COMMENT '仓库id',
  `warehouse_name` varchar(32) NOT NULL COMMENT '仓库名称',
  `warehouse_address` varchar(32) NOT NULL COMMENT '仓库地址',
  `warehouse_email` varchar(32) NOT NULL COMMENT '仓库联系邮箱',
  `state` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `tb_warehouse_info` */

insert  into `tb_warehouse_info`(`id`,`warehouse_name`,`warehouse_address`,`warehouse_email`,`state`,`create_time`,`update_time`) values ('958717483273945088','洋外大仓','江西省九江市庐山区庐山路777号','yangwai@163.com',0,'2022-05-16 18:49:19','2022-05-16 18:49:19'),('958717483273945089','泸州大仓','浙江省金华市婺城区冰湖路333号','luzhou@163.com',0,'2022-05-16 18:49:19','2022-05-16 18:49:19'),('958717483273945090','起为大仓','浙江省金华市金东区人民路778号','qiwei@163.com',0,'2022-05-16 18:49:19','2022-05-16 22:29:01'),('975721933561659392','羊鲸大仓','湖北省武汉市孝感县柴桑路114号','sheepwoods@qq.com',0,'2022-05-16 18:49:19','2022-05-16 18:49:19'),('975722235736096768','木角大仓','江西省赣州市赣县寻阳路799号','mujio@163.com',0,'2022-04-01 18:49:19','2022-05-16 19:09:55'),('975724961236779008','测试仓库','测试仓库','测试仓库',0,'2022-05-16 18:49:19','2022-05-18 23:26:57'),('976627048929820672','测试仓库2','浙江省金华市金东区人民路778号','1234@163.com',1,'2022-05-18 23:27:13','2022-05-20 10:38:24'),('977158285851361280','test3','test3','test3@qq.com',1,'2022-05-20 10:38:10','2022-05-20 10:38:10'),('977887848797569024','测试仓库114','浙江省金华市婺城区迎宾大道114号','test@qq.com',1,'2022-05-22 10:57:11','2022-05-22 11:00:20');

/*Table structure for table `tb_warehouse_item` */

DROP TABLE IF EXISTS `tb_warehouse_item`;

CREATE TABLE `tb_warehouse_item` (
  `id` varchar(20) NOT NULL COMMENT 'id',
  `item_id` varchar(20) NOT NULL COMMENT '商品id',
  `item_count` int(11) NOT NULL COMMENT '实时商品数量',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `fk_on_item_id` (`item_id`),
  CONSTRAINT `fk_on_item_id` FOREIGN KEY (`item_id`) REFERENCES `tb_item` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_on_warehouse_ids` FOREIGN KEY (`id`) REFERENCES `tb_warehouse_info` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `tb_warehouse_item` */

insert  into `tb_warehouse_item`(`id`,`item_id`,`item_count`,`create_time`,`update_time`) values ('975724961236779008','976216735440961536',40,'2022-05-20 10:33:38','2022-05-20 10:36:37'),('976627048929820672','976216735440961536',10,'2022-05-20 10:36:37','2022-05-20 10:36:37'),('977158285851361280','977942596733108224',5,'2022-05-22 14:52:41','2022-05-22 14:52:41'),('977887848797569024','977942596733108224',9,'2022-05-22 14:42:03','2022-05-22 14:52:41');

/* Trigger structure for table `tb_bill` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `bill_update` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `bill_update` AFTER INSERT ON `tb_bill` FOR EACH ROW 
BEGIN 
    SELECT COUNT(id) INTO @warehouse_id_count FROM tb_warehouse_item WHERE tb_warehouse_item.id = new.warehouse_id AND tb_warehouse_item.item_id = new.item_id;	# 查询tb_warehouse_item表中是否有该货物数据，如果没有就无法进行 
	IF (new.operation = '1' AND new.is_dispatch = '0')	# 贷货，把货物给某个供应商 
	THEN	# 仓库中的库存会减少，此时的direction_id是一个供货商id 
        IF (@warehouse_id_count > 0)	# 只有tb_warehouse_item表中有该数据，才可以执行 
        THEN 
            UPDATE tb_warehouse_item SET tb_warehouse_item.item_count = tb_warehouse_item.item_count - new.item_deal_count, tb_warehouse_item.update_time = NOW() WHERE tb_warehouse_item.id = new.warehouse_id AND tb_warehouse_item.item_id = new.item_id;	# 仓库中的材料相应减少，数据合法层面由JDBC来判断 
        END IF; 
	ELSEIF (new.operation = '1' AND new.is_dispatch = '1')	# 贷货，把货物调给某个仓库 
	THEN # 一个仓库的库存减少，一个仓库的库存增加，此时的direction_id是一个仓库id 
		SELECT COUNT(id) INTO @dispatch_ware_house_id_count FROM tb_warehouse_item WHERE tb_warehouse_item.id = new.direction_id AND tb_warehouse_item.item_id = new.item_id;	# 查询被给予货物的仓库是否存在 
		IF (@warehouse_id_count > 0 AND @dispatch_ware_house_id_count > 0)	# 两个仓库都有数据的清空 
		THEN	# 直接更新两个仓库的库存 
            UPDATE tb_warehouse_item SET tb_warehouse_item.item_count = tb_warehouse_item.item_count - new.item_deal_count, tb_warehouse_item.update_time = NOW() WHERE tb_warehouse_item.id = new.warehouse_id AND tb_warehouse_item.item_id = new.item_id; 
            UPDATE tb_warehouse_item SET tb_warehouse_item.item_count = tb_warehouse_item.item_count + new.item_deal_count, tb_warehouse_item.update_time = NOW() WHERE tb_warehouse_item.id = new.direction_id AND tb_warehouse_item.item_id = new.item_id; 
        ELSEIF (@warehouse_id_count > 0 AND @dispatch_ware_house_id_count = 0) # 给货物的仓库有数据，被给予货物的仓库没有数据，需要新建一个表数据 
        THEN	# 一个更新，一个插入 
        	UPDATE tb_warehouse_item SET tb_warehouse_item.item_count = tb_warehouse_item.item_count - new.item_deal_count, tb_warehouse_item.update_time = NOW() WHERE tb_warehouse_item.id = new.warehouse_id AND tb_warehouse_item.item_id = new.item_id;		# 更新供货调度的仓库的货物数据 
        	INSERT INTO tb_warehouse_item(id,item_id,item_count) VALUES (new.direction_id, new.item_id, new.item_deal_count);	# 被给予的仓库新建货物数据 
        END IF; 
	ELSEIF (new.operation = '0')	# 借货，把供货商的货物给到该仓库 
	THEN # 仓库的货物增多 
		IF (@warehouse_id_count > 0) 
		THEN	# 如果已经有过该货物，那么直接更新货物数量 
			UPDATE tb_warehouse_item SET tb_warehouse_item.item_count = tb_warehouse_item.item_count + new.item_deal_count, tb_warehouse_item.update_time = NOW() WHERE tb_warehouse_item.id = new.warehouse_id AND tb_warehouse_item.item_id = new.item_id; 
		ELSEIF (@warehouse_id_count = 0) 
		THEN # 如果之前没有该货物，那么就插入一条新数据 
			INSERT INTO tb_warehouse_item(id,item_id,item_count) VALUES (new.warehouse_id, new.item_id, new.item_deal_count); 
		END IF; 
	END IF; 
END */$$


DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
