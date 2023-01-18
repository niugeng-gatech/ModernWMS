CREATE DATABASE testwms;
USE testwms;
CREATE TABLE IF NOT EXISTS `company` (
	`id` INT AUTO_INCREMENT  NOT NULL PRIMARY KEY  ,
	`company_name` VARCHAR(256) NOT NULL  DEFAULT ''  ,
	`city` VARCHAR(128) NOT NULL  DEFAULT ''  ,
	`address` VARCHAR(256) NOT NULL  DEFAULT ''  ,
	`manager` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`contact_tel` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`create_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`last_update_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`tenant_id` BIGINT  NOT NULL  
);
CREATE TABLE IF NOT EXISTS `supplier` (
	`id` INT AUTO_INCREMENT  NOT NULL PRIMARY KEY  ,
	`supplier_name` VARCHAR(256) NOT NULL  DEFAULT ''  ,
	`city` VARCHAR(128) NOT NULL  DEFAULT ''  ,
	`address` VARCHAR(256) NOT NULL  DEFAULT ''  ,
	`email` VARCHAR(128) NOT NULL  DEFAULT ''  ,
	`manager` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`contact_tel` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`creator` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`create_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`last_update_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`is_valid` BIT  NOT NULL  DEFAULT 1  ,
	`tenant_id` BIGINT  NOT NULL  
);
CREATE TABLE IF NOT EXISTS `customer` (
	`id` INT AUTO_INCREMENT  NOT NULL PRIMARY KEY  ,
	`customer_name` VARCHAR(256) NOT NULL  DEFAULT ''  ,
	`city` VARCHAR(128) NOT NULL  DEFAULT ''  ,
	`address` VARCHAR(256) NOT NULL  DEFAULT ''  ,
	`email` VARCHAR(128) NOT NULL  DEFAULT ''  ,
	`manager` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`contact_tel` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`creator` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`create_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`last_update_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`is_valid` BIT  NOT NULL  DEFAULT 1  ,
	`tenant_id` BIGINT  NOT NULL  
);
CREATE TABLE IF NOT EXISTS `warehouse` (
	`id` INT AUTO_INCREMENT  NOT NULL PRIMARY KEY  ,
	`warehouse_name` VARCHAR(32) NOT NULL  DEFAULT ''  ,
	`city` VARCHAR(128) NOT NULL  DEFAULT ''  ,
	`address` VARCHAR(256) NOT NULL  DEFAULT ''  ,
	`email` VARCHAR(128) NOT NULL  DEFAULT ''  ,
	`manager` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`contact_tel` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`creator` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`create_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`last_update_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`is_valid` BIT  NOT NULL  DEFAULT 1  ,
	`tenant_id` BIGINT  NOT NULL  
);
CREATE TABLE IF NOT EXISTS `warehousearea` (
	`id` INT AUTO_INCREMENT  NOT NULL PRIMARY KEY  ,
	`warehouse_id` INT  NOT NULL  ,
	`area_name` VARCHAR(32) NOT NULL  DEFAULT ''  ,
	`area_property` TINYINT  NOT NULL  DEFAULT 0  ,
	`parent_id` INT  NOT NULL  DEFAULT 0  ,
	`create_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`last_update_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`is_valid` BIT  NOT NULL  DEFAULT 1  ,
	`tenant_id` BIGINT  NOT NULL  
);
CREATE TABLE IF NOT EXISTS `goodslocation` (
	`id` INT AUTO_INCREMENT  NOT NULL PRIMARY KEY  ,
	`warehouse_id` INT  NOT NULL  DEFAULT 0  ,
	`warehouse_name` VARCHAR(32) NOT NULL  DEFAULT ''  ,
	`warehouse_area_id` INT  NOT NULL  DEFAULT 0  ,
	`warehouse_area_name` VARCHAR(32) NOT NULL  DEFAULT ''  ,
	`warehouse_area_property` TINYINT  NOT NULL  DEFAULT 0  ,
	`location_name` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`location_length` DECIMAL(5,2)  NOT NULL  DEFAULT 0  ,
	`location_width` DECIMAL(5,2)  NOT NULL  DEFAULT 0  ,
	`location_heigth` DECIMAL(5,2)  NOT NULL  DEFAULT 0  ,
	`location_volume` DECIMAL(12,2)  NOT NULL  DEFAULT 0  ,
	`location_load` DECIMAL(8,2)  NOT NULL  DEFAULT 0  ,
	`roadway_number` VARCHAR(10) NOT NULL  DEFAULT ''  ,
	`shelf_number` VARCHAR(10) NOT NULL  DEFAULT ''  ,
	`layer_number` VARCHAR(10) NOT NULL  DEFAULT ''  ,
	`tag_number` VARCHAR(10) NOT NULL  DEFAULT ''  ,
	`create_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`last_update_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`is_valid` BIT  NOT NULL  DEFAULT 1  ,
	`tenant_id` BIGINT  NOT NULL  
);
CREATE TABLE IF NOT EXISTS `freightfee` (
	`id` INT AUTO_INCREMENT  NOT NULL PRIMARY KEY  ,
	`carrier` VARCHAR(256) NOT NULL  DEFAULT ''  ,
	`departure_city` VARCHAR(128) NOT NULL  DEFAULT ''  ,
	`arrival_city` VARCHAR(128) NOT NULL  DEFAULT ''  ,
	`price_per_weight` DECIMAL(6,2)  NOT NULL  DEFAULT 0  ,
	`price_per_volume` DECIMAL(6,2)  NOT NULL  DEFAULT 0  ,
	`min_payment` DECIMAL(8,2)  NOT NULL  DEFAULT 0  ,
	`creator` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`create_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`last_update_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`is_valid` BIT  NOT NULL  DEFAULT 1  ,
	`tenant_id` BIGINT  NOT NULL  
);
CREATE TABLE IF NOT EXISTS `category` (
	`id` INT AUTO_INCREMENT  NOT NULL PRIMARY KEY  ,
	`category_name` VARCHAR(32) NOT NULL  DEFAULT ''  ,
	`parent_id` INT  NOT NULL  DEFAULT 0  ,
	`creator` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`create_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`last_update_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`is_valid` BIT  NOT NULL  DEFAULT 1  ,
	`tenant_id` BIGINT  NOT NULL  
);
CREATE TABLE IF NOT EXISTS `spu` (
	`id` INT AUTO_INCREMENT  NOT NULL PRIMARY KEY  ,
	`spu_code` VARCHAR(32) NOT NULL  DEFAULT ''  ,
	`spu_name` VARCHAR(200) NOT NULL  DEFAULT ''  ,
	`category_id` INT  NOT NULL  DEFAULT 0  ,
	`spu_description` VARCHAR(1000) NOT NULL  DEFAULT ''  ,
	`bar_code` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`supplier_id` INT  NOT NULL  DEFAULT 0  ,
	`supplier_name` VARCHAR(256) NOT NULL  DEFAULT ''  ,
	`brand` VARCHAR(128) NOT NULL  DEFAULT ''  ,
	`origin` VARCHAR(256) NOT NULL  DEFAULT ''  ,
	`length_unit` TINYINT  NOT NULL  DEFAULT 1  ,
	`volume_unit` TINYINT  NOT NULL  DEFAULT 0  ,
	`weight_unit` TINYINT  NOT NULL  DEFAULT 1  ,
	`creator` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`create_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`last_update_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`is_valid` BIT  NOT NULL  DEFAULT 1  ,
	`tenant_id` BIGINT  NOT NULL  
);
CREATE TABLE IF NOT EXISTS `sku` (
	`id` INT AUTO_INCREMENT  NOT NULL PRIMARY KEY  ,
	`spu_id` INT  NOT NULL  DEFAULT 0  ,
	`sku_code` VARCHAR(32) NOT NULL  DEFAULT ''  ,
	`sku_name` VARCHAR(200) NOT NULL  DEFAULT ''  ,
	`weight` DECIMAL(8,3)  NOT NULL  DEFAULT 0  ,
	`lenght` DECIMAL(8,3)  NOT NULL  DEFAULT 0  ,
	`width` DECIMAL(8,3)  NOT NULL  DEFAULT 0  ,
	`height` DECIMAL(8,3)  NOT NULL  DEFAULT 0  ,
	`volume` DECIMAL(15,3)  NOT NULL  DEFAULT 0  ,
	`unit` VARCHAR(5) NOT NULL  DEFAULT ''  ,
	`cost` DECIMAL(10,2)  NOT NULL  DEFAULT 0  ,
	`price` DECIMAL(10,2)  NOT NULL  DEFAULT 0  ,
	`create_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`last_update_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  
);
CREATE TABLE IF NOT EXISTS `user` (
	`id` INT AUTO_INCREMENT  NOT NULL PRIMARY KEY  ,
	`user_num` VARCHAR(128) NOT NULL  DEFAULT ''  ,
	`user_name` VARCHAR(128) NOT NULL  DEFAULT ''  ,
	`contact_tel` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`user_role` VARCHAR(128) NOT NULL  DEFAULT ''  ,
	`sex` VARCHAR(10) NOT NULL  DEFAULT ''  ,
	`is_valid` BIT  NOT NULL  DEFAULT 1  ,
	`auth_string` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`email` VARCHAR(128) NOT NULL  DEFAULT ''  ,
	`creator` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`create_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`last_update_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`tenant_id` BIGINT  NOT NULL  
);
CREATE TABLE IF NOT EXISTS `userrole` (
	`id` INT AUTO_INCREMENT  NOT NULL PRIMARY KEY  ,
	`role_name` VARCHAR(32) NOT NULL  DEFAULT ''  ,
	`is_valid` BIT  NOT NULL  DEFAULT 1  ,
	`create_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`last_update_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`tenant_id` BIGINT  NOT NULL  
);
CREATE TABLE IF NOT EXISTS `menu` (
	`id` INT AUTO_INCREMENT  NOT NULL PRIMARY KEY  ,
	`menu_name` VARCHAR(32) NOT NULL  DEFAULT ''  ,
	`module` VARCHAR(32) NOT NULL  DEFAULT ''  ,
	`vue_path` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`vue_path_detail` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`vue_directory` VARCHAR(128) NOT NULL  DEFAULT ''  ,
	`sort` INT  NOT NULL  DEFAULT 0  ,
	`tenant_id` BIGINT  NOT NULL  
);
CREATE TABLE IF NOT EXISTS `rolemenu` (
	`id` INT AUTO_INCREMENT  NOT NULL PRIMARY KEY  ,
	`userrole_id` INT  NOT NULL  DEFAULT 0  ,
	`menu_id` INT  NOT NULL  DEFAULT 0  ,
	`authority` TINYINT  NOT NULL  DEFAULT 0  ,
	`create_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`last_update_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`tenant_id` BIGINT  NOT NULL  
);
CREATE TABLE IF NOT EXISTS `goodsowner` (
	`id` INT AUTO_INCREMENT  NOT NULL PRIMARY KEY  ,
	`goods_owner_name` VARCHAR(256) NOT NULL  DEFAULT ''  ,
	`city` VARCHAR(128) NOT NULL  DEFAULT ''  ,
	`address` VARCHAR(256) NOT NULL  DEFAULT ''  ,
	`manager` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`contact_tel` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`creator` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`create_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`last_update_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`is_valid` BIT  NOT NULL  DEFAULT 1  ,
	`tenant_id` BIGINT  NOT NULL  
);
CREATE TABLE IF NOT EXISTS `asn` (
	`id` INT AUTO_INCREMENT  NOT NULL PRIMARY KEY  ,
	`asn_no` VARCHAR(32) NOT NULL  DEFAULT ''  ,
	`asn_status` TINYINT  NOT NULL  DEFAULT 0  ,
	`spu_id` INT  NOT NULL  DEFAULT 0  ,
	`sku_id` INT  NOT NULL  DEFAULT 0  ,
	`asn_qty` INT  NOT NULL  DEFAULT 0  ,
	`actual_qty` INT  NOT NULL  DEFAULT 0  ,
	`sorted_qty` INT  NOT NULL  DEFAULT 0  ,
	`shortage_qty` INT  NOT NULL  DEFAULT 0  ,
	`more_qty` INT  NOT NULL  DEFAULT 0  ,
	`damage_qty` INT  NOT NULL  DEFAULT 0  ,
	`weight` DECIMAL(12,3)  NOT NULL  DEFAULT 0  ,
	`volume` DECIMAL(15,3)  NOT NULL  DEFAULT 0  ,
	`supplier_id` INT  NOT NULL  DEFAULT 0  ,
	`supplier_name` VARCHAR(256) NOT NULL  DEFAULT ''  ,
	`goods_owner_id` INT  NOT NULL  DEFAULT 0  ,
	`goods_owner_name` VARCHAR(256) NOT NULL  DEFAULT ''  ,
	`creator` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`create_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`last_update_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`is_valid` BIT  NOT NULL  DEFAULT 1  ,
	`tenant_id` BIGINT  NOT NULL  
);
CREATE TABLE IF NOT EXISTS `asnsort` (
	`id` INT AUTO_INCREMENT  NOT NULL PRIMARY KEY  ,
	`asn_id` INT  NOT NULL  DEFAULT 0  ,
	`sorted_qty` INT  NOT NULL  DEFAULT 0  ,
	`creator` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`create_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`last_update_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`is_valid` BIT  NOT NULL  DEFAULT 1  ,
	`tenant_id` BIGINT  NOT NULL  
);
CREATE TABLE IF NOT EXISTS `stock` (
	`id` INT AUTO_INCREMENT  NOT NULL PRIMARY KEY  ,
	`sku_id` INT  NOT NULL  DEFAULT 0  ,
	`goods_location_id` INT  NOT NULL  DEFAULT 0  ,
	`qty` INT  NOT NULL  DEFAULT 0  ,
	`goods_owner_id` INT  NOT NULL  DEFAULT 0  ,
	`is_freeze` BIT  NOT NULL  DEFAULT 0  ,
	`last_update_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`tenant_id` BIGINT  NOT NULL  
);
CREATE TABLE IF NOT EXISTS `stockmove` (
	`id` INT AUTO_INCREMENT  NOT NULL PRIMARY KEY  ,
	`job_code` VARCHAR(32) NOT NULL  DEFAULT ''  ,
	`move_status` TINYINT  NOT NULL  DEFAULT 0  ,
	`sku_id` INT  NOT NULL  DEFAULT 0  ,
	`orig_goods_location_id` INT  NOT NULL  DEFAULT 0  ,
	`dest_googs_location_id` INT  NOT NULL  DEFAULT 0  ,
	`qty` INT  NOT NULL  DEFAULT 0  ,
	`goods_owner_id` INT  NOT NULL  DEFAULT 0  ,
	`handler` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`handle_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`creator` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`create_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`last_update_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`tenant_id` BIGINT  NOT NULL  
);
CREATE TABLE IF NOT EXISTS `stocktaking` (
	`id` INT AUTO_INCREMENT  NOT NULL PRIMARY KEY  ,
	`job_code` VARCHAR(32) NOT NULL  DEFAULT ''  ,
	`job_status` BIT  NOT NULL  DEFAULT 0  ,
	`sku_id` INT  NOT NULL  DEFAULT 0  ,
	`goods_owner_id` INT  NOT NULL  DEFAULT 0  ,
	`goods_location_id` INT  NOT NULL  DEFAULT 0  ,
	`book_qty` INT  NOT NULL  DEFAULT 0  ,
	`counted_qty` INT  NOT NULL  DEFAULT 0  ,
	`difference_qty` INT  NOT NULL  DEFAULT 0  ,
	`handler` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`handle_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`creator` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`create_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`last_update_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`tenant_id` BIGINT  NOT NULL  
);
CREATE TABLE IF NOT EXISTS `stockadjust` (
	`id` INT AUTO_INCREMENT  NOT NULL PRIMARY KEY  ,
	`job_code` VARCHAR(32) NOT NULL  DEFAULT ''  ,
	`job_type` TINYINT  NOT NULL  DEFAULT 0  ,
	`sku_id` INT  NOT NULL  DEFAULT 0  ,
	`goods_owner_id` INT  NOT NULL  DEFAULT 0  ,
	`goods_location_id` INT  NOT NULL  DEFAULT 0  ,
	`qty` INT  NOT NULL  DEFAULT 0  ,
	`creator` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`create_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`last_update_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`tenant_id` BIGINT  NOT NULL  ,
	`is_update_stock` BIT  NOT NULL  DEFAULT 0  ,
	`source_table_id` INT  NOT NULL  DEFAULT 0  
);
CREATE TABLE IF NOT EXISTS `stockfreeze` (
	`id` INT AUTO_INCREMENT  NOT NULL PRIMARY KEY  ,
	`job_code` VARCHAR(32) NOT NULL  DEFAULT ''  ,
	`job_type` BIT  NOT NULL  DEFAULT 1  ,
	`sku_id` INT  NOT NULL  DEFAULT 0  ,
	`goods_owner_id` INT  NOT NULL  DEFAULT 0  ,
	`goods_location_id` INT  NOT NULL  DEFAULT 0  ,
	`handler` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`handle_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`last_update_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`tenant_id` BIGINT  NOT NULL  
);
CREATE TABLE IF NOT EXISTS `stockprocess` (
	`id` INT AUTO_INCREMENT  NOT NULL PRIMARY KEY  ,
	`job_code` VARCHAR(32) NOT NULL  DEFAULT ''  ,
	`job_type` BIT  NOT NULL  DEFAULT 0  ,
	`process_status` BIT  NOT NULL  DEFAULT 0  ,
	`processor` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`process_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`creator` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`create_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`last_update_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`tenant_id` BIGINT  NOT NULL  
);
CREATE TABLE IF NOT EXISTS `stockprocessdetail` (
	`id` INT AUTO_INCREMENT  NOT NULL PRIMARY KEY  ,
	`stock_process_id` INT  NOT NULL  DEFAULT 0  ,
	`sku_id` INT  NOT NULL  DEFAULT 0  ,
	`goods_owner_id` INT  NOT NULL  DEFAULT 0  ,
	`goods_location_id` INT  NOT NULL  DEFAULT 0  ,
	`qty` INT  NOT NULL  DEFAULT 0  ,
	`last_update_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`tenant_id` BIGINT  NOT NULL  ,
	`is_source` BIT  NOT NULL  DEFAULT 0  ,
	`is_update_stock` BIT  NOT NULL  DEFAULT 0  
);
CREATE TABLE IF NOT EXISTS `dispatchlist` (
	`id` INT AUTO_INCREMENT  NOT NULL PRIMARY KEY  ,
	`dispatch_no` VARCHAR(32) NOT NULL  DEFAULT ''  ,
	`dispatch_status` TINYINT  NOT NULL  DEFAULT 0  ,
	`customer_id` INT  NOT NULL  DEFAULT 0  ,
	`customer_name` VARCHAR(256) NOT NULL  DEFAULT ''  ,
	`sku_id` INT  NOT NULL  DEFAULT 0  ,
	`qty` INT  NOT NULL  DEFAULT 0  ,
	`weight` DECIMAL(12,3)  NOT NULL  DEFAULT 0  ,
	`volume` DECIMAL(15,3)  NOT NULL  DEFAULT 0  ,
	`creator` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`create_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`damage_qty` INT  NOT NULL  DEFAULT 0  ,
	`lock_qty` INT  NOT NULL  DEFAULT 0  ,
	`picked_qty` INT  NOT NULL  DEFAULT 0  ,
	`intrasit_qty` INT  NOT NULL  DEFAULT 0  ,
	`package_qty` INT  NOT NULL  DEFAULT 0  ,
	`weighing_qty` INT  NOT NULL  DEFAULT 0  ,
	`actual_qty` INT  NOT NULL  DEFAULT 0  ,
	`sign_qty` INT  NOT NULL  DEFAULT 0  ,
	`package_no` VARCHAR(32) NOT NULL  DEFAULT ''  ,
	`package_person` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`package_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`weighing_no` VARCHAR(32) NOT NULL  DEFAULT ''  ,
	`weighing_person` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`weighing_weight` DECIMAL(15,3)  NOT NULL  DEFAULT 0  ,
	`waybill_no` VARCHAR(64) NOT NULL  DEFAULT ''  ,
	`carrier` VARCHAR(256) NOT NULL  DEFAULT ''  ,
	`freightfee` DECIMAL(10,2)  NOT NULL  DEFAULT 0  ,
	`last_update_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  ,
	`tenant_id` BIGINT  NOT NULL  
);
CREATE TABLE IF NOT EXISTS `dispatchpicklist` (
	`id` INT AUTO_INCREMENT  NOT NULL PRIMARY KEY  ,
	`dispatchlist_id` INT  NOT NULL  DEFAULT 0  ,
	`goods_owner_id` INT  NOT NULL  DEFAULT 0  ,
	`goods_location_id` INT  NOT NULL  DEFAULT 0  ,
	`sku_id` INT  NOT NULL  DEFAULT 0  ,
	`pick_qty` INT  NOT NULL  DEFAULT 0  ,
	`picked_qty` INT  NOT NULL  DEFAULT 0  ,
	`is_update_stock` BIT  NOT NULL  DEFAULT 0  ,
	`last_update_time` DATETIME  NOT NULL  DEFAULT '1000-01-01'  
);
INSERT INTO menu(menu_name, module, vue_path, vue_directory, tenant_id, sort)
VALUES
('companySetting', 'baseModule', 'companySetting', 'base/companySetting', 1, 1),
('userRoleSetting', 'baseModule', 'userRoleSetting', 'base/userRoleSetting', 1, 2),
('roleMenu', 'baseModule', 'roleMenu', 'base/roleMenu', 1, 3),
('userManagement', 'baseModule', 'userManagement', 'base/userManagement', 1, 4),
('commodityCategorySetting', 'baseModule', 'commodityCategorySetting', 'base/commodityCategorySetting', 1, 5),
('commodityManagement', 'baseModule', 'commodityManagement', 'base/commodityManagement', 1, 6),
('supplier', 'baseModule', 'supplier', 'base/supplier', 1, 7),
('warehouseSetting', 'baseModule', 'warehouseSetting', 'base/warehouseSetting', 1, 8),
('ownerOfCargo', 'baseModule', 'ownerOfCargo', 'base/ownerOfCargo', 1, 9),
('freightSetting', 'baseModule', 'freightSetting', 'base/freightSetting', 1, 10),
('customer', 'baseModule', 'customer', 'base/customer', 1, 11),
('stockAsn', '', 'stockAsn', 'wms/stockAsn', 1, 2),
('stockManagement', '', 'stockManagement', 'wms/stockManagement', 1, 3),
('warehouseProcessing', 'warehouseWorkingModule', 'warehouseProcessing', 'warehouseWorking/warehouseProcessing', 1, 4),
('warehouseMove', 'warehouseWorkingModule', 'warehouseMove', 'warehouseWorking/warehouseMove', 1, 5),
('warehouseFreeze', 'warehouseWorkingModule', 'warehouseFreeze', 'warehouseWorking/warehouseFreeze', 1, 6),
('warehouseAdjust', 'warehouseWorkingModule', 'warehouseAdjust', 'warehouseWorking/warehouseAdjust', 1, 7),
('warehouseTaking', 'warehouseWorkingModule', 'warehouseTaking', 'warehouseWorking/warehouseTaking', 1, 8),
('deliveryManagement', '', 'deliveryManagement', 'deliveryManagement/deliveryManagement', 1, 5);
INSERT INTO `userrole` ( `role_name`, `is_valid`, `create_time`, `last_update_time`, `tenant_id`) 
VALUES('administrator',TRUE,'2022-12-21 10:30:00','2022-12-23 08:26:36','1');
INSERT INTO `user` (`id`, `user_num`, `user_name`, `contact_tel`, `user_role`, `sex`, `is_valid`, `auth_string`, `creator`, `create_time`, `last_update_time`, `tenant_id`, `email`) 
VALUES('1','admin','Administrator','18559851','administrator','male',TRUE,'c4ca4238a0b923820dcc509a6f75849b','admin','1000-01-01 00:00:00','2022-12-23 10:55:37','1','');


