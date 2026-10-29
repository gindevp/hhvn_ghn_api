SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS=0;
SET UNIQUE_CHECKS=0;
SET SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: cpn
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `audit_log`
--

DROP TABLE IF EXISTS `audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `action` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `entity_type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `entity_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `detail` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `acted_at` datetime(6) NOT NULL,
  `acted_by_username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1500 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_log`
--

LOCK TABLES `audit_log` WRITE;
/*!40000 ALTER TABLE `audit_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `audit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customer_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_order_at` datetime(6),
  `order_count` int DEFAULT NULL,
  `active` tinyint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_customer__phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=1500 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `databasechangelog`
--

DROP TABLE IF EXISTS `databasechangelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `databasechangelog` (
  `ID` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `AUTHOR` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `FILENAME` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int NOT NULL,
  `EXECTYPE` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `MD5SUM` varchar(35) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DESCRIPTION` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `COMMENTS` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TAG` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `LIQUIBASE` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CONTEXTS` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `LABELS` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DEPLOYMENT_ID` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `databasechangelog`
--

LOCK TABLES `databasechangelog` WRITE;
/*!40000 ALTER TABLE `databasechangelog` DISABLE KEYS */;
INSERT INTO `databasechangelog` VALUES ('00000000000001','jhipster','config/liquibase/changelog/00000000000000_initial_schema.xml','2026-08-11 23:51:08',1,'EXECUTED','9:3d15ce8389bddb1666f01b768d03e89b','createTable tableName=jhi_user; createTable tableName=jhi_authority; createTable tableName=jhi_user_authority; addPrimaryKey tableName=jhi_user_authority; addForeignKeyConstraint baseTableName=jhi_user_authority, constraintName=fk_authority_name, ...','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151658-1','jhipster','config/liquibase/changelog/20260811151658_added_entity_Office.xml','2026-08-11 23:51:08',2,'EXECUTED','9:284f10cdc39386cd20c61c6dda127033','createTable tableName=office','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151659-1','jhipster','config/liquibase/changelog/20260811151659_added_entity_Route.xml','2026-08-11 23:51:08',3,'EXECUTED','9:35c73bdc0f68d63d7719673cf1c57b25','createTable tableName=route','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151700-1','jhipster','config/liquibase/changelog/20260811151700_added_entity_Vehicle.xml','2026-08-11 23:51:08',4,'EXECUTED','9:5611961e09bf25732c18acf46531e1c8','createTable tableName=vehicle','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151701-1','jhipster','config/liquibase/changelog/20260811151701_added_entity_Driver.xml','2026-08-11 23:51:08',5,'EXECUTED','9:8f8ee6dfe24bd4660caa361b3d43093d','createTable tableName=driver','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151702-1','jhipster','config/liquibase/changelog/20260811151702_added_entity_StaffProfile.xml','2026-08-11 23:51:08',6,'EXECUTED','9:dff81e74b604716f38b27c91de1fa616','createTable tableName=staff_profile','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151703-1','jhipster','config/liquibase/changelog/20260811151703_added_entity_Customer.xml','2026-08-11 23:51:08',7,'EXECUTED','9:2d1876bea384eeed4766c1f00a665b60','createTable tableName=customer; dropDefaultValue columnName=last_order_at, tableName=customer','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151704-1','jhipster','config/liquibase/changelog/20260811151704_added_entity_ShipmentOrder.xml','2026-08-11 23:51:09',8,'EXECUTED','9:39fff90cd641d164ee09572d1b96b623','createTable tableName=shipment_order; dropDefaultValue columnName=picking_at, tableName=shipment_order; dropDefaultValue columnName=picked_up_at, tableName=shipment_order; dropDefaultValue columnName=label_printed_at, tableName=shipment_order','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151705-1','jhipster','config/liquibase/changelog/20260811151705_added_entity_OrderItem.xml','2026-08-11 23:51:09',9,'EXECUTED','9:4f9ddb55797dfbbe91b7639bec831f92','createTable tableName=order_item','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151706-1','jhipster','config/liquibase/changelog/20260811151706_added_entity_OrderLeg.xml','2026-08-11 23:51:09',10,'EXECUTED','9:9f4dba218579fb4130ef292ad77843de','createTable tableName=order_leg; dropDefaultValue columnName=departed_at, tableName=order_leg; dropDefaultValue columnName=arrived_at, tableName=order_leg','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151707-1','jhipster','config/liquibase/changelog/20260811151707_added_entity_OrderEvent.xml','2026-08-11 23:51:09',11,'EXECUTED','9:004709c7a20983c3cd0a6f8ae905ddd6','createTable tableName=order_event; dropDefaultValue columnName=event_at, tableName=order_event','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151708-1','jhipster','config/liquibase/changelog/20260811151708_added_entity_Trip.xml','2026-08-11 23:51:09',12,'EXECUTED','9:a31bd0ab4268c3448a05e70f0453232e','createTable tableName=trip; dropDefaultValue columnName=depart_at, tableName=trip; dropDefaultValue columnName=closed_at, tableName=trip','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151709-1','jhipster','config/liquibase/changelog/20260811151709_added_entity_TripOrderAssignment.xml','2026-08-11 23:51:09',13,'EXECUTED','9:ae92f113ea26c09e36e5bc6b64d466bb','createTable tableName=trip_order_assignment; dropDefaultValue columnName=scanned_at, tableName=trip_order_assignment; dropDefaultValue columnName=loaded_at, tableName=trip_order_assignment; dropDefaultValue columnName=removed_at, tableName=trip_or...','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151710-1','jhipster','config/liquibase/changelog/20260811151710_added_entity_OrderPayment.xml','2026-08-11 23:51:09',14,'EXECUTED','9:4c1849a7e2edca7650c86b184a10f242','createTable tableName=order_payment; dropDefaultValue columnName=payment_at, tableName=order_payment','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151711-1','jhipster','config/liquibase/changelog/20260811151711_added_entity_Receipt.xml','2026-08-11 23:51:09',15,'EXECUTED','9:baadf373927fb52555446a9374e6ade1','createTable tableName=receipt; dropDefaultValue columnName=created_at, tableName=receipt','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151712-1','jhipster','config/liquibase/changelog/20260811151712_added_entity_ReceiptOrderLine.xml','2026-08-11 23:51:09',16,'EXECUTED','9:e46101dce0000e2d523bd473714692d9','createTable tableName=receipt_order_line','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151713-1','jhipster','config/liquibase/changelog/20260811151713_added_entity_OrderPodPhoto.xml','2026-08-11 23:51:09',17,'EXECUTED','9:4e7d7a18ce3b6ff617c3ba6a401db834','createTable tableName=order_pod_photo; dropDefaultValue columnName=captured_at, tableName=order_pod_photo','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151714-1','jhipster','config/liquibase/changelog/20260811151714_added_entity_OrderDeliveryAttempt.xml','2026-08-11 23:51:09',18,'EXECUTED','9:300aae50aa2c9b4604ac977042679720','createTable tableName=order_delivery_attempt; dropDefaultValue columnName=attempt_at, tableName=order_delivery_attempt','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151715-1','jhipster','config/liquibase/changelog/20260811151715_added_entity_OrderIssue.xml','2026-08-11 23:51:09',19,'EXECUTED','9:56e65935ed25afa9521171606be1e798','createTable tableName=order_issue; dropDefaultValue columnName=opened_at, tableName=order_issue; dropDefaultValue columnName=resolved_at, tableName=order_issue','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151716-1','jhipster','config/liquibase/changelog/20260811151716_added_entity_OrderReturnRequest.xml','2026-08-11 23:51:09',20,'EXECUTED','9:3b6d596eff912ca491627937d07eeab7','createTable tableName=order_return_request; dropDefaultValue columnName=requested_at, tableName=order_return_request; dropDefaultValue columnName=decided_at, tableName=order_return_request','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151717-1','jhipster','config/liquibase/changelog/20260811151717_added_entity_OrderFareAdjustmentRequest.xml','2026-08-11 23:51:09',21,'EXECUTED','9:aba4acd9ddcb390dd4c9558eea69f2f8','createTable tableName=order_fare_adjustment_request; dropDefaultValue columnName=requested_at, tableName=order_fare_adjustment_request; dropDefaultValue columnName=approved_at, tableName=order_fare_adjustment_request; dropDefaultValue columnName=r...','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151718-1','jhipster','config/liquibase/changelog/20260811151718_added_entity_DayClosure.xml','2026-08-11 23:51:09',22,'EXECUTED','9:5e7057a9b1ae8aa203a332ebb6c8ce28','createTable tableName=day_closure; dropDefaultValue columnName=confirmed_at, tableName=day_closure; dropDefaultValue columnName=reopened_at, tableName=day_closure','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151719-1','jhipster','config/liquibase/changelog/20260811151719_added_entity_PricingRule.xml','2026-08-11 23:51:09',23,'EXECUTED','9:34689e1bf0a8594e3f96c57205b4a2f5','createTable tableName=pricing_rule; dropDefaultValue columnName=effective_from, tableName=pricing_rule; dropDefaultValue columnName=effective_to, tableName=pricing_rule','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151720-1','jhipster','config/liquibase/changelog/20260811151720_added_entity_PricingChangeLog.xml','2026-08-11 23:51:09',24,'EXECUTED','9:a90d67372a73b81ecaea25f5c6e69ae8','createTable tableName=pricing_change_log; dropDefaultValue columnName=changed_at, tableName=pricing_change_log','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151721-1','jhipster','config/liquibase/changelog/20260811151721_added_entity_ProductPriceRule.xml','2026-08-11 23:51:09',25,'EXECUTED','9:ffb9b0c55f345ca8140880489ee05443','createTable tableName=product_price_rule','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151722-1','jhipster','config/liquibase/changelog/20260811151722_added_entity_DoorFeeRule.xml','2026-08-11 23:51:09',26,'EXECUTED','9:a9025b12c9dd6e1aa4df3f44aed77543','createTable tableName=door_fee_rule','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151723-1','jhipster','config/liquibase/changelog/20260811151723_added_entity_SurchargePolicy.xml','2026-08-11 23:51:10',27,'EXECUTED','9:398441271d1115bb627ac38c983f5327','createTable tableName=surcharge_policy; dropDefaultValue columnName=updated_at, tableName=surcharge_policy','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151724-1','jhipster','config/liquibase/changelog/20260811151724_added_entity_IntegrationConfig.xml','2026-08-11 23:51:10',28,'EXECUTED','9:146a9e90dce4a1bbf9d4ebf560c14974','createTable tableName=integration_config; dropDefaultValue columnName=updated_at, tableName=integration_config','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151725-1','jhipster','config/liquibase/changelog/20260811151725_added_entity_AuditLog.xml','2026-08-11 23:51:10',29,'EXECUTED','9:54806eaaa076ae90b63ab068de428d2a','createTable tableName=audit_log; dropDefaultValue columnName=acted_at, tableName=audit_log','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151659-2','jhipster','config/liquibase/changelog/20260811151659_added_entity_constraints_Route.xml','2026-08-11 23:51:10',30,'EXECUTED','9:09f4fc1bcdae1611e9252eed76f155d3','addForeignKeyConstraint baseTableName=route, constraintName=fk_route__from_office_id, referencedTableName=office; addForeignKeyConstraint baseTableName=route, constraintName=fk_route__to_office_id, referencedTableName=office','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151702-2','jhipster','config/liquibase/changelog/20260811151702_added_entity_constraints_StaffProfile.xml','2026-08-11 23:51:10',31,'EXECUTED','9:fca6616b351b49bf745097ec936a58cc','addForeignKeyConstraint baseTableName=staff_profile, constraintName=fk_staff_profile__office_id, referencedTableName=office','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151704-2','jhipster','config/liquibase/changelog/20260811151704_added_entity_constraints_ShipmentOrder.xml','2026-08-11 23:51:11',32,'EXECUTED','9:6d874648905879b741f791c782b8d016','addForeignKeyConstraint baseTableName=shipment_order, constraintName=fk_shipment_order__issue_id, referencedTableName=order_issue; addForeignKeyConstraint baseTableName=shipment_order, constraintName=fk_shipment_order__return_request_id, reference...','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151705-2','jhipster','config/liquibase/changelog/20260811151705_added_entity_constraints_OrderItem.xml','2026-08-11 23:51:11',33,'EXECUTED','9:9fbd2f0efbcb64efbe8db2da439a0331','addForeignKeyConstraint baseTableName=order_item, constraintName=fk_order_item__order_id, referencedTableName=shipment_order','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151706-2','jhipster','config/liquibase/changelog/20260811151706_added_entity_constraints_OrderLeg.xml','2026-08-11 23:51:11',34,'EXECUTED','9:dd73500e584529c6319587e438786c46','addForeignKeyConstraint baseTableName=order_leg, constraintName=fk_order_leg__order_id, referencedTableName=shipment_order; addForeignKeyConstraint baseTableName=order_leg, constraintName=fk_order_leg__from_office_id, referencedTableName=office; a...','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151707-2','jhipster','config/liquibase/changelog/20260811151707_added_entity_constraints_OrderEvent.xml','2026-08-11 23:51:11',35,'EXECUTED','9:55bbece87a129d26f1711a89e179a9c6','addForeignKeyConstraint baseTableName=order_event, constraintName=fk_order_event__order_id, referencedTableName=shipment_order','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151708-2','jhipster','config/liquibase/changelog/20260811151708_added_entity_constraints_Trip.xml','2026-08-11 23:51:12',36,'EXECUTED','9:eb5e82bdfd2069a14ca6c2b8eec23599','addForeignKeyConstraint baseTableName=trip, constraintName=fk_trip__office_id, referencedTableName=office; addForeignKeyConstraint baseTableName=trip, constraintName=fk_trip__route_id, referencedTableName=route; addForeignKeyConstraint baseTableNa...','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151709-2','jhipster','config/liquibase/changelog/20260811151709_added_entity_constraints_TripOrderAssignment.xml','2026-08-11 23:51:12',37,'EXECUTED','9:e3db8cba63b8b06acf475d3682a60a37','addForeignKeyConstraint baseTableName=trip_order_assignment, constraintName=fk_trip_order_assignment__trip_id, referencedTableName=trip; addForeignKeyConstraint baseTableName=trip_order_assignment, constraintName=fk_trip_order_assignment__order_id...','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151710-2','jhipster','config/liquibase/changelog/20260811151710_added_entity_constraints_OrderPayment.xml','2026-08-11 23:51:12',38,'EXECUTED','9:13361eb06a8f0ba6d6fe7666ae4d93ce','addForeignKeyConstraint baseTableName=order_payment, constraintName=fk_order_payment__order_id, referencedTableName=shipment_order','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151711-2','jhipster','config/liquibase/changelog/20260811151711_added_entity_constraints_Receipt.xml','2026-08-11 23:51:12',39,'EXECUTED','9:2c70ccb5a0ab92143e6bfe6b986b6445','addForeignKeyConstraint baseTableName=receipt, constraintName=fk_receipt__office_id, referencedTableName=office','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151712-2','jhipster','config/liquibase/changelog/20260811151712_added_entity_constraints_ReceiptOrderLine.xml','2026-08-11 23:51:12',40,'EXECUTED','9:1bf6ab509713dd82a1a6d0e3d8952f27','addForeignKeyConstraint baseTableName=receipt_order_line, constraintName=fk_receipt_order_line__receipt_id, referencedTableName=receipt; addForeignKeyConstraint baseTableName=receipt_order_line, constraintName=fk_receipt_order_line__order_id, refe...','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151713-2','jhipster','config/liquibase/changelog/20260811151713_added_entity_constraints_OrderPodPhoto.xml','2026-08-11 23:51:12',41,'EXECUTED','9:19e4539401268678143b78ba995491f8','addForeignKeyConstraint baseTableName=order_pod_photo, constraintName=fk_order_pod_photo__order_id, referencedTableName=shipment_order','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151714-2','jhipster','config/liquibase/changelog/20260811151714_added_entity_constraints_OrderDeliveryAttempt.xml','2026-08-11 23:51:12',42,'EXECUTED','9:571e06082baf25b0824ebd4fadc9f4d3','addForeignKeyConstraint baseTableName=order_delivery_attempt, constraintName=fk_order_delivery_attempt__order_id, referencedTableName=shipment_order','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151718-2','jhipster','config/liquibase/changelog/20260811151718_added_entity_constraints_DayClosure.xml','2026-08-11 23:51:12',43,'EXECUTED','9:04893e026dd4c376a13a46aebbc7e5c5','addForeignKeyConstraint baseTableName=day_closure, constraintName=fk_day_closure__office_id, referencedTableName=office','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151719-2','jhipster','config/liquibase/changelog/20260811151719_added_entity_constraints_PricingRule.xml','2026-08-11 23:51:12',44,'EXECUTED','9:3a8ff15cc3c2ace907839d97bde4bf44','addForeignKeyConstraint baseTableName=pricing_rule, constraintName=fk_pricing_rule__route_id, referencedTableName=route','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811151720-2','jhipster','config/liquibase/changelog/20260811151720_added_entity_constraints_PricingChangeLog.xml','2026-08-11 23:51:12',45,'EXECUTED','9:69e34a0e46fd1fc08492b4c2c249e820','addForeignKeyConstraint baseTableName=pricing_change_log, constraintName=fk_pricing_change_log__pricing_rule_id, referencedTableName=pricing_rule','',NULL,'4.29.2',NULL,NULL,'6467068001'),('20260811223000-seed-office','cpn','config/liquibase/changelog/20260811223000_seed_master_data_from_fe.xml','2026-08-11 23:51:12',46,'EXECUTED','9:8e765c682202c1ae31b3b7312cf1cc77','loadData tableName=office','',NULL,'4.29.2','seed',NULL,'6467068001'),('20260811223000-seed-route','cpn','config/liquibase/changelog/20260811223000_seed_master_data_from_fe.xml','2026-08-11 23:51:12',47,'EXECUTED','9:aafd79af5345534cf67a49846268f76c','loadData tableName=route','',NULL,'4.29.2','seed',NULL,'6467068001'),('20260811223000-seed-vehicle','cpn','config/liquibase/changelog/20260811223000_seed_master_data_from_fe.xml','2026-08-11 23:51:12',48,'EXECUTED','9:0ee53f31948ddd2edafa063dbcb71173','loadData tableName=vehicle','',NULL,'4.29.2','seed',NULL,'6467068001'),('20260811223000-seed-driver','cpn','config/liquibase/changelog/20260811223000_seed_master_data_from_fe.xml','2026-08-11 23:51:12',49,'EXECUTED','9:cf9eb564f636f0bd9a7d360a59a45a6d','loadData tableName=driver','',NULL,'4.29.2','seed',NULL,'6467068001'),('20260812120000-1','cpn','config/liquibase/changelog/20260812120000_order_issue_history_order_id.xml','2026-08-12 18:02:02',50,'EXECUTED','9:6894cd84fd2fd32a6859df7a1e1e35a4','addColumn tableName=order_issue','',NULL,'4.29.2',NULL,NULL,'6532522160'),('20260812120000-2','cpn','config/liquibase/changelog/20260812120000_order_issue_history_order_id.xml','2026-08-12 18:02:02',51,'EXECUTED','9:2dc43ae966423545276fb0dba884473a','sql','',NULL,'4.29.2',NULL,NULL,'6532522160'),('20260812120000-3','cpn','config/liquibase/changelog/20260812120000_order_issue_history_order_id.xml','2026-08-12 18:02:02',52,'EXECUTED','9:6d298689d3c592b4b99d1a0723b7c373','addForeignKeyConstraint baseTableName=order_issue, constraintName=fk_order_issue__order_id, referencedTableName=shipment_order; createIndex indexName=idx_order_issue__order_id, tableName=order_issue','',NULL,'4.29.2',NULL,NULL,'6532522160'),('20260812140000-1','cpn','config/liquibase/changelog/20260812140000_order_return_history_order_id.xml','2026-08-12 19:58:53',53,'EXECUTED','9:93eaf31f816b21b3374eecd0f7167f50','addColumn tableName=order_return_request','',NULL,'4.29.2',NULL,NULL,'6539533300'),('20260812140000-2','cpn','config/liquibase/changelog/20260812140000_order_return_history_order_id.xml','2026-08-12 19:58:53',54,'EXECUTED','9:bfd3ea2e3f5806b0448e854560bcff7d','sql','',NULL,'4.29.2',NULL,NULL,'6539533300'),('20260812140000-3','cpn','config/liquibase/changelog/20260812140000_order_return_history_order_id.xml','2026-08-12 19:58:53',55,'EXECUTED','9:8c39b25ceaedcf67edc337515a19daad','addForeignKeyConstraint baseTableName=order_return_request, constraintName=fk_order_return_request__order_id, referencedTableName=shipment_order; createIndex indexName=idx_order_return_request__order_id, tableName=order_return_request','',NULL,'4.29.2',NULL,NULL,'6539533300'),('20260812150000-1','cpn','config/liquibase/changelog/20260812150000_order_issue_one_open.xml','2026-08-12 20:05:02',56,'EXECUTED','9:ad6a4bf3d4eea9b9728cf054e521c7b5','sql','',NULL,'4.29.2',NULL,NULL,'6539902430'),('20260812150000-2','cpn','config/liquibase/changelog/20260812150000_order_issue_one_open.xml','2026-08-12 20:05:02',57,'EXECUTED','9:d9a94ec5cf42fd1ea456f4de0faf26b9','sql','',NULL,'4.29.2',NULL,NULL,'6539902430');
/*!40000 ALTER TABLE `databasechangelog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `databasechangeloglock`
--

DROP TABLE IF EXISTS `databasechangeloglock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `databasechangeloglock` (
  `ID` int NOT NULL,
  `LOCKED` tinyint NOT NULL,
  `LOCKGRANTED` datetime DEFAULT NULL,
  `LOCKEDBY` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `databasechangeloglock`
--

LOCK TABLES `databasechangeloglock` WRITE;
/*!40000 ALTER TABLE `databasechangeloglock` DISABLE KEYS */;
INSERT INTO `databasechangeloglock` VALUES (1,0,NULL,NULL);
/*!40000 ALTER TABLE `databasechangeloglock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `day_closure`
--

DROP TABLE IF EXISTS `day_closure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `day_closure` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `business_date` date NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `confirmed_by_username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `confirmed_at` datetime(6) NOT NULL,
  `reopened_by_username` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reopened_at` datetime(6),
  `office_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_day_closure__office_id` (`office_id`),
  CONSTRAINT `fk_day_closure__office_id` FOREIGN KEY (`office_id`) REFERENCES `office` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1503 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `day_closure`
--

LOCK TABLES `day_closure` WRITE;
/*!40000 ALTER TABLE `day_closure` DISABLE KEYS */;
INSERT INTO `day_closure` VALUES (1500,'2026-08-11','CLOSED','quay.hn','2026-08-11 16:56:10.842599',NULL,NULL,5),(1501,'2026-08-12','REOPENED','quay.hn','2026-08-12 13:13:02.207166','quay.hn','2026-08-12 13:13:02.389820',5),(1502,'2026-08-12','REOPENED','quay.hn','2026-08-12 13:12:59.955659','quay.hn','2026-08-12 13:13:00.206230',8);
/*!40000 ALTER TABLE `day_closure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `door_fee_rule`
--

DROP TABLE IF EXISTS `door_fee_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `door_fee_rule` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `kind` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `min_kg` decimal(21,2) NOT NULL,
  `max_kg` decimal(21,2) NOT NULL,
  `min_km` decimal(21,2) NOT NULL,
  `max_km` decimal(21,2) NOT NULL,
  `fee_amount` decimal(21,2) NOT NULL,
  `active` tinyint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1500 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `door_fee_rule`
--

LOCK TABLES `door_fee_rule` WRITE;
/*!40000 ALTER TABLE `door_fee_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `door_fee_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `driver`
--

DROP TABLE IF EXISTS `driver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `driver` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `driver_code` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `full_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_driver__driver_code` (`driver_code`)
) ENGINE=InnoDB AUTO_INCREMENT=1500 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `driver`
--

LOCK TABLES `driver` WRITE;
/*!40000 ALTER TABLE `driver` DISABLE KEYS */;
INSERT INTO `driver` VALUES (1,'DRV001','Nguyễn Văn A','',1),(2,'DRV002','Trần Văn B','',1),(3,'DRV003','Lê Văn C','',1),(4,'DRV004','Phạm Văn D','',1),(5,'DRV005','Hoàng Minh E','',1),(6,'DRV006','Đặng Quốc F','',1),(7,'DRV007','Bùi Thanh G','',1),(8,'DRV008','Ngô Hữu H','',1);
/*!40000 ALTER TABLE `driver` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `integration_config`
--

DROP TABLE IF EXISTS `integration_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `integration_config` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `ahamove_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grab_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `xanhsm_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `distance_api_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telegram_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telegram_chat_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `webhook_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `webhook_secret` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_at` datetime(6),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1501 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `integration_config`
--

LOCK TABLES `integration_config` WRITE;
/*!40000 ALTER TABLE `integration_config` DISABLE KEYS */;
INSERT INTO `integration_config` VALUES (1500,'e2e-token','g',NULL,NULL,NULL,'1',NULL,NULL,NULL);
/*!40000 ALTER TABLE `integration_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jhi_authority`
--

DROP TABLE IF EXISTS `jhi_authority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jhi_authority` (
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jhi_authority`
--

LOCK TABLES `jhi_authority` WRITE;
/*!40000 ALTER TABLE `jhi_authority` DISABLE KEYS */;
INSERT INTO `jhi_authority` VALUES ('ROLE_ADMIN'),('ROLE_USER');
/*!40000 ALTER TABLE `jhi_authority` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jhi_user`
--

DROP TABLE IF EXISTS `jhi_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jhi_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `login` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_url` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activated` tinyint NOT NULL,
  `lang_key` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activation_key` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reset_key` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_date` timestamp NULL,
  `reset_date` timestamp NULL DEFAULT NULL,
  `last_modified_by` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_modified_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_user_login` (`login`),
  UNIQUE KEY `ux_user_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=1061 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jhi_user`
--

LOCK TABLES `jhi_user` WRITE;
/*!40000 ALTER TABLE `jhi_user` DISABLE KEYS */;
INSERT INTO `jhi_user` VALUES (1,'admin','$2a$10$U0fX4NaKqJrQ9AGR8R4.v.kuhDSG18SuTZ005SDavT0ZgoPGSqgH6','Administrator','Administrator','admin@localhost','',1,'en',NULL,NULL,'system',NULL,NULL,'system','2026-08-11 09:51:15'),(2,'user','$2a$10$VEjxo0jq2YG9Rbk2HmX9S.k1uZBGYUHdUcid3g/vfiEl7lwWgOH/K','User','User','user@localhost','',1,'en',NULL,NULL,'system',NULL,NULL,'system',NULL),(1050,'quay.hn','$2a$10$2woY16yNAksrvSofWrI2tOr48KFwEPtnhPnrScRLIxUEcAFQfjXJm','Quầy HN','Q','quay_hn@localhost',NULL,1,'vi',NULL,NULL,'system','2026-08-11 09:51:15',NULL,'system','2026-08-11 09:51:15'),(1051,'quay.hcm','$2a$10$QFufRIlGIqPgJYRC9/FE9OEEqci/pfLNZiG312zWt3cr97IHbs7oi','Quầy NB','Q','quay_hcm@localhost',NULL,1,'vi',NULL,NULL,'system','2026-08-11 09:51:15',NULL,'system','2026-08-11 09:51:15'),(1052,'bx.hn','$2a$10$WXdL6aDTw.syMDdJTSu0DukcNthwCJuvwFgpvm1yerstiZeYKyvJK','Bốc xếp HN','BX','bx_hn@localhost',NULL,1,'vi',NULL,NULL,'system','2026-08-11 09:51:15',NULL,'system','2026-08-11 09:51:15'),(1053,'giao.hn.01','$2a$10$fhdRXEawX.urfCgeHtftc.HxCeJBpL6Dg0Ck0Rq2NIHnvhKlQHtxu','Giao HN 01','G','giao_hn_01@localhost',NULL,1,'vi',NULL,NULL,'system','2026-08-11 09:51:15',NULL,'system','2026-08-11 09:51:15'),(1054,'kt.hn','$2a$10$UlzND8KBB9ELgy6NpQ9rVOzOOA0FmYYcAAi9WkTNRTk35BasHBCcy','Kế toán HN','KT','kt_hn@localhost',NULL,1,'vi',NULL,NULL,'system','2026-08-11 09:51:16',NULL,'system','2026-08-11 09:51:16'),(1055,'tcn.hn','$2a$10$wbivfOjhjsUWT5UMIGStPuMx9wspKccX2jtD3elTy/5g3FHywFDVG','Trưởng CN HN','TCN','tcn_hn@localhost',NULL,1,'vi',NULL,NULL,'system','2026-08-11 09:51:16',NULL,'system','2026-08-11 09:51:16'),(1056,'dh','$2a$10$vus/LgkS6QCdfrXnrJmwuehliaSQJI.GCcNYP1TvpgyQ1O/Cia79S','Điều hành','DH','dh@localhost',NULL,1,'vi',NULL,NULL,'system','2026-08-11 09:51:16',NULL,'system','2026-08-11 09:51:16'),(1057,'bl','$2a$10$LzfhOkG1o0sZG5eTj4k2BeUCmtFxCB6Pjk7QgU/s0gu4MFuKB9.MW','Ban lãnh đạo','BL','bl@localhost',NULL,1,'vi',NULL,NULL,'system','2026-08-11 09:51:16',NULL,'system','2026-08-11 09:51:16'),(1058,'t005_988d69f0','$2a$10$bjbITT62we93ypfMNK1UAepHV5q.3gW.9yoGUCTeCsPIAuchcNIGu',NULL,NULL,'t005_988d69f0@cpn.local',NULL,0,'vi',NULL,NULL,'admin','2026-08-12 06:08:02',NULL,'admin','2026-08-12 06:08:02'),(1059,'t005_09c9e3e1','$2a$10$n9czRhRfSsKcIi1z.E7HseEHdhvex/yQw6NImckMb8ZEN04Q1um1m',NULL,NULL,'t005_09c9e3e1@cpn.local',NULL,0,'vi',NULL,NULL,'admin','2026-08-12 06:12:42',NULL,'admin','2026-08-12 06:12:42'),(1060,'t005_42377d6d','$2a$10$suN7IA7QYDgp/JbGIMp/t.HcJFb1bNx8.M1b74Nvxh8raTc0U0Jn2',NULL,NULL,'t005_42377d6d@cpn.local',NULL,0,'vi',NULL,NULL,'admin','2026-08-12 06:13:07',NULL,'admin','2026-08-12 06:13:07');
/*!40000 ALTER TABLE `jhi_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jhi_user_authority`
--

DROP TABLE IF EXISTS `jhi_user_authority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jhi_user_authority` (
  `user_id` bigint NOT NULL,
  `authority_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`,`authority_name`),
  KEY `fk_authority_name` (`authority_name`),
  CONSTRAINT `fk_authority_name` FOREIGN KEY (`authority_name`) REFERENCES `jhi_authority` (`name`),
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `jhi_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jhi_user_authority`
--

LOCK TABLES `jhi_user_authority` WRITE;
/*!40000 ALTER TABLE `jhi_user_authority` DISABLE KEYS */;
INSERT INTO `jhi_user_authority` VALUES (1,'ROLE_ADMIN'),(1,'ROLE_USER'),(2,'ROLE_USER'),(1050,'ROLE_USER'),(1051,'ROLE_USER'),(1052,'ROLE_USER'),(1053,'ROLE_USER'),(1054,'ROLE_USER'),(1055,'ROLE_USER'),(1056,'ROLE_USER'),(1057,'ROLE_USER'),(1058,'ROLE_USER'),(1059,'ROLE_USER'),(1060,'ROLE_USER');
/*!40000 ALTER TABLE `jhi_user_authority` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `office`
--

DROP TABLE IF EXISTS `office`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `office` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `office_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_hub` tinyint NOT NULL,
  `active` tinyint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_office__code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=1504 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `office`
--

LOCK TABLES `office` WRITE;
/*!40000 ALTER TABLE `office` DISABLE KEYS */;
INSERT INTO `office` VALUES (1,'NGH','VP Ngọc Hồi','BRANCH',0,1),(2,'LD','VP Lê Duẩn','BRANCH',0,1),(3,'PV','VP Phố Vọng','BRANCH',0,1),(4,'TDN','VP Trần Đại Nghĩa','BRANCH',0,1),(5,'GP','VP Giải Phóng','HUB',1,1),(6,'HD','VP Hà Đông','BRANCH',0,1),(7,'BC','VP BigC','BRANCH',0,1),(8,'NB','VP Ninh Bình','BRANCH',0,1),(9,'ND','VP Nam Định','BRANCH',0,1),(10,'SHN','VP 104 Song Hào - NĐ','BRANCH',0,1),(11,'TB','VP Thái Bình','BRANCH',0,1),(12,'PT','VP Phú Thọ','BRANCH',0,1),(13,'VT','VP Việt Trì','BRANCH',0,1),(14,'YB1','VP Yên Bái 1','BRANCH',0,1),(15,'YB3','VP Yên Bái 3','BRANCH',0,1);
/*!40000 ALTER TABLE `office` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_delivery_attempt`
--

DROP TABLE IF EXISTS `order_delivery_attempt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_delivery_attempt` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `attempt_no` int NOT NULL,
  `attempt_at` datetime(6) NOT NULL,
  `result` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `handled_by_username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `delivery_partner` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_order_delivery_attempt__order_id` (`order_id`),
  CONSTRAINT `fk_order_delivery_attempt__order_id` FOREIGN KEY (`order_id`) REFERENCES `shipment_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1552 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_delivery_attempt`
--

LOCK TABLES `order_delivery_attempt` WRITE;
/*!40000 ALTER TABLE `order_delivery_attempt` DISABLE KEYS */;
INSERT INTO `order_delivery_attempt` VALUES (1500,1,'2026-08-11 17:16:38.010425','SUCCESS','TAKE_JOB','quay.hn',NULL,1512),(1501,2,'2026-08-11 17:16:38.151104','SUCCESS','POD_QUAY','quay.hn',NULL,1512),(1502,1,'2026-08-11 17:21:52.962896','SUCCESS','TAKE_JOB','quay.hn',NULL,1517),(1503,2,'2026-08-11 17:21:53.126267','SUCCESS','POD_QUAY','quay.hn',NULL,1517),(1504,1,'2026-08-11 17:28:23.843557','SUCCESS','TAKE_JOB','quay.hn',NULL,1525),(1505,2,'2026-08-11 17:28:24.020515','SUCCESS','POD_QUAY','quay.hn',NULL,1525),(1506,1,'2026-08-12 02:21:01.537104','SUCCESS','TAKE_JOB','quay.hn',NULL,1531),(1507,2,'2026-08-12 02:21:01.683487','SUCCESS','POD_QUAY','quay.hn',NULL,1531),(1508,1,'2026-08-12 03:32:25.704255','SUCCESS','POD_QUAY','quay.hn',NULL,1539),(1509,1,'2026-08-12 03:32:26.146379','SUCCESS','POD_QUAY','quay.hn',NULL,1540),(1510,1,'2026-08-12 03:32:30.117867','SUCCESS','POD_QUAY','quay.hn',NULL,1543),(1511,1,'2026-08-12 03:35:25.135689','SUCCESS','POD_QUAY','quay.hn',NULL,1550),(1512,1,'2026-08-12 12:51:06.215228','SUCCESS','POD_QUAY','quay.hn',NULL,1573),(1513,1,'2026-08-12 12:51:06.829768','SUCCESS','POD_QUAY','quay.hn',NULL,1575),(1514,1,'2026-08-12 12:53:04.591565','SUCCESS','POD_QUAY','quay.hn',NULL,1588),(1515,1,'2026-08-12 12:53:10.767154','SUCCESS','POD_QUAY','quay.hn',NULL,1590),(1516,1,'2026-08-12 12:53:11.354174','SUCCESS','POD_QUAY','quay.hn',NULL,1592),(1517,1,'2026-08-12 12:56:48.001858','SUCCESS','POD_QUAY','quay.hn',NULL,1604),(1518,1,'2026-08-12 12:59:23.663235','SUCCESS','POD_QUAY','quay.hn',NULL,1606),(1519,1,'2026-08-12 12:59:52.720328','SUCCESS','POD_QUAY','quay.hn',NULL,1609),(1520,1,'2026-08-12 13:00:03.021546','SUCCESS','POD_QUAY','quay.hn',NULL,1615),(1521,1,'2026-08-12 13:02:10.559213','FAILED','r1','quay.hn',NULL,1621),(1522,2,'2026-08-12 13:02:10.656985','FAILED','r2','quay.hn',NULL,1621),(1523,3,'2026-08-12 13:02:10.756827','FAILED','r3','quay.hn',NULL,1621),(1524,4,'2026-08-12 13:02:10.769878','RETURNED_TO_BRANCH','FAIL_MAX','quay.hn',NULL,1621),(1525,1,'2026-08-12 13:02:44.847497','FAILED','r1','quay.hn',NULL,1623),(1526,2,'2026-08-12 13:02:45.302889','FAILED','r2','quay.hn',NULL,1623),(1527,3,'2026-08-12 13:02:46.345949','FAILED','r3','quay.hn',NULL,1623),(1528,4,'2026-08-12 13:02:46.361078','RETURNED_TO_BRANCH','FAIL_MAX','quay.hn',NULL,1623),(1529,1,'2026-08-12 13:03:23.656171','FAILED','r1','quay.hn',NULL,1625),(1530,2,'2026-08-12 13:03:23.748608','FAILED','r2','quay.hn',NULL,1625),(1531,3,'2026-08-12 13:03:23.826557','FAILED','r3','quay.hn',NULL,1625),(1532,4,'2026-08-12 13:03:23.841441','RETURNED_TO_BRANCH','FAIL_MAX','quay.hn',NULL,1625),(1533,1,'2026-08-12 13:04:08.998073','SUCCESS','POD_QUAY','quay.hn',NULL,1630),(1534,1,'2026-08-12 13:05:23.140414','SUCCESS','POD_QUAY','quay.hn',NULL,1635),(1535,1,'2026-08-12 13:05:23.737227','SUCCESS','POD_QUAY','quay.hn',NULL,1637),(1536,1,'2026-08-12 13:12:32.140361','SUCCESS','POD_QUAY','quay.hn',NULL,1639),(1537,1,'2026-08-12 13:12:32.628829','SUCCESS','POD_QUAY','quay.hn',NULL,1641),(1538,1,'2026-08-12 13:12:35.156850','SUCCESS','POD_QUAY','quay.hn',NULL,1646),(1539,1,'2026-08-12 13:12:38.906046','SUCCESS','POD_QUAY','quay.hn',NULL,1651),(1540,1,'2026-08-12 13:12:40.694964','FAILED','r1','quay.hn',NULL,1654),(1541,2,'2026-08-12 13:12:40.771623','FAILED','r2','quay.hn',NULL,1654),(1542,3,'2026-08-12 13:12:40.845984','FAILED','r3','quay.hn',NULL,1654),(1543,4,'2026-08-12 13:12:40.863851','RETURNED_TO_BRANCH','FAIL_MAX','quay.hn',NULL,1654),(1544,1,'2026-08-12 13:12:57.415542','SUCCESS','POD_QUAY','quay.hn',NULL,1660),(1545,1,'2026-08-12 13:12:57.982533','SUCCESS','POD_QUAY','quay.hn',NULL,1662),(1546,1,'2026-08-12 13:13:00.266432','SUCCESS','POD_QUAY','quay.hn',NULL,1667),(1547,1,'2026-08-12 13:13:04.130010','SUCCESS','POD_QUAY','quay.hn',NULL,1675),(1548,1,'2026-08-12 13:13:05.981907','FAILED','r1','quay.hn',NULL,1678),(1549,2,'2026-08-12 13:13:06.081760','FAILED','r2','quay.hn',NULL,1678),(1550,3,'2026-08-12 13:13:06.183448','FAILED','r3','quay.hn',NULL,1678),(1551,4,'2026-08-12 13:13:06.202128','RETURNED_TO_BRANCH','FAIL_MAX','quay.hn',NULL,1678);
/*!40000 ALTER TABLE `order_delivery_attempt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_event`
--

DROP TABLE IF EXISTS `order_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_event` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `event_at` datetime(6) NOT NULL,
  `action` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `detail` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actor_username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_order_event__order_id` (`order_id`),
  CONSTRAINT `fk_order_event__order_id` FOREIGN KEY (`order_id`) REFERENCES `shipment_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1923 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_event`
--

LOCK TABLES `order_event` WRITE;
/*!40000 ALTER TABLE `order_event` DISABLE KEYS */;
INSERT INTO `order_event` VALUES (1500,'2026-08-11 16:52:53.109763','DRAFT_CREATE','Public draft','customer',1500),(1501,'2026-08-11 16:53:17.001815','DRAFT_CREATE','Public draft','customer',1501),(1502,'2026-08-11 16:55:45.648678','DRAFT_CREATE','Public draft','customer',1502),(1503,'2026-08-11 16:55:45.816318','CREATE','Internal create','quay.hn',1503),(1504,'2026-08-11 16:56:10.623872','CREATE','Internal create','quay.hn',1504),(1505,'2026-08-11 16:56:10.757036','SCAN_OUT','Trip TGP260811-01','quay.hn',1504),(1506,'2026-08-11 16:56:41.154776','CREATE','Internal create','quay.hn',1505),(1507,'2026-08-11 16:58:08.957271','CREATE','Internal create','quay.hn',1506),(1508,'2026-08-11 16:58:09.066743','ASSIGN_TRIP','Trip TGP260811-01','quay.hn',1506),(1509,'2026-08-11 16:58:09.166080','CREATE','Internal create','quay.hn',1507),(1510,'2026-08-11 16:58:09.210244','ASSIGN_TRIP','Trip TGP260811-01','quay.hn',1507),(1511,'2026-08-11 17:11:09.960308','CREATE','Internal create','quay.hn',1508),(1512,'2026-08-11 17:11:10.056152','CANCEL',NULL,'quay.hn',1508),(1513,'2026-08-11 17:11:10.110548','RESTORE','Restored to CONFIRMED','quay.hn',1508),(1514,'2026-08-11 17:11:10.199540','CREATE','Internal create','quay.hn',1509),(1515,'2026-08-11 17:16:36.529157','DRAFT_CREATE','Public draft','customer',1510),(1516,'2026-08-11 17:16:36.708159','CREATE','Internal create','quay.hn',1511),(1517,'2026-08-11 17:16:37.038605','CANCEL','e2e','quay.hn',1511),(1518,'2026-08-11 17:16:37.139613','RESTORE','Restored to CONFIRMED','quay.hn',1511),(1519,'2026-08-11 17:16:37.248286','CREATE','Internal create','quay.hn',1512),(1520,'2026-08-11 17:16:37.435642','ASSIGN_TRIP','Trip TGP260812-01','quay.hn',1512),(1521,'2026-08-11 17:16:37.561368','SCAN_OUT','Trip TGP260812-01','quay.hn',1512),(1522,'2026-08-11 17:16:37.906892','SCAN_IN','VP NB','quay.hn',1512),(1523,'2026-08-11 17:16:38.017935','TAKE_JOB','Internal shipper','quay.hn',1512),(1524,'2026-08-11 17:16:38.143796','POD_QUAY','Recv2 Actual','quay.hn',1512),(1525,'2026-08-11 17:16:38.366674','CREATE','Internal create','quay.hn',1513),(1526,'2026-08-11 17:16:38.469442','RETURN_START','e2e-return','quay.hn',1512),(1527,'2026-08-11 17:16:38.844581','CREATE','Internal create','quay.hn',1514),(1528,'2026-08-11 17:21:51.251248','DRAFT_CREATE','Public draft','customer',1515),(1529,'2026-08-11 17:21:51.488932','CREATE','Internal create','quay.hn',1516),(1530,'2026-08-11 17:21:51.950565','CANCEL','e2e','quay.hn',1516),(1531,'2026-08-11 17:21:52.051652','RESTORE','Restored to CONFIRMED','quay.hn',1516),(1532,'2026-08-11 17:21:52.164510','CREATE','Internal create','quay.hn',1517),(1533,'2026-08-11 17:21:52.357852','ASSIGN_TRIP','Trip TGP260812-02','quay.hn',1517),(1534,'2026-08-11 17:21:52.488198','SCAN_OUT','Trip TGP260812-02','quay.hn',1517),(1535,'2026-08-11 17:21:52.843345','SCAN_IN','VP NB','quay.hn',1517),(1536,'2026-08-11 17:21:52.969566','TAKE_JOB','Internal shipper','quay.hn',1517),(1537,'2026-08-11 17:21:53.120358','POD_QUAY','Recv2 Actual','quay.hn',1517),(1538,'2026-08-11 17:21:53.347150','CREATE','Internal create','quay.hn',1518),(1539,'2026-08-11 17:21:53.448383','RETURN_START','e2e-return','quay.hn',1517),(1540,'2026-08-11 17:21:53.867438','CREATE','Internal create','quay.hn',1519),(1541,'2026-08-11 17:25:07.311167','CREATE','Internal create','quay.hn',1520),(1542,'2026-08-11 17:27:45.027113','CREATE','Internal create','quay.hn',1521),(1543,'2026-08-11 17:28:12.451964','CREATE','Internal create','quay.hn',1522),(1544,'2026-08-11 17:28:22.228150','DRAFT_CREATE','Public draft','customer',1523),(1545,'2026-08-11 17:28:22.391997','CREATE','Internal create','quay.hn',1524),(1546,'2026-08-11 17:28:22.782569','CANCEL','e2e','quay.hn',1524),(1547,'2026-08-11 17:28:22.890765','RESTORE','Restored to CONFIRMED','quay.hn',1524),(1548,'2026-08-11 17:28:23.019319','CREATE','Internal create','quay.hn',1525),(1549,'2026-08-11 17:28:23.222322','ASSIGN_TRIP','Trip TGP260812-03','quay.hn',1525),(1550,'2026-08-11 17:28:23.373663','SCAN_OUT','Trip TGP260812-03','quay.hn',1525),(1551,'2026-08-11 17:28:23.703609','SCAN_IN','VP NB','quay.hn',1525),(1552,'2026-08-11 17:28:23.849720','TAKE_JOB','Internal shipper','quay.hn',1525),(1553,'2026-08-11 17:28:24.011236','POD_QUAY','Recv2 Actual','quay.hn',1525),(1554,'2026-08-11 17:28:24.356194','CREATE','Internal create','quay.hn',1526),(1555,'2026-08-11 17:28:24.468260','RETURN_START','e2e-return','quay.hn',1525),(1556,'2026-08-11 17:28:24.895176','CREATE','Internal create','quay.hn',1527),(1557,'2026-08-12 02:06:56.867796','CREATE','Internal create','quay.hn',1528),(1558,'2026-08-12 02:20:59.993571','DRAFT_CREATE','Public draft','customer',1529),(1559,'2026-08-12 02:21:00.200180','CREATE','Internal create','quay.hn',1530),(1560,'2026-08-12 02:21:00.592706','CANCEL','e2e','quay.hn',1530),(1561,'2026-08-12 02:21:00.695629','RESTORE','Restored to CONFIRMED','quay.hn',1530),(1562,'2026-08-12 02:21:00.820964','CREATE','Internal create','quay.hn',1531),(1563,'2026-08-12 02:21:01.004601','ASSIGN_TRIP','Trip TGP260812-04','quay.hn',1531),(1564,'2026-08-12 02:21:01.126956','SCAN_OUT','Trip TGP260812-04','quay.hn',1531),(1565,'2026-08-12 02:21:01.439066','SCAN_IN','VP NB','quay.hn',1531),(1566,'2026-08-12 02:21:01.543605','TAKE_JOB','Internal shipper','quay.hn',1531),(1567,'2026-08-12 02:21:01.677554','POD_QUAY','Recv2 Actual','quay.hn',1531),(1568,'2026-08-12 02:21:01.865010','CREATE','Internal create','quay.hn',1532),(1569,'2026-08-12 02:21:01.932884','RETURN_START','e2e-return','quay.hn',1531),(1570,'2026-08-12 02:21:02.280009','CREATE','Internal create','quay.hn',1533),(1571,'2026-08-12 02:35:34.359437','CREATE','Internal create','quay.hn',1534),(1572,'2026-08-12 02:35:34.478187','PATCH','Order fields updated','quay.hn',1534),(1573,'2026-08-12 02:35:34.625642','WAREHOUSE_RECEIVE','Received at warehouse','quay.hn',1534),(1574,'2026-08-12 02:35:34.695856','LEG_ADVANCE','Advanced to next leg','quay.hn',1534),(1575,'2026-08-12 02:35:34.758186','LEG_ARRIVE_DEST','Last leg arrived','quay.hn',1534),(1576,'2026-08-12 02:35:34.812106','PICKUP_START','Pickup started','quay.hn',1534),(1577,'2026-08-12 03:32:23.419538','CREATE','Internal create','quay.hn',1535),(1578,'2026-08-12 03:32:23.576839','PATCH','Order fields updated','quay.hn',1535),(1579,'2026-08-12 03:32:23.767447','PATCH','Order fields updated','quay.hn',1535),(1580,'2026-08-12 03:32:23.827701','PATCH','Order fields updated','quay.hn',1535),(1581,'2026-08-12 03:32:23.986968','PATCH','Order fields updated','quay.hn',1535),(1582,'2026-08-12 03:32:24.111711','CREATE','Internal create','quay.hn',1536),(1583,'2026-08-12 03:32:24.255504','PATCH','Order fields updated','quay.hn',1536),(1584,'2026-08-12 03:32:24.413917','CREATE','Internal create','quay.hn',1537),(1585,'2026-08-12 03:32:24.559859','PATCH','Order fields updated','quay.hn',1537),(1586,'2026-08-12 03:32:24.708729','LEG_ADVANCE','Advanced to next leg','quay.hn',1537),(1587,'2026-08-12 03:32:24.914715','LEG_ARRIVE_DEST','Last leg arrived','quay.hn',1537),(1588,'2026-08-12 03:32:25.182950','CREATE','Internal create','quay.hn',1538),(1589,'2026-08-12 03:32:25.343788','CREATE','Internal create','quay.hn',1539),(1590,'2026-08-12 03:32:25.687784','POD_QUAY','Pod Actual','quay.hn',1539),(1591,'2026-08-12 03:32:26.003906','CREATE','Internal create','quay.hn',1540),(1592,'2026-08-12 03:32:26.135695','POD_QUAY','UDst','quay.hn',1540),(1593,'2026-08-12 03:32:26.547974','CREATE','Internal create','quay.hn',1541),(1594,'2026-08-12 03:32:26.665736','SCAN_OUT','Trip T-AUDIT','quay.hn',1541),(1595,'2026-08-12 03:32:26.788362','SCAN_IN',NULL,'quay.hn',1541),(1596,'2026-08-12 03:32:27.095948','CREATE','Internal create','quay.hn',1542),(1597,'2026-08-12 03:32:29.280672','CREATE','Internal create','quay.hn',1543),(1598,'2026-08-12 03:32:30.109393','POD_QUAY','DayDst','quay.hn',1543),(1599,'2026-08-12 03:32:30.305241','PATCH','Order fields updated','quay.hn',1543),(1600,'2026-08-12 03:33:36.274367','CREATE','Internal create','quay.hn',1544),(1601,'2026-08-12 03:33:36.405212','PATCH','Order fields updated','quay.hn',1544),(1602,'2026-08-12 03:33:36.552061','CREATE','Internal create','quay.hn',1545),(1603,'2026-08-12 03:33:36.649674','SCAN_OUT','Trip Z','quay.hn',1545),(1604,'2026-08-12 03:33:36.909453','CREATE','Internal create','quay.hn',1546),(1605,'2026-08-12 03:33:37.038781','LEG_ADVANCE','Advanced to next leg','quay.hn',1546),(1606,'2026-08-12 03:35:24.105084','CREATE','Internal create','quay.hn',1547),(1607,'2026-08-12 03:35:24.204537','PATCH','Order fields updated','quay.hn',1547),(1608,'2026-08-12 03:35:24.346160','CREATE','Internal create','quay.hn',1548),(1609,'2026-08-12 03:35:24.439159','SCAN_OUT','Trip Z','quay.hn',1548),(1610,'2026-08-12 03:35:24.739495','CREATE','Internal create','quay.hn',1549),(1611,'2026-08-12 03:35:24.856126','LEG_ADVANCE','Advanced to next leg','quay.hn',1549),(1612,'2026-08-12 03:35:25.047000','CREATE','Internal create','quay.hn',1550),(1613,'2026-08-12 03:35:25.129180','POD_QUAY','B','quay.hn',1550),(1614,'2026-08-12 04:12:01.044898','CREATE','Internal create','quay.hn',1551),(1615,'2026-08-12 04:12:01.155443','PATCH','Order fields updated','quay.hn',1551),(1616,'2026-08-12 04:12:01.240312','SCAN_OUT','Trip T1','quay.hn',1551),(1617,'2026-08-12 04:12:01.397137','CREATE','Internal create','quay.hn',1552),(1618,'2026-08-12 04:12:01.441926','LEG_ADVANCE','Advanced to next leg','quay.hn',1552),(1619,'2026-08-12 04:12:01.587041','CREATE','Internal create','quay.hn',1553),(1620,'2026-08-12 04:12:01.790613','CREATE','Internal create','quay.hn',1554),(1621,'2026-08-12 04:12:02.279092','PATCH','Order fields updated','quay.hn',1554),(1622,'2026-08-12 04:12:28.989975','CREATE','Internal create','quay.hn',1555),(1623,'2026-08-12 04:12:29.043340','PATCH','Order fields updated','quay.hn',1555),(1624,'2026-08-12 04:12:29.104400','SCAN_OUT','Trip T1','quay.hn',1555),(1625,'2026-08-12 04:12:29.268084','CREATE','Internal create','quay.hn',1556),(1626,'2026-08-12 04:12:29.324702','LEG_ADVANCE','Advanced to next leg','quay.hn',1556),(1627,'2026-08-12 04:12:29.449990','CREATE','Internal create','quay.hn',1557),(1628,'2026-08-12 04:12:29.657970','CREATE','Internal create','quay.hn',1558),(1629,'2026-08-12 04:12:30.142883','PATCH','Order fields updated','quay.hn',1558),(1630,'2026-08-12 11:02:13.484723','CREATE','Internal create','quay.hn',1559),(1631,'2026-08-12 11:02:14.609422','CREATE','Internal create','quay.hn',1560),(1632,'2026-08-12 11:02:14.656225','PATCH','Order fields updated','quay.hn',1560),(1633,'2026-08-12 11:02:14.723470','CREATE','Internal create','quay.hn',1561),(1634,'2026-08-12 11:02:14.777909','LEG_ADVANCE','Advanced to next leg','quay.hn',1561),(1635,'2026-08-12 12:31:32.574442','CREATE','Internal create','quay.hn',1562),(1636,'2026-08-12 12:31:32.827400','PATCH','Order fields updated','quay.hn',1562),(1637,'2026-08-12 12:31:32.885137','PATCH','Order fields updated','quay.hn',1562),(1638,'2026-08-12 12:31:32.934168','PATCH','Order fields updated','quay.hn',1562),(1639,'2026-08-12 12:31:32.985801','PATCH','Order fields updated','quay.hn',1562),(1640,'2026-08-12 12:31:49.616155','CREATE','Internal create','quay.hn',1563),(1641,'2026-08-12 12:31:49.668343','PATCH','Order fields updated','quay.hn',1563),(1642,'2026-08-12 12:31:49.698441','CREATE','Internal create','quay.hn',1564),(1643,'2026-08-12 12:31:49.726914','SCAN_OUT','Trip T1','quay.hn',1563),(1644,'2026-08-12 12:31:49.876832','CREATE','Internal create','quay.hn',1565),(1645,'2026-08-12 12:31:49.958499','LEG_ADVANCE','Advanced to next leg','quay.hn',1565),(1646,'2026-08-12 12:31:50.120859','CREATE','Internal create','quay.hn',1566),(1647,'2026-08-12 12:31:50.581843','CREATE','Internal create','quay.hn',1567),(1648,'2026-08-12 12:31:51.246671','CREATE','Internal create','quay.hn',1568),(1649,'2026-08-12 12:31:51.285306','PATCH','Order fields updated','quay.hn',1567),(1650,'2026-08-12 12:31:51.292799','PATCH','Order fields updated','quay.hn',1568),(1651,'2026-08-12 12:31:51.370968','CREATE','Internal create','quay.hn',1569),(1652,'2026-08-12 12:31:51.411486','LEG_ADVANCE','Advanced to next leg','quay.hn',1569),(1653,'2026-08-12 12:31:56.609251','CREATE','Internal create','quay.hn',1570),(1654,'2026-08-12 12:31:57.577186','CREATE','Internal create','quay.hn',1571),(1655,'2026-08-12 12:31:57.616507','PATCH','Order fields updated','quay.hn',1571),(1656,'2026-08-12 12:31:57.696825','CREATE','Internal create','quay.hn',1572),(1657,'2026-08-12 12:31:57.749235','LEG_ADVANCE','Advanced to next leg','quay.hn',1572),(1658,'2026-08-12 12:51:06.100875','CREATE','Internal create','quay.hn',1573),(1659,'2026-08-12 12:51:06.208145','POD_QUAY','Recv','quay.hn',1573),(1660,'2026-08-12 12:51:06.589196','CREATE','Internal create','quay.hn',1574),(1661,'2026-08-12 12:51:06.760489','CREATE','Internal create','quay.hn',1575),(1662,'2026-08-12 12:51:06.825249','POD_QUAY','Z','quay.hn',1575),(1663,'2026-08-12 12:51:11.364698','CREATE','Internal create','quay.hn',1576),(1664,'2026-08-12 12:51:11.412679','PATCH','Order fields updated','quay.hn',1576),(1665,'2026-08-12 12:51:11.470267','SCAN_OUT','Trip T1','quay.hn',1576),(1666,'2026-08-12 12:51:11.616205','CREATE','Internal create','quay.hn',1577),(1667,'2026-08-12 12:51:11.676697','LEG_ADVANCE','Advanced to next leg','quay.hn',1577),(1668,'2026-08-12 12:51:11.856784','CREATE','Internal create','quay.hn',1578),(1669,'2026-08-12 12:51:12.064749','CREATE','Internal create','quay.hn',1579),(1670,'2026-08-12 12:51:12.615018','PATCH','Order fields updated','quay.hn',1579),(1671,'2026-08-12 12:51:13.553375','CREATE','Internal create','quay.hn',1580),(1672,'2026-08-12 12:51:13.793390','PATCH','Order fields updated','quay.hn',1580),(1673,'2026-08-12 12:51:13.857893','PATCH','Order fields updated','quay.hn',1580),(1674,'2026-08-12 12:51:13.947136','PATCH','Order fields updated','quay.hn',1580),(1675,'2026-08-12 12:51:14.028014','PATCH','Order fields updated','quay.hn',1580),(1676,'2026-08-12 12:51:15.319754','CREATE','Internal create','quay.hn',1581),(1677,'2026-08-12 12:51:16.659311','CREATE','Internal create','quay.hn',1582),(1678,'2026-08-12 12:51:16.698912','PATCH','Order fields updated','quay.hn',1582),(1679,'2026-08-12 12:51:16.780357','CREATE','Internal create','quay.hn',1583),(1680,'2026-08-12 12:51:16.821354','LEG_ADVANCE','Advanced to next leg','quay.hn',1583),(1681,'2026-08-12 12:53:03.193606','CREATE','Internal create','quay.hn',1584),(1682,'2026-08-12 12:53:03.251642','PATCH','Order fields updated','quay.hn',1584),(1683,'2026-08-12 12:53:03.319490','SCAN_OUT','Trip T1','quay.hn',1584),(1684,'2026-08-12 12:53:03.435163','CREATE','Internal create','quay.hn',1585),(1685,'2026-08-12 12:53:03.473133','LEG_ADVANCE','Advanced to next leg','quay.hn',1585),(1686,'2026-08-12 12:53:03.587318','CREATE','Internal create','quay.hn',1586),(1687,'2026-08-12 12:53:03.748312','CREATE','Internal create','quay.hn',1587),(1688,'2026-08-12 12:53:04.210439','PATCH','Order fields updated','quay.hn',1587),(1689,'2026-08-12 12:53:04.330197','CREATE','Internal create','quay.hn',1588),(1690,'2026-08-12 12:53:04.397347','PATCH','Order fields updated','quay.hn',1588),(1691,'2026-08-12 12:53:04.587065','POD_QUAY','M2','quay.hn',1588),(1692,'2026-08-12 12:53:09.225553','CREATE','Internal create','quay.hn',1589),(1693,'2026-08-12 12:53:09.450171','PATCH','Order fields updated','quay.hn',1589),(1694,'2026-08-12 12:53:09.507924','PATCH','Order fields updated','quay.hn',1589),(1695,'2026-08-12 12:53:09.555945','PATCH','Order fields updated','quay.hn',1589),(1696,'2026-08-12 12:53:09.603443','PATCH','Order fields updated','quay.hn',1589),(1697,'2026-08-12 12:53:10.695952','CREATE','Internal create','quay.hn',1590),(1698,'2026-08-12 12:53:10.760817','POD_QUAY','Recv','quay.hn',1590),(1699,'2026-08-12 12:53:11.129197','CREATE','Internal create','quay.hn',1591),(1700,'2026-08-12 12:53:11.286595','CREATE','Internal create','quay.hn',1592),(1701,'2026-08-12 12:53:11.344008','POD_QUAY','Z','quay.hn',1592),(1702,'2026-08-12 12:53:12.618120','CREATE','Internal create','quay.hn',1593),(1703,'2026-08-12 12:53:14.149183','CREATE','Internal create','quay.hn',1594),(1704,'2026-08-12 12:53:14.211425','PATCH','Order fields updated','quay.hn',1594),(1705,'2026-08-12 12:53:14.306551','CREATE','Internal create','quay.hn',1595),(1706,'2026-08-12 12:53:14.374436','LEG_ADVANCE','Advanced to next leg','quay.hn',1595),(1707,'2026-08-12 12:56:39.137490','CREATE','Internal create','quay.hn',1596),(1708,'2026-08-12 12:56:39.317448','CREATE','Internal create','quay.hn',1597),(1709,'2026-08-12 12:56:39.373559','CREATE','Internal create','quay.hn',1598),(1710,'2026-08-12 12:56:39.444967','CREATE','Internal create','quay.hn',1599),(1711,'2026-08-12 12:56:46.668993','CREATE','Internal create','quay.hn',1600),(1712,'2026-08-12 12:56:46.711193','PATCH','Order fields updated','quay.hn',1600),(1713,'2026-08-12 12:56:46.767666','SCAN_OUT','Trip T1','quay.hn',1600),(1714,'2026-08-12 12:56:46.925414','CREATE','Internal create','quay.hn',1601),(1715,'2026-08-12 12:56:46.977339','LEG_ADVANCE','Advanced to next leg','quay.hn',1601),(1716,'2026-08-12 12:56:47.097571','CREATE','Internal create','quay.hn',1602),(1717,'2026-08-12 12:56:47.239378','CREATE','Internal create','quay.hn',1603),(1718,'2026-08-12 12:56:47.638325','PATCH','Order fields updated','quay.hn',1603),(1719,'2026-08-12 12:56:47.732835','CREATE','Internal create','quay.hn',1604),(1720,'2026-08-12 12:56:47.800306','PATCH','Order fields updated','quay.hn',1604),(1721,'2026-08-12 12:56:47.996335','POD_QUAY','M2','quay.hn',1604),(1722,'2026-08-12 12:56:48.631492','CREATE','Internal create','quay.hn',1605),(1723,'2026-08-12 12:56:48.807988','PATCH','Order fields updated','quay.hn',1605),(1724,'2026-08-12 12:56:48.853921','PATCH','Order fields updated','quay.hn',1605),(1725,'2026-08-12 12:56:48.895982','PATCH','Order fields updated','quay.hn',1605),(1726,'2026-08-12 12:56:48.934878','PATCH','Order fields updated','quay.hn',1605),(1727,'2026-08-12 12:59:23.517514','CREATE','Internal create','quay.hn',1606),(1728,'2026-08-12 12:59:23.655098','POD_QUAY','X','quay.hn',1606),(1729,'2026-08-12 12:59:23.750533','RETURN_START','first-return','quay.hn',1606),(1730,'2026-08-12 12:59:23.962330','RT_DONE','Return completed','quay.hn',1606),(1731,'2026-08-12 12:59:24.044684','RETURN_START','second-return','quay.hn',1606),(1732,'2026-08-12 12:59:24.290511','CREATE','Internal create','quay.hn',1607),(1733,'2026-08-12 12:59:34.618104','CREATE','Internal create','quay.hn',1608),(1734,'2026-08-12 12:59:52.660326','CREATE','Internal create','quay.hn',1609),(1735,'2026-08-12 12:59:52.716307','POD_QUAY','X','quay.hn',1609),(1736,'2026-08-12 12:59:52.778637','RETURN_START','first-return','quay.hn',1609),(1737,'2026-08-12 12:59:52.925602','RT_DONE','Return completed','quay.hn',1609),(1738,'2026-08-12 12:59:52.985707','RETURN_START','second-return','quay.hn',1609),(1739,'2026-08-12 12:59:53.208992','CREATE','Internal create','quay.hn',1610),(1740,'2026-08-12 13:00:01.590979','CREATE','Internal create','quay.hn',1611),(1741,'2026-08-12 13:00:01.650535','PATCH','Order fields updated','quay.hn',1611),(1742,'2026-08-12 13:00:01.712488','SCAN_OUT','Trip T1','quay.hn',1611),(1743,'2026-08-12 13:00:01.861689','CREATE','Internal create','quay.hn',1612),(1744,'2026-08-12 13:00:01.935402','LEG_ADVANCE','Advanced to next leg','quay.hn',1612),(1745,'2026-08-12 13:00:02.055616','CREATE','Internal create','quay.hn',1613),(1746,'2026-08-12 13:00:02.217727','CREATE','Internal create','quay.hn',1614),(1747,'2026-08-12 13:00:02.652735','PATCH','Order fields updated','quay.hn',1614),(1748,'2026-08-12 13:00:02.760960','CREATE','Internal create','quay.hn',1615),(1749,'2026-08-12 13:00:02.829194','PATCH','Order fields updated','quay.hn',1615),(1750,'2026-08-12 13:00:03.017778','POD_QUAY','M2','quay.hn',1615),(1751,'2026-08-12 13:00:03.750733','CREATE','Internal create','quay.hn',1616),(1752,'2026-08-12 13:00:04.733780','CREATE','Internal create','quay.hn',1617),(1753,'2026-08-12 13:00:04.780447','PATCH','Order fields updated','quay.hn',1617),(1754,'2026-08-12 13:00:04.856952','CREATE','Internal create','quay.hn',1618),(1755,'2026-08-12 13:00:04.903722','LEG_ADVANCE','Advanced to next leg','quay.hn',1618),(1756,'2026-08-12 13:00:05.821040','CREATE','Internal create','quay.hn',1619),(1757,'2026-08-12 13:00:06.036321','PATCH','Order fields updated','quay.hn',1619),(1758,'2026-08-12 13:00:06.108722','PATCH','Order fields updated','quay.hn',1619),(1759,'2026-08-12 13:00:06.173896','PATCH','Order fields updated','quay.hn',1619),(1760,'2026-08-12 13:00:06.221122','PATCH','Order fields updated','quay.hn',1619),(1761,'2026-08-11 07:02:10.000000','DRAFT_CREATE','Public draft','customer',1620),(1763,'2026-08-12 13:02:10.307146','CREATE','Internal create','quay.hn',1621),(1764,'2026-08-12 13:02:10.405429','SCAN_OUT','T','quay.hn',1621),(1765,'2026-08-12 13:02:10.456591','SCAN_IN',NULL,'quay.hn',1621),(1766,'2026-08-12 13:02:10.504844','TAKE_JOB',NULL,'quay.hn',1621),(1767,'2026-08-12 13:02:10.565523','FAIL','r1','quay.hn',1621),(1768,'2026-08-12 13:02:10.613762','RETRY',NULL,'quay.hn',1621),(1769,'2026-08-12 13:02:10.660524','FAIL','r2','quay.hn',1621),(1770,'2026-08-12 13:02:10.708975','RETRY',NULL,'quay.hn',1621),(1771,'2026-08-12 13:02:10.761353','FAIL','r3','quay.hn',1621),(1772,'2026-08-12 13:02:10.766369','FAIL_MAX','3 lần — về AT_DEST','quay.hn',1621),(1773,'2026-08-11 07:02:44.000000','DRAFT_CREATE','Public draft','customer',1622),(1775,'2026-08-12 13:02:44.528060','CREATE','Internal create','quay.hn',1623),(1776,'2026-08-12 13:02:44.647496','SCAN_OUT','T','quay.hn',1623),(1777,'2026-08-12 13:02:44.710030','SCAN_IN',NULL,'quay.hn',1623),(1778,'2026-08-12 13:02:44.775765','TAKE_JOB',NULL,'quay.hn',1623),(1779,'2026-08-12 13:02:44.852319','FAIL','r1','quay.hn',1623),(1780,'2026-08-12 13:02:44.933544','RETRY',NULL,'quay.hn',1623),(1781,'2026-08-12 13:02:45.307887','FAIL','r2','quay.hn',1623),(1782,'2026-08-12 13:02:46.217524','RETRY',NULL,'quay.hn',1623),(1783,'2026-08-12 13:02:46.350339','FAIL','r3','quay.hn',1623),(1784,'2026-08-12 13:02:46.357021','FAIL_MAX','3 lần — về AT_DEST','quay.hn',1623),(1785,'2026-08-11 07:03:23.000000','DRAFT_CREATE','Public draft','customer',1624),(1786,'2026-08-12 13:03:23.289129','AUTO_CANCEL','DRAFT >24h','system',1624),(1787,'2026-08-12 13:03:23.405244','CREATE','Internal create','quay.hn',1625),(1788,'2026-08-12 13:03:23.513155','SCAN_OUT','T','quay.hn',1625),(1789,'2026-08-12 13:03:23.560196','SCAN_IN',NULL,'quay.hn',1625),(1790,'2026-08-12 13:03:23.608013','TAKE_JOB',NULL,'quay.hn',1625),(1791,'2026-08-12 13:03:23.661667','FAIL','r1','quay.hn',1625),(1792,'2026-08-12 13:03:23.714358','RETRY',NULL,'quay.hn',1625),(1793,'2026-08-12 13:03:23.752857','FAIL','r2','quay.hn',1625),(1794,'2026-08-12 13:03:23.792050','RETRY',NULL,'quay.hn',1625),(1795,'2026-08-12 13:03:23.830714','FAIL','r3','quay.hn',1625),(1796,'2026-08-12 13:03:23.837244','FAIL_MAX','3 lần — về AT_DEST','quay.hn',1625),(1797,'2026-08-12 13:04:07.472921','CREATE','Internal create','quay.hn',1626),(1798,'2026-08-12 13:04:07.529301','PATCH','Order fields updated','quay.hn',1626),(1799,'2026-08-12 13:04:07.588518','SCAN_OUT','Trip T1','quay.hn',1626),(1800,'2026-08-12 13:04:07.735719','CREATE','Internal create','quay.hn',1627),(1801,'2026-08-12 13:04:07.781937','LEG_ADVANCE','Advanced to next leg','quay.hn',1627),(1802,'2026-08-12 13:04:07.906015','CREATE','Internal create','quay.hn',1628),(1803,'2026-08-12 13:04:08.080499','CREATE','Internal create','quay.hn',1629),(1804,'2026-08-12 13:04:08.567273','PATCH','Order fields updated','quay.hn',1629),(1805,'2026-08-12 13:04:08.681619','CREATE','Internal create','quay.hn',1630),(1806,'2026-08-12 13:04:08.784829','PATCH','Order fields updated','quay.hn',1630),(1807,'2026-08-12 13:04:08.994003','POD_QUAY','M2','quay.hn',1630),(1808,'2026-08-12 13:04:09.629240','CREATE','Internal create','quay.hn',1631),(1809,'2026-08-12 13:04:09.845244','PATCH','Order fields updated','quay.hn',1631),(1810,'2026-08-12 13:04:09.907200','PATCH','Order fields updated','quay.hn',1631),(1811,'2026-08-12 13:04:09.963283','PATCH','Order fields updated','quay.hn',1631),(1812,'2026-08-12 13:04:10.030902','PATCH','Order fields updated','quay.hn',1631),(1813,'2026-08-12 13:05:20.470044','CREATE','Internal create','quay.hn',1632),(1814,'2026-08-12 13:05:21.860879','CREATE','Internal create','quay.hn',1633),(1815,'2026-08-12 13:05:21.917678','PATCH','Order fields updated','quay.hn',1633),(1816,'2026-08-12 13:05:22.010833','CREATE','Internal create','quay.hn',1634),(1817,'2026-08-12 13:05:22.067269','LEG_ADVANCE','Advanced to next leg','quay.hn',1634),(1818,'2026-08-12 13:05:23.060553','CREATE','Internal create','quay.hn',1635),(1819,'2026-08-12 13:05:23.135150','POD_QUAY','Recv','quay.hn',1635),(1820,'2026-08-12 13:05:23.516712','CREATE','Internal create','quay.hn',1636),(1821,'2026-08-12 13:05:23.668606','CREATE','Internal create','quay.hn',1637),(1822,'2026-08-12 13:05:23.730716','POD_QUAY','Z','quay.hn',1637),(1823,'2026-08-12 13:12:30.924245','CREATE','Internal create','quay.hn',1638),(1824,'2026-08-12 13:12:31.175529','PATCH','Order fields updated','quay.hn',1638),(1825,'2026-08-12 13:12:31.236705','PATCH','Order fields updated','quay.hn',1638),(1826,'2026-08-12 13:12:31.293293','PATCH','Order fields updated','quay.hn',1638),(1827,'2026-08-12 13:12:31.354310','PATCH','Order fields updated','quay.hn',1638),(1828,'2026-08-12 13:12:32.064434','CREATE','Internal create','quay.hn',1639),(1829,'2026-08-12 13:12:32.135840','POD_QUAY','Recv','quay.hn',1639),(1830,'2026-08-12 13:12:32.444389','CREATE','Internal create','quay.hn',1640),(1831,'2026-08-12 13:12:32.575642','CREATE','Internal create','quay.hn',1641),(1832,'2026-08-12 13:12:32.625236','POD_QUAY','Z','quay.hn',1641),(1833,'2026-08-12 13:12:33.354041','CREATE','Internal create','quay.hn',1642),(1834,'2026-08-12 13:12:33.397914','PATCH','Order fields updated','quay.hn',1642),(1835,'2026-08-12 13:12:33.466522','SCAN_OUT','Trip T1','quay.hn',1642),(1836,'2026-08-12 13:12:33.668746','CREATE','Internal create','quay.hn',1643),(1837,'2026-08-12 13:12:33.731703','LEG_ADVANCE','Advanced to next leg','quay.hn',1643),(1838,'2026-08-12 13:12:33.867235','CREATE','Internal create','quay.hn',1644),(1839,'2026-08-12 13:12:34.246252','CREATE','Internal create','quay.hn',1645),(1840,'2026-08-12 13:12:34.785286','PATCH','Order fields updated','quay.hn',1645),(1841,'2026-08-12 13:12:34.900877','CREATE','Internal create','quay.hn',1646),(1842,'2026-08-12 13:12:34.967254','PATCH','Order fields updated','quay.hn',1646),(1843,'2026-08-12 13:12:35.152560','POD_QUAY','M2','quay.hn',1646),(1844,'2026-08-12 13:12:35.913259','CREATE','Internal create','quay.hn',1647),(1845,'2026-08-12 13:12:36.886385','CREATE','Internal create','quay.hn',1648),(1846,'2026-08-12 13:12:36.921144','PATCH','Order fields updated','quay.hn',1648),(1847,'2026-08-12 13:12:36.976335','CREATE','Internal create','quay.hn',1649),(1848,'2026-08-12 13:12:37.007330','LEG_ADVANCE','Advanced to next leg','quay.hn',1649),(1849,'2026-08-12 13:12:38.069612','CREATE','Internal create','quay.hn',1650),(1850,'2026-08-12 13:12:38.847211','CREATE','Internal create','quay.hn',1651),(1851,'2026-08-12 13:12:38.903034','POD_QUAY','X','quay.hn',1651),(1852,'2026-08-12 13:12:38.950256','RETURN_START','first-return','quay.hn',1651),(1853,'2026-08-12 13:12:39.086704','RT_DONE','Return completed','quay.hn',1651),(1854,'2026-08-12 13:12:39.144840','RETURN_START','second-return','quay.hn',1651),(1855,'2026-08-12 13:12:39.371802','CREATE','Internal create','quay.hn',1652),(1856,'2026-08-11 07:12:40.000000','DRAFT_CREATE','Public draft','customer',1653),(1857,'2026-08-12 13:12:40.373238','AUTO_CANCEL','DRAFT >24h','system',1653),(1858,'2026-08-12 13:12:40.469142','CREATE','Internal create','quay.hn',1654),(1859,'2026-08-12 13:12:40.564648','SCAN_OUT','T','quay.hn',1654),(1860,'2026-08-12 13:12:40.609234','SCAN_IN',NULL,'quay.hn',1654),(1861,'2026-08-12 13:12:40.654045','TAKE_JOB',NULL,'quay.hn',1654),(1862,'2026-08-12 13:12:40.700928','FAIL','r1','quay.hn',1654),(1863,'2026-08-12 13:12:40.738459','RETRY',NULL,'quay.hn',1654),(1864,'2026-08-12 13:12:40.777320','FAIL','r2','quay.hn',1654),(1865,'2026-08-12 13:12:40.811622','RETRY',NULL,'quay.hn',1654),(1866,'2026-08-12 13:12:40.851720','FAIL','r3','quay.hn',1654),(1867,'2026-08-12 13:12:40.859813','FAIL_MAX','3 lần — về AT_DEST','quay.hn',1654),(1868,'2026-08-12 13:12:51.270919','CREATE','Internal create','admin',1655),(1869,'2026-08-12 13:12:51.446657','CREATE','Internal create','admin',1656),(1870,'2026-08-12 13:12:51.511576','CREATE','Internal create','admin',1657),(1871,'2026-08-12 13:12:51.574058','CREATE','Internal create','admin',1658),(1872,'2026-08-12 13:12:56.123323','CREATE','Internal create','quay.hn',1659),(1873,'2026-08-12 13:12:56.393012','PATCH','Order fields updated','quay.hn',1659),(1874,'2026-08-12 13:12:56.457220','PATCH','Order fields updated','quay.hn',1659),(1875,'2026-08-12 13:12:56.513600','PATCH','Order fields updated','quay.hn',1659),(1876,'2026-08-12 13:12:56.564403','PATCH','Order fields updated','quay.hn',1659),(1877,'2026-08-12 13:12:57.284354','CREATE','Internal create','quay.hn',1660),(1878,'2026-08-12 13:12:57.408537','POD_QUAY','Recv','quay.hn',1660),(1879,'2026-08-12 13:12:57.777197','CREATE','Internal create','quay.hn',1661),(1880,'2026-08-12 13:12:57.930230','CREATE','Internal create','quay.hn',1662),(1881,'2026-08-12 13:12:57.979046','POD_QUAY','Z','quay.hn',1662),(1882,'2026-08-12 13:12:58.781321','CREATE','Internal create','quay.hn',1663),(1883,'2026-08-12 13:12:58.825002','PATCH','Order fields updated','quay.hn',1663),(1884,'2026-08-12 13:12:58.882149','SCAN_OUT','Trip T1','quay.hn',1663),(1885,'2026-08-12 13:12:59.023526','CREATE','Internal create','quay.hn',1664),(1886,'2026-08-12 13:12:59.058960','LEG_ADVANCE','Advanced to next leg','quay.hn',1664),(1887,'2026-08-12 13:12:59.166853','CREATE','Internal create','quay.hn',1665),(1888,'2026-08-12 13:12:59.331257','CREATE','Internal create','quay.hn',1666),(1889,'2026-08-12 13:12:59.777517','PATCH','Order fields updated','quay.hn',1666),(1890,'2026-08-12 13:12:59.904557','CREATE','Internal create','quay.hn',1667),(1891,'2026-08-12 13:13:00.001633','PATCH','Order fields updated','quay.hn',1667),(1892,'2026-08-12 13:13:00.262040','POD_QUAY','M2','quay.hn',1667),(1893,'2026-08-12 13:13:00.976774','CREATE','Internal create','quay.hn',1668),(1894,'2026-08-12 13:13:01.993090','CREATE','Internal create','quay.hn',1669),(1895,'2026-08-12 13:13:02.027603','PATCH','Order fields updated','quay.hn',1669),(1896,'2026-08-12 13:13:02.075885','CREATE','Internal create','quay.hn',1670),(1897,'2026-08-12 13:13:02.121159','LEG_ADVANCE','Advanced to next leg','quay.hn',1670),(1898,'2026-08-12 13:13:03.054821','CREATE','Internal create','admin',1671),(1899,'2026-08-12 13:13:03.177219','CREATE','Internal create','admin',1672),(1900,'2026-08-12 13:13:03.225144','CREATE','Internal create','admin',1673),(1901,'2026-08-12 13:13:03.269522','CREATE','Internal create','admin',1674),(1902,'2026-08-12 13:13:04.067003','CREATE','Internal create','quay.hn',1675),(1903,'2026-08-12 13:13:04.126377','POD_QUAY','X','quay.hn',1675),(1904,'2026-08-12 13:13:04.188967','RETURN_START','first-return','quay.hn',1675),(1905,'2026-08-12 13:13:04.338740','RT_DONE','Return completed','quay.hn',1675),(1906,'2026-08-12 13:13:04.399710','RETURN_START','second-return','quay.hn',1675),(1907,'2026-08-12 13:13:04.644703','CREATE','Internal create','quay.hn',1676),(1908,'2026-08-11 07:13:05.000000','DRAFT_CREATE','Public draft','customer',1677),(1909,'2026-08-12 13:13:05.654883','AUTO_CANCEL','DRAFT >24h','system',1677),(1910,'2026-08-12 13:13:05.755394','CREATE','Internal create','quay.hn',1678),(1911,'2026-08-12 13:13:05.841897','SCAN_OUT','T','quay.hn',1678),(1912,'2026-08-12 13:13:05.892422','SCAN_IN',NULL,'quay.hn',1678),(1913,'2026-08-12 13:13:05.938680','TAKE_JOB',NULL,'quay.hn',1678),(1914,'2026-08-12 13:13:05.986347','FAIL','r1','quay.hn',1678),(1915,'2026-08-12 13:13:06.034984','RETRY',NULL,'quay.hn',1678),(1916,'2026-08-12 13:13:06.086823','FAIL','r2','quay.hn',1678),(1917,'2026-08-12 13:13:06.136951','RETRY',NULL,'quay.hn',1678),(1918,'2026-08-12 13:13:06.188993','FAIL','r3','quay.hn',1678),(1919,'2026-08-12 13:13:06.198855','FAIL_MAX','3 lần — về AT_DEST','quay.hn',1678),(1920,'2026-08-12 13:15:00.024120','AUTO_CANCEL','DRAFT >24h','system',1620),(1921,'2026-08-12 13:15:00.034406','AUTO_CANCEL','DRAFT >24h','system',1622),(1922,'2026-08-12 13:36:49.890226','RT_DONE','Return completed','admin',1675);
/*!40000 ALTER TABLE `order_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_fare_adjustment_request`
--

DROP TABLE IF EXISTS `order_fare_adjustment_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_fare_adjustment_request` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `requested_fare_amount` decimal(21,2) NOT NULL,
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `requested_by_username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `requested_at` datetime(6) NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `approved_by_username` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approved_at` datetime(6),
  `rejected_by_username` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rejected_at` datetime(6),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1500 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_fare_adjustment_request`
--

LOCK TABLES `order_fare_adjustment_request` WRITE;
/*!40000 ALTER TABLE `order_fare_adjustment_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_fare_adjustment_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_issue`
--

DROP TABLE IF EXISTS `order_issue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_issue` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `issue_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `issue_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opened_at` datetime(6) NOT NULL,
  `opened_by_username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `resolved_at` datetime(6),
  `resolved_by_username` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resolution_note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_id` bigint DEFAULT NULL,
  `open_order_key` bigint GENERATED ALWAYS AS ((case when (`issue_status` = _utf8mb4'OPEN') then `order_id` else NULL end)) STORED,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_order_issue_one_open` (`open_order_key`),
  KEY `idx_order_issue__order_id` (`order_id`),
  CONSTRAINT `fk_order_issue__order_id` FOREIGN KEY (`order_id`) REFERENCES `shipment_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1543 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_issue`
--

LOCK TABLES `order_issue` WRITE;
/*!40000 ALTER TABLE `order_issue` DISABLE KEYS */;
INSERT INTO `order_issue` (`id`, `issue_type`, `issue_status`, `reason`, `opened_at`, `opened_by_username`, `resolved_at`, `resolved_by_username`, `resolution_note`, `order_id`) VALUES (1500,'EXCEPTION','RESOLVED','test','2026-08-11 17:11:10.342131','quay.hn','2026-08-11 17:11:10.417550','quay.hn','ok',1509),(1501,'LOST','RESOLVED','e2e lost','2026-08-11 17:16:38.685815','quay.hn','2026-08-11 17:16:38.788136','quay.hn','fixed',1513),(1502,'LOST','RESOLVED','e2e lost','2026-08-11 17:21:53.688870','quay.hn','2026-08-11 17:21:53.802933','quay.hn','fixed',1518),(1503,'DAMAGED','OPEN','box','2026-08-11 17:25:07.340012','quay.hn',NULL,NULL,NULL,1520),(1504,'LOST','OPEN','retest','2026-08-11 17:27:45.077042','quay.hn',NULL,NULL,NULL,1521),(1505,'LOST','RESOLVED','retest','2026-08-11 17:28:12.488078','quay.hn','2026-08-11 17:28:12.664461','quay.hn','ok',1522),(1506,'LOST','RESOLVED','e2e lost','2026-08-11 17:28:24.722229','quay.hn','2026-08-11 17:28:24.832716','quay.hn','fixed',1526),(1507,'LOST','RESOLVED','e2e lost','2026-08-12 02:21:02.128194','quay.hn','2026-08-12 02:21:02.227382','quay.hn','fixed',1532),(1508,'LOST','RESOLVED','first-open','2026-08-12 03:32:27.261223','quay.hn','2026-08-12 03:32:27.767932','quay.hn','fixed-1',NULL),(1509,'EXCEPTION','OPEN','second-after-resolve','2026-08-12 03:32:28.140987','quay.hn',NULL,NULL,NULL,1542),(1510,'LOST','RESOLVED','first','2026-08-12 11:02:13.653219','quay.hn','2026-08-12 11:02:13.849695','quay.hn','fixed-1',1559),(1511,'EXCEPTION','RESOLVED','second','2026-08-12 11:02:14.042112','quay.hn','2026-08-12 11:02:14.329998','quay.hn','fixed-2',1559),(1512,'LOST','OPEN','third','2026-08-12 11:02:14.385490','quay.hn',NULL,NULL,NULL,1559),(1513,'LOST','RESOLVED','first','2026-08-12 12:31:49.811324','quay.hn','2026-08-12 12:31:50.099496','quay.hn','fixed-1',1564),(1514,'LOST','RESOLVED','first','2026-08-12 12:31:56.696794','quay.hn','2026-08-12 12:31:56.849639','quay.hn','fixed-1',1570),(1515,'EXCEPTION','RESOLVED','second','2026-08-12 12:31:57.034429','quay.hn','2026-08-12 12:31:57.294735','quay.hn','fixed-2',1570),(1516,'LOST','OPEN','third','2026-08-12 12:31:57.344601','quay.hn',NULL,NULL,NULL,1570),(1517,'LOST','RESOLVED','first','2026-08-12 12:51:15.438180','quay.hn','2026-08-12 12:51:15.669342','quay.hn','fixed-1',1581),(1518,'EXCEPTION','RESOLVED','second','2026-08-12 12:51:15.992466','quay.hn','2026-08-12 12:51:16.320017','quay.hn','fixed-2',1581),(1519,'LOST','OPEN','third','2026-08-12 12:51:16.371507','quay.hn',NULL,NULL,NULL,1581),(1520,'LOST','RESOLVED','first','2026-08-12 12:53:12.761688','quay.hn','2026-08-12 12:53:13.053054','quay.hn','fixed-1',1593),(1521,'EXCEPTION','RESOLVED','second','2026-08-12 12:53:13.435138','quay.hn','2026-08-12 12:53:13.792323','quay.hn','fixed-2',1593),(1522,'LOST','OPEN','third','2026-08-12 12:53:13.859007','quay.hn',NULL,NULL,NULL,1593),(1523,'LOST','RESOLVED','a','2026-08-12 12:59:24.350885','quay.hn','2026-08-12 12:59:24.422372','quay.hn','ok',1607),(1524,'LOST','RESOLVED','a','2026-08-12 12:59:34.739759','quay.hn','2026-08-12 12:59:34.817212','quay.hn','ok',1608),(1525,'LOST','RESOLVED','a','2026-08-12 12:59:53.249145','quay.hn','2026-08-12 12:59:53.299315','quay.hn','ok',1610),(1526,'DAMAGED','OPEN','b','2026-08-12 12:59:53.348170','quay.hn',NULL,NULL,NULL,1610),(1527,'LOST','RESOLVED','first','2026-08-12 13:00:03.846820','quay.hn','2026-08-12 13:00:04.014012','quay.hn','fixed-1',1616),(1528,'EXCEPTION','RESOLVED','second','2026-08-12 13:00:04.202590','quay.hn','2026-08-12 13:00:04.470428','quay.hn','fixed-2',1616),(1529,'LOST','OPEN','third','2026-08-12 13:00:04.521605','quay.hn',NULL,NULL,NULL,1616),(1530,'LOST','RESOLVED','first','2026-08-12 13:05:20.697859','quay.hn','2026-08-12 13:05:20.932766','quay.hn','fixed-1',1632),(1531,'EXCEPTION','RESOLVED','second','2026-08-12 13:05:21.279518','quay.hn','2026-08-12 13:05:21.556006','quay.hn','fixed-2',1632),(1532,'LOST','OPEN','third','2026-08-12 13:05:21.616736','quay.hn',NULL,NULL,NULL,1632),(1533,'LOST','RESOLVED','first','2026-08-12 13:12:36.001851','quay.hn','2026-08-12 13:12:36.161822','quay.hn','fixed-1',1647),(1534,'EXCEPTION','RESOLVED','second','2026-08-12 13:12:36.346133','quay.hn','2026-08-12 13:12:36.594351','quay.hn','fixed-2',1647),(1535,'LOST','OPEN','third','2026-08-12 13:12:36.647516','quay.hn',NULL,NULL,NULL,1647),(1536,'LOST','RESOLVED','a','2026-08-12 13:12:39.407204','quay.hn','2026-08-12 13:12:39.451513','quay.hn','ok',1652),(1537,'DAMAGED','OPEN','b','2026-08-12 13:12:39.494219','quay.hn',NULL,NULL,NULL,1652),(1538,'LOST','RESOLVED','first','2026-08-12 13:13:01.074361','quay.hn','2026-08-12 13:13:01.245973','quay.hn','fixed-1',1668),(1539,'EXCEPTION','RESOLVED','second','2026-08-12 13:13:01.473622','quay.hn','2026-08-12 13:13:01.734719','quay.hn','fixed-2',1668),(1540,'LOST','OPEN','third','2026-08-12 13:13:01.772334','quay.hn',NULL,NULL,NULL,1668),(1541,'LOST','RESOLVED','a','2026-08-12 13:13:04.695831','quay.hn','2026-08-12 13:13:04.751069','quay.hn','ok',1676),(1542,'DAMAGED','OPEN','b','2026-08-12 13:13:04.800982','quay.hn',NULL,NULL,NULL,1676);
/*!40000 ALTER TABLE `order_issue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_item` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `line_no` int NOT NULL,
  `item_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int NOT NULL,
  `weight_kg` decimal(21,2) DEFAULT NULL,
  `length_cm` decimal(21,2) DEFAULT NULL,
  `width_cm` decimal(21,2) DEFAULT NULL,
  `height_cm` decimal(21,2) DEFAULT NULL,
  `declared_value_amount` decimal(21,2) DEFAULT NULL,
  `fare_amount` decimal(21,2) DEFAULT NULL,
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_order_item__order_id` (`order_id`),
  CONSTRAINT `fk_order_item__order_id` FOREIGN KEY (`order_id`) REFERENCES `shipment_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1500 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_leg`
--

DROP TABLE IF EXISTS `order_leg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_leg` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `leg_index` int NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `departed_at` datetime(6),
  `arrived_at` datetime(6),
  `order_id` bigint NOT NULL,
  `from_office_id` bigint NOT NULL,
  `to_office_id` bigint NOT NULL,
  `trip_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_order_leg__order_id` (`order_id`),
  KEY `fk_order_leg__from_office_id` (`from_office_id`),
  KEY `fk_order_leg__to_office_id` (`to_office_id`),
  KEY `fk_order_leg__trip_id` (`trip_id`),
  CONSTRAINT `fk_order_leg__from_office_id` FOREIGN KEY (`from_office_id`) REFERENCES `office` (`id`),
  CONSTRAINT `fk_order_leg__order_id` FOREIGN KEY (`order_id`) REFERENCES `shipment_order` (`id`),
  CONSTRAINT `fk_order_leg__to_office_id` FOREIGN KEY (`to_office_id`) REFERENCES `office` (`id`),
  CONSTRAINT `fk_order_leg__trip_id` FOREIGN KEY (`trip_id`) REFERENCES `trip` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1546 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_leg`
--

LOCK TABLES `order_leg` WRITE;
/*!40000 ALTER TABLE `order_leg` DISABLE KEYS */;
INSERT INTO `order_leg` VALUES (1500,0,'AT_HUB',NULL,'2026-08-12 02:35:34.694793',1534,9,5,NULL),(1501,1,'AT_DEST',NULL,'2026-08-12 02:35:34.758186',1534,5,8,NULL),(1502,0,'AT_HUB',NULL,'2026-08-12 03:32:24.707733',1537,9,5,NULL),(1503,1,'AT_DEST',NULL,'2026-08-12 03:32:24.914715',1537,5,8,NULL),(1504,0,'AT_HUB',NULL,'2026-08-12 03:33:37.037652',1546,9,5,NULL),(1505,1,'PENDING',NULL,NULL,1546,5,8,NULL),(1506,0,'AT_HUB',NULL,'2026-08-12 03:35:24.855040',1549,9,5,NULL),(1507,1,'PENDING',NULL,NULL,1549,5,8,NULL),(1508,0,'AT_HUB',NULL,'2026-08-12 04:12:01.441926',1552,9,5,NULL),(1509,1,'PENDING',NULL,NULL,1552,5,8,NULL),(1510,0,'AT_HUB',NULL,'2026-08-12 04:12:29.323698',1556,9,5,NULL),(1511,1,'PENDING',NULL,NULL,1556,5,8,NULL),(1512,0,'AT_HUB',NULL,'2026-08-12 11:02:14.776886',1561,9,5,NULL),(1513,1,'PENDING',NULL,NULL,1561,5,8,NULL),(1514,0,'AT_HUB',NULL,'2026-08-12 12:31:49.957502',1565,9,5,NULL),(1515,1,'PENDING',NULL,NULL,1565,5,8,NULL),(1516,0,'AT_HUB',NULL,'2026-08-12 12:31:51.410393',1569,9,5,NULL),(1517,1,'PENDING',NULL,NULL,1569,5,8,NULL),(1518,0,'AT_HUB',NULL,'2026-08-12 12:31:57.748730',1572,9,5,NULL),(1519,1,'PENDING',NULL,NULL,1572,5,8,NULL),(1520,0,'AT_HUB',NULL,'2026-08-12 12:51:11.675701',1577,9,5,NULL),(1521,1,'PENDING',NULL,NULL,1577,5,8,NULL),(1522,0,'AT_HUB',NULL,'2026-08-12 12:51:16.820357',1583,9,5,NULL),(1523,1,'PENDING',NULL,NULL,1583,5,8,NULL),(1524,0,'AT_HUB',NULL,'2026-08-12 12:53:03.472134',1585,9,5,NULL),(1525,1,'PENDING',NULL,NULL,1585,5,8,NULL),(1526,0,'AT_HUB',NULL,'2026-08-12 12:53:14.373434',1595,9,5,NULL),(1527,1,'PENDING',NULL,NULL,1595,5,8,NULL),(1528,0,'AT_HUB',NULL,'2026-08-12 12:56:46.977339',1601,9,5,NULL),(1529,1,'PENDING',NULL,NULL,1601,5,8,NULL),(1530,0,'AT_HUB',NULL,'2026-08-12 13:00:01.935402',1612,9,5,NULL),(1531,1,'PENDING',NULL,NULL,1612,5,8,NULL),(1532,0,'AT_HUB',NULL,'2026-08-12 13:00:04.903722',1618,9,5,NULL),(1533,1,'PENDING',NULL,NULL,1618,5,8,NULL),(1534,0,'AT_HUB',NULL,'2026-08-12 13:04:07.780940',1627,9,5,NULL),(1535,1,'PENDING',NULL,NULL,1627,5,8,NULL),(1536,0,'AT_HUB',NULL,'2026-08-12 13:05:22.067269',1634,9,5,NULL),(1537,1,'PENDING',NULL,NULL,1634,5,8,NULL),(1538,0,'AT_HUB',NULL,'2026-08-12 13:12:33.730702',1643,9,5,NULL),(1539,1,'PENDING',NULL,NULL,1643,5,8,NULL),(1540,0,'AT_HUB',NULL,'2026-08-12 13:12:37.005957',1649,9,5,NULL),(1541,1,'PENDING',NULL,NULL,1649,5,8,NULL),(1542,0,'AT_HUB',NULL,'2026-08-12 13:12:59.058960',1664,9,5,NULL),(1543,1,'PENDING',NULL,NULL,1664,5,8,NULL),(1544,0,'AT_HUB',NULL,'2026-08-12 13:13:02.121159',1670,9,5,NULL),(1545,1,'PENDING',NULL,NULL,1670,5,8,NULL);
/*!40000 ALTER TABLE `order_leg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_payment`
--

DROP TABLE IF EXISTS `order_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_payment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `payment_at` datetime(6) NOT NULL,
  `amount` decimal(21,2) NOT NULL,
  `method` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_kind` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `collector_username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_order_payment__order_id` (`order_id`),
  CONSTRAINT `fk_order_payment__order_id` FOREIGN KEY (`order_id`) REFERENCES `shipment_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1545 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_payment`
--

LOCK TABLES `order_payment` WRITE;
/*!40000 ALTER TABLE `order_payment` DISABLE KEYS */;
INSERT INTO `order_payment` VALUES (1500,'2026-08-11 17:11:10.485219',40000.00,'TM','SAU','RECEIPT','quay.hn',1509),(1501,'2026-08-11 17:16:38.133507',10000.00,'TM','SAU','POD COUNTER','quay.hn',1512),(1502,'2026-08-11 17:16:38.933065',35000.00,'TM','SAU','RECEIPT','quay.hn',1514),(1503,'2026-08-11 17:21:53.110809',10000.00,'TM','SAU','POD COUNTER','quay.hn',1517),(1504,'2026-08-11 17:21:53.968510',35000.00,'TM','SAU','RECEIPT','quay.hn',1519),(1505,'2026-08-11 17:28:24.001101',10000.00,'TM','SAU','POD COUNTER','quay.hn',1525),(1506,'2026-08-11 17:28:24.975538',35000.00,'TM','SAU','RECEIPT','quay.hn',1527),(1507,'2026-08-12 02:21:01.669619',10000.00,'TM','SAU','POD COUNTER','quay.hn',1531),(1508,'2026-08-12 02:21:02.369064',35000.00,'TM','SAU','RECEIPT','quay.hn',1533),(1509,'2026-08-12 03:32:24.186761',30000.00,'TM','SAU','prepay','quay.hn',1536),(1510,'2026-08-12 03:32:25.410867',20000.00,'TM','SAU','partial','quay.hn',1539),(1511,'2026-08-12 03:32:25.675768',30000.00,'TM','SAU','POD COUNTER','quay.hn',1539),(1512,'2026-08-12 03:32:26.125115',10000.00,'TM','SAU','POD COUNTER','quay.hn',1540),(1513,'2026-08-12 03:32:26.275683',30000.00,'TM','SAU',NULL,'quay.hn',1540),(1514,'2026-08-12 04:12:01.292979',5000.00,'TM','SAU',NULL,'quay.hn',1551),(1515,'2026-08-12 04:12:29.164998',5000.00,'TM','SAU',NULL,'quay.hn',1555),(1516,'2026-08-12 12:31:32.654338',30000.00,'TM','SAU','h1-prepay','quay.hn',1562),(1517,'2026-08-12 12:31:49.769441',5000.00,'TM','SAU',NULL,'quay.hn',1563),(1518,'2026-08-12 12:51:06.198046',10000.00,'TM','SAU','POD COUNTER','quay.hn',1573),(1519,'2026-08-12 12:51:06.519601',30000.00,'TM','SAU','m1-topup','quay.hn',1573),(1520,'2026-08-12 12:51:11.520488',5000.00,'TM','SAU',NULL,'quay.hn',1576),(1521,'2026-08-12 12:51:13.602603',30000.00,'TM','SAU','h1-prepay','quay.hn',1580),(1522,'2026-08-12 12:53:03.361479',5000.00,'TM','SAU',NULL,'quay.hn',1584),(1523,'2026-08-12 12:53:09.273962',30000.00,'TM','SAU','h1-prepay','quay.hn',1589),(1524,'2026-08-12 12:53:10.752440',10000.00,'TM','SAU','POD COUNTER','quay.hn',1590),(1525,'2026-08-12 12:53:11.057853',30000.00,'TM','SAU','m1-topup','quay.hn',1590),(1526,'2026-08-12 12:56:39.508330',10000.00,'TM','SAU',NULL,'quay.hn',1599),(1527,'2026-08-12 12:56:46.831776',5000.00,'TM','SAU',NULL,'quay.hn',1600),(1528,'2026-08-12 12:56:48.671861',30000.00,'TM','SAU','h1-prepay','quay.hn',1605),(1529,'2026-08-12 13:00:01.768797',5000.00,'TM','SAU',NULL,'quay.hn',1611),(1530,'2026-08-12 13:00:05.870604',30000.00,'TM','SAU','h1-prepay','quay.hn',1619),(1531,'2026-08-12 13:04:07.648167',5000.00,'TM','SAU',NULL,'quay.hn',1626),(1532,'2026-08-12 13:04:09.696112',30000.00,'TM','SAU','h1-prepay','quay.hn',1631),(1533,'2026-08-12 13:05:23.124930',10000.00,'TM','SAU','POD COUNTER','quay.hn',1635),(1534,'2026-08-12 13:05:23.437026',30000.00,'TM','SAU','m1-topup','quay.hn',1635),(1535,'2026-08-12 13:12:31.006841',30000.00,'TM','SAU','h1-prepay','quay.hn',1638),(1536,'2026-08-12 13:12:32.128482',10000.00,'TM','SAU','POD COUNTER','quay.hn',1639),(1537,'2026-08-12 13:12:32.389970',30000.00,'TM','SAU','m1-topup','quay.hn',1639),(1538,'2026-08-12 13:12:33.534236',5000.00,'TM','SAU',NULL,'quay.hn',1642),(1539,'2026-08-12 13:12:51.617154',10000.00,'TM','SAU',NULL,'admin',1658),(1540,'2026-08-12 13:12:56.185772',30000.00,'TM','SAU','h1-prepay','quay.hn',1659),(1541,'2026-08-12 13:12:57.395546',10000.00,'TM','SAU','POD COUNTER','quay.hn',1660),(1542,'2026-08-12 13:12:57.719649',30000.00,'TM','SAU','m1-topup','quay.hn',1660),(1543,'2026-08-12 13:12:58.929557',5000.00,'TM','SAU',NULL,'quay.hn',1663),(1544,'2026-08-12 13:13:03.306272',10000.00,'TM','SAU',NULL,'admin',1674);
/*!40000 ALTER TABLE `order_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_pod_photo`
--

DROP TABLE IF EXISTS `order_pod_photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_pod_photo` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `photo_url` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `captured_at` datetime(6) NOT NULL,
  `captured_by_username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sequence_no` int DEFAULT NULL,
  `order_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_order_pod_photo__order_id` (`order_id`),
  CONSTRAINT `fk_order_pod_photo__order_id` FOREIGN KEY (`order_id`) REFERENCES `shipment_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1537 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_pod_photo`
--

LOCK TABLES `order_pod_photo` WRITE;
/*!40000 ALTER TABLE `order_pod_photo` DISABLE KEYS */;
INSERT INTO `order_pod_photo` VALUES (1500,'local-pod-1','2026-08-11 17:16:38.121080','quay.hn',1,1512),(1501,'local-pod-1','2026-08-11 17:21:53.101223','quay.hn',1,1517),(1502,'local-pod-1','2026-08-11 17:28:23.989692','quay.hn',1,1525),(1503,'local-pod-1','2026-08-12 02:21:01.655345','quay.hn',1,1531),(1505,'pod-ok','2026-08-12 03:32:25.661278','quay.hn',1,1539),(1506,'u1','2026-08-12 03:32:26.106477','quay.hn',1,1540),(1508,'d0','2026-08-12 03:32:30.097500','quay.hn',1,1543),(1511,'z','2026-08-12 03:35:25.120105','quay.hn',1,1550),(1512,'m1-photo-1','2026-08-12 12:51:06.185650','quay.hn',1,1573),(1514,'z','2026-08-12 12:51:06.811168','quay.hn',1,1575),(1515,'m2b','2026-08-12 12:53:04.576132','quay.hn',1,1588),(1516,'m1-photo-1','2026-08-12 12:53:10.742926','quay.hn',1,1590),(1518,'z','2026-08-12 12:53:11.327996','quay.hn',1,1592),(1519,'m2b','2026-08-12 12:56:47.986071','quay.hn',1,1604),(1520,'r8','2026-08-12 12:59:23.628801','quay.hn',1,1606),(1521,'r8','2026-08-12 12:59:52.705899','quay.hn',1,1609),(1522,'m2b','2026-08-12 13:00:03.009780','quay.hn',1,1615),(1523,'m2b','2026-08-12 13:04:08.984673','quay.hn',1,1630),(1524,'m1-photo-1','2026-08-12 13:05:23.113389','quay.hn',1,1635),(1526,'z','2026-08-12 13:05:23.721915','quay.hn',1,1637),(1527,'m1-photo-1','2026-08-12 13:12:32.117896','quay.hn',1,1639),(1529,'z','2026-08-12 13:12:32.616713','quay.hn',1,1641),(1530,'m2b','2026-08-12 13:12:35.145508','quay.hn',1,1646),(1531,'r8','2026-08-12 13:12:38.894169','quay.hn',1,1651),(1532,'m1-photo-1','2026-08-12 13:12:57.385037','quay.hn',1,1660),(1534,'z','2026-08-12 13:12:57.968864','quay.hn',1,1662),(1535,'m2b','2026-08-12 13:13:00.253579','quay.hn',1,1667),(1536,'r8','2026-08-12 13:13:04.120012','quay.hn',1,1675);
/*!40000 ALTER TABLE `order_pod_photo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_return_request`
--

DROP TABLE IF EXISTS `order_return_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_return_request` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `requested_by_username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `requested_at` datetime(6) NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `decided_by_username` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `decided_at` datetime(6),
  `decision_note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_order_return_request__order_id` (`order_id`),
  CONSTRAINT `fk_order_return_request__order_id` FOREIGN KEY (`order_id`) REFERENCES `shipment_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1512 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_return_request`
--

LOCK TABLES `order_return_request` WRITE;
/*!40000 ALTER TABLE `order_return_request` DISABLE KEYS */;
INSERT INTO `order_return_request` VALUES (1500,'e2e-return','quay.hn','2026-08-11 17:16:38.456956','APPROVED','quay.hn','2026-08-11 17:16:38.456956',NULL,1512),(1501,'e2e-return','quay.hn','2026-08-11 17:21:53.439818','APPROVED','quay.hn','2026-08-11 17:21:53.439818',NULL,1517),(1502,'e2e-return','quay.hn','2026-08-11 17:28:24.458039','APPROVED','quay.hn','2026-08-11 17:28:24.458039',NULL,1525),(1503,'e2e-return','quay.hn','2026-08-12 02:21:01.924350','APPROVED','quay.hn','2026-08-12 02:21:01.924350',NULL,1531),(1504,'first-return','quay.hn','2026-08-12 12:59:23.739632','APPROVED','quay.hn','2026-08-12 12:59:23.739632',NULL,1606),(1505,'second-return','quay.hn','2026-08-12 12:59:24.035361','APPROVED','quay.hn','2026-08-12 12:59:24.035361',NULL,1606),(1506,'first-return','quay.hn','2026-08-12 12:59:52.770171','APPROVED','quay.hn','2026-08-12 12:59:52.770171',NULL,1609),(1507,'second-return','quay.hn','2026-08-12 12:59:52.977143','APPROVED','quay.hn','2026-08-12 12:59:52.977143',NULL,1609),(1508,'first-return','quay.hn','2026-08-12 13:12:38.942655','APPROVED','quay.hn','2026-08-12 13:12:38.942655',NULL,1651),(1509,'second-return','quay.hn','2026-08-12 13:12:39.137672','APPROVED','quay.hn','2026-08-12 13:12:39.137672',NULL,1651),(1510,'first-return','quay.hn','2026-08-12 13:13:04.182640','APPROVED','quay.hn','2026-08-12 13:13:04.182640',NULL,1675),(1511,'second-return','quay.hn','2026-08-12 13:13:04.392138','APPROVED','quay.hn','2026-08-12 13:13:04.392138',NULL,1675);
/*!40000 ALTER TABLE `order_return_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pricing_change_log`
--

DROP TABLE IF EXISTS `pricing_change_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pricing_change_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `changed_at` datetime(6) NOT NULL,
  `changed_by_username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `before_json` longtext COLLATE utf8mb4_unicode_ci,
  `after_json` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `pricing_rule_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pricing_change_log__pricing_rule_id` (`pricing_rule_id`),
  CONSTRAINT `fk_pricing_change_log__pricing_rule_id` FOREIGN KEY (`pricing_rule_id`) REFERENCES `pricing_rule` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1500 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pricing_change_log`
--

LOCK TABLES `pricing_change_log` WRITE;
/*!40000 ALTER TABLE `pricing_change_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `pricing_change_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pricing_rule`
--

DROP TABLE IF EXISTS `pricing_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pricing_rule` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `rule_code` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tier_label` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `min_kg` decimal(21,2) NOT NULL,
  `max_kg` decimal(21,2) NOT NULL,
  `unit_price` decimal(21,2) NOT NULL,
  `surcharge_amount` decimal(21,2) NOT NULL,
  `dim_divisor` int DEFAULT NULL,
  `km_min` decimal(21,2) DEFAULT NULL,
  `km_rate` decimal(21,2) DEFAULT NULL,
  `step_gram` int DEFAULT NULL,
  `add_fee_amount` decimal(21,2) DEFAULT NULL,
  `effective_from` datetime(6) NOT NULL,
  `effective_to` datetime(6),
  `active` tinyint NOT NULL,
  `route_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_pricing_rule__rule_code` (`rule_code`),
  KEY `fk_pricing_rule__route_id` (`route_id`),
  CONSTRAINT `fk_pricing_rule__route_id` FOREIGN KEY (`route_id`) REFERENCES `route` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1503 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pricing_rule`
--

LOCK TABLES `pricing_rule` WRITE;
/*!40000 ALTER TABLE `pricing_rule` DISABLE KEYS */;
INSERT INTO `pricing_rule` VALUES (1500,'T4-b832ee5a','T4-0-5kg',0.00,5.00,12000.00,3000.00,6000,2.00,5000.00,NULL,NULL,'2026-08-12 12:56:39.000000',NULL,1,1),(1501,'T4-896838b4','T4-0-5kg',0.00,5.00,12000.00,3000.00,6000,2.00,5000.00,NULL,NULL,'2026-08-12 13:12:51.000000',NULL,1,1),(1502,'T4-f5f1a5c6','T4-0-5kg',0.00,5.00,12000.00,3000.00,6000,2.00,5000.00,NULL,NULL,'2026-08-12 13:13:03.000000',NULL,1,1);
/*!40000 ALTER TABLE `pricing_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_price_rule`
--

DROP TABLE IF EXISTS `product_price_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_price_rule` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `current_price` decimal(21,2) DEFAULT NULL,
  `applied_price` decimal(21,2) NOT NULL,
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1500 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_price_rule`
--

LOCK TABLES `product_price_rule` WRITE;
/*!40000 ALTER TABLE `product_price_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_price_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receipt`
--

DROP TABLE IF EXISTS `receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receipt` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `receipt_code` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payer_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payer_code` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_amount` decimal(21,2) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `created_by_username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `office_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_receipt__receipt_code` (`receipt_code`),
  KEY `fk_receipt__office_id` (`office_id`),
  CONSTRAINT `fk_receipt__office_id` FOREIGN KEY (`office_id`) REFERENCES `office` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1505 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receipt`
--

LOCK TABLES `receipt` WRITE;
/*!40000 ALTER TABLE `receipt` DISABLE KEYS */;
INSERT INTO `receipt` VALUES (1500,'PTGP260812-001','quay.hn','QUAY.HN',40000.00,'2026-08-11 17:11:10.485219','quay.hn',5),(1501,'PTGP260812-002','E2E Payer','E2E',35000.00,'2026-08-11 17:16:38.933065','quay.hn',5),(1502,'PTGP260812-003','E2E Payer','E2E',35000.00,'2026-08-11 17:21:53.968510','quay.hn',5),(1503,'PTGP260812-004','E2E Payer','E2E',35000.00,'2026-08-11 17:28:24.975538','quay.hn',5),(1504,'PTGP260812-005','E2E Payer','E2E',35000.00,'2026-08-12 02:21:02.369064','quay.hn',5);
/*!40000 ALTER TABLE `receipt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receipt_order_line`
--

DROP TABLE IF EXISTS `receipt_order_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receipt_order_line` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `amount_collected` decimal(21,2) NOT NULL,
  `receipt_id` bigint NOT NULL,
  `order_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_receipt_order_line__receipt_id` (`receipt_id`),
  KEY `fk_receipt_order_line__order_id` (`order_id`),
  CONSTRAINT `fk_receipt_order_line__order_id` FOREIGN KEY (`order_id`) REFERENCES `shipment_order` (`id`),
  CONSTRAINT `fk_receipt_order_line__receipt_id` FOREIGN KEY (`receipt_id`) REFERENCES `receipt` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1505 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receipt_order_line`
--

LOCK TABLES `receipt_order_line` WRITE;
/*!40000 ALTER TABLE `receipt_order_line` DISABLE KEYS */;
INSERT INTO `receipt_order_line` VALUES (1500,40000.00,1500,1509),(1501,35000.00,1501,1514),(1502,35000.00,1502,1519),(1503,35000.00,1503,1527),(1504,35000.00,1504,1533);
/*!40000 ALTER TABLE `receipt_order_line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `route`
--

DROP TABLE IF EXISTS `route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `route` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint NOT NULL,
  `from_office_id` bigint NOT NULL,
  `to_office_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_route__code` (`code`),
  KEY `fk_route__from_office_id` (`from_office_id`),
  KEY `fk_route__to_office_id` (`to_office_id`),
  CONSTRAINT `fk_route__from_office_id` FOREIGN KEY (`from_office_id`) REFERENCES `office` (`id`),
  CONSTRAINT `fk_route__to_office_id` FOREIGN KEY (`to_office_id`) REFERENCES `office` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1500 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `route`
--

LOCK TABLES `route` WRITE;
/*!40000 ALTER TABLE `route` DISABLE KEYS */;
INSERT INTO `route` VALUES (1,'GP-NB','GP → NB',1,5,8),(2,'GP-VT','GP → VT',1,5,13),(3,'VT-NB','VT → NB',1,13,8),(4,'NB-TB','NB → TB',1,8,11),(5,'GP-ND','GP → ND',1,5,9);
/*!40000 ALTER TABLE `route` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipment_order`
--

DROP TABLE IF EXISTS `shipment_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipment_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_code` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `draft_code` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `forward_stage` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `return_stage` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_term` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `goods_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `service_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sender_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sender_phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `receiver_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `receiver_phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `delivery_address` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pickup_address` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `home_pickup` tinyint NOT NULL,
  `home_delivery` tinyint NOT NULL,
  `qr_drop_off` tinyint NOT NULL,
  `pickup_staff_username` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `picking_at` datetime(6),
  `picked_up_at` datetime(6),
  `receiver_actual_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receiver_actual_phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `weight_kg` decimal(21,2) DEFAULT NULL,
  `quantity` int NOT NULL,
  `dimensions_text` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fare_amount` decimal(21,2) NOT NULL,
  `pickup_fee_amount` decimal(21,2) DEFAULT NULL,
  `delivery_fee_amount` decimal(21,2) DEFAULT NULL,
  `partner_fee_amount` decimal(21,2) DEFAULT NULL,
  `paid_amount` decimal(21,2) NOT NULL,
  `shelf_number` int DEFAULT NULL,
  `note` longtext COLLATE utf8mb4_unicode_ci,
  `cancel_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `label_printed_at` datetime(6),
  `label_reprint_count` int DEFAULT NULL,
  `fail_count` int NOT NULL,
  `partner_code` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_percent` decimal(21,2) DEFAULT NULL,
  `public_tracking_allowed` tinyint NOT NULL,
  `issue_id` bigint DEFAULT NULL,
  `return_request_id` bigint DEFAULT NULL,
  `fare_adjustment_request_id` bigint DEFAULT NULL,
  `sender_customer_id` bigint DEFAULT NULL,
  `from_office_id` bigint NOT NULL,
  `to_office_id` bigint NOT NULL,
  `hub_office_id` bigint DEFAULT NULL,
  `final_to_office_id` bigint DEFAULT NULL,
  `current_trip_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_shipment_order__order_code` (`order_code`),
  UNIQUE KEY `ux_shipment_order__draft_code` (`draft_code`),
  UNIQUE KEY `ux_shipment_order__issue_id` (`issue_id`),
  UNIQUE KEY `ux_shipment_order__return_request_id` (`return_request_id`),
  UNIQUE KEY `ux_shipment_order__fare_adjustment_request_id` (`fare_adjustment_request_id`),
  KEY `fk_shipment_order__sender_customer_id` (`sender_customer_id`),
  KEY `fk_shipment_order__from_office_id` (`from_office_id`),
  KEY `fk_shipment_order__to_office_id` (`to_office_id`),
  KEY `fk_shipment_order__hub_office_id` (`hub_office_id`),
  KEY `fk_shipment_order__final_to_office_id` (`final_to_office_id`),
  KEY `fk_shipment_order__current_trip_id` (`current_trip_id`),
  CONSTRAINT `fk_shipment_order__current_trip_id` FOREIGN KEY (`current_trip_id`) REFERENCES `trip` (`id`),
  CONSTRAINT `fk_shipment_order__fare_adjustment_request_id` FOREIGN KEY (`fare_adjustment_request_id`) REFERENCES `order_fare_adjustment_request` (`id`),
  CONSTRAINT `fk_shipment_order__final_to_office_id` FOREIGN KEY (`final_to_office_id`) REFERENCES `office` (`id`),
  CONSTRAINT `fk_shipment_order__from_office_id` FOREIGN KEY (`from_office_id`) REFERENCES `office` (`id`),
  CONSTRAINT `fk_shipment_order__hub_office_id` FOREIGN KEY (`hub_office_id`) REFERENCES `office` (`id`),
  CONSTRAINT `fk_shipment_order__issue_id` FOREIGN KEY (`issue_id`) REFERENCES `order_issue` (`id`),
  CONSTRAINT `fk_shipment_order__return_request_id` FOREIGN KEY (`return_request_id`) REFERENCES `order_return_request` (`id`),
  CONSTRAINT `fk_shipment_order__sender_customer_id` FOREIGN KEY (`sender_customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `fk_shipment_order__to_office_id` FOREIGN KEY (`to_office_id`) REFERENCES `office` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1679 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipment_order`
--

LOCK TABLES `shipment_order` WRITE;
/*!40000 ALTER TABLE `shipment_order` DISABLE KEYS */;
INSERT INTO `shipment_order` VALUES (1500,'N-GP-6346','N-GP-6346','DRAFT',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Sender Test','0901234567','Receiver Test','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,2.00,1,NULL,40000.00,0.00,0.00,NULL,0.00,NULL,'smoke',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1501,'N-GP-3293','N-GP-3293','DRAFT',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Sender','0901234567','Receiver','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,2.00,1,NULL,40000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1502,'N-GP-9618','N-GP-9618','DRAFT',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Sender','0901234567','Receiver','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,2.00,1,NULL,40000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1503,'XE26GP000001',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','S','0901234567','R','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,3.00,1,NULL,45000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1504,'XE26GP000002',NULL,'IN_TRANSIT',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','S','0901234567','R','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,5.00,1,NULL,55000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,1500),(1505,'XE26GP000003',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','S','0901234567','R','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,4.00,1,NULL,50000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1506,'XE26GP000004',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','S','0901234567','R','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,4.00,1,NULL,50000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,1500),(1507,'XE26GP000005',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','S','0901234567','R','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,2.00,1,NULL,40000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,1500),(1508,'XE26GP000006',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','S','0901234567','R','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,3.00,1,NULL,45000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1509,'XE26GP000007',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','S','0901234567','R','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,2.00,1,NULL,40000.00,0.00,0.00,NULL,40000.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,1500,NULL,NULL,NULL,5,8,NULL,8,NULL),(1510,'N-GP-3730','N-GP-3730','DRAFT',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','E2E Sender','0901234567','E2E Receiver','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,2.00,1,NULL,40000.00,0.00,0.00,NULL,0.00,NULL,'e2e-draft',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1511,'XE26GP000008',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','E2E Sender','0901234567','E2E Receiver','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,3.50,2,NULL,47500.00,0.00,0.00,NULL,0.00,NULL,'e2e-confirmed',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1512,'XE26GP000009',NULL,'RETURNING',NULL,'RT_WH_IN','GUI_TRA','THUONG','COUNTER_TO_COUNTER','E2E2','0901234567','Recv2','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,'Recv2 Actual','0912345678',2.00,1,NULL,40000.00,0.00,0.00,NULL,10000.00,3,'e2e-trip',NULL,NULL,0,0,NULL,NULL,1,NULL,1500,NULL,NULL,5,8,NULL,8,1501),(1513,'XE26GP000010',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','E2E3','0901234567','Recv3','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,35000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,1501,NULL,NULL,NULL,5,8,NULL,8,NULL),(1514,'XE26GP000011',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','E2E4','0901234567','Recv4','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,35000.00,0.00,0.00,NULL,35000.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1515,'N-GP-3971','N-GP-3971','DRAFT',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','E2E Sender','0901234567','E2E Receiver','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,2.00,1,NULL,40000.00,0.00,0.00,NULL,0.00,NULL,'e2e-draft',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1516,'XE26GP000012',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','E2E Sender','0901234567','E2E Receiver','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,3.50,2,NULL,47500.00,0.00,0.00,NULL,0.00,NULL,'e2e-confirmed',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1517,'XE26GP000013',NULL,'RETURNING',NULL,'RT_WH_IN','GUI_TRA','THUONG','COUNTER_TO_COUNTER','E2E2','0901234567','Recv2','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,'Recv2 Actual','0912345678',2.00,1,NULL,40000.00,0.00,0.00,NULL,10000.00,3,'e2e-trip',NULL,NULL,0,0,NULL,NULL,1,NULL,1501,NULL,NULL,5,8,NULL,8,1502),(1518,'XE26GP000014',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','E2E3','0901234567','Recv3','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,35000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,1502,NULL,NULL,NULL,5,8,NULL,8,NULL),(1519,'XE26GP000015',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','E2E4','0901234567','Recv4','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,35000.00,0.00,0.00,NULL,35000.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1520,'XE26GP000016',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Ix','0901234567','Ir','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,35000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,1503,NULL,NULL,NULL,5,8,NULL,8,NULL),(1521,'XE26GP000017',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','I','0901234567','R','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,35000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,1504,NULL,NULL,NULL,5,8,NULL,8,NULL),(1522,'XE26GP000018',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','I','0901234567','R','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,35000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,1505,NULL,NULL,NULL,5,8,NULL,8,NULL),(1523,'N-GP-7843','N-GP-7843','DRAFT',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','E2E Sender','0901234567','E2E Receiver','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,2.00,1,NULL,40000.00,0.00,0.00,NULL,0.00,NULL,'e2e-draft',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1524,'XE26GP000019',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','E2E Sender','0901234567','E2E Receiver','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,3.50,2,NULL,47500.00,0.00,0.00,NULL,0.00,NULL,'e2e-confirmed',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1525,'XE26GP000020',NULL,'RETURNING',NULL,'RT_WH_IN','GUI_TRA','THUONG','COUNTER_TO_COUNTER','E2E2','0901234567','Recv2','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,'Recv2 Actual','0912345678',2.00,1,NULL,40000.00,0.00,0.00,NULL,10000.00,3,'e2e-trip',NULL,NULL,0,0,NULL,NULL,1,NULL,1502,NULL,NULL,5,8,NULL,8,1503),(1526,'XE26GP000021',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','E2E3','0901234567','Recv3','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,35000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,1506,NULL,NULL,NULL,5,8,NULL,8,NULL),(1527,'XE26GP000022',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','E2E4','0901234567','Recv4','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,35000.00,0.00,0.00,NULL,35000.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1528,'XE26BC000001',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','SmokeFE','0901234567','RecvSmoke','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,35000.00,0.00,0.00,NULL,0.00,NULL,'',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,7,5,5,5,NULL),(1529,'N-GP-8213','N-GP-8213','DRAFT',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','E2E Sender','0901234567','E2E Receiver','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,2.00,1,NULL,40000.00,0.00,0.00,NULL,0.00,NULL,'e2e-draft',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1530,'XE26GP000023',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','E2E Sender','0901234567','E2E Receiver','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,3.50,2,NULL,47500.00,0.00,0.00,NULL,0.00,NULL,'e2e-confirmed',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1531,'XE26GP000024',NULL,'RETURNING',NULL,'RT_WH_IN','GUI_TRA','THUONG','COUNTER_TO_COUNTER','E2E2','0901234567','Recv2','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,'Recv2 Actual','0912345678',2.00,1,NULL,40000.00,0.00,0.00,NULL,10000.00,3,'e2e-trip',NULL,NULL,0,0,NULL,NULL,1,NULL,1503,NULL,NULL,5,8,NULL,8,1504),(1532,'XE26GP000025',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','E2E3','0901234567','Recv3','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,35000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,1507,NULL,NULL,NULL,5,8,NULL,8,NULL),(1533,'XE26GP000026',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','E2E4','0901234567','Recv4','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,35000.00,0.00,0.00,NULL,35000.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1534,'XE26ND000001',NULL,'AT_DEST',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Patched Sender','0901234567','Nguoi Nhan','0912345678',NULL,NULL,0,0,0,'quay.hn','2026-08-12 03:00:00.000000','2026-08-12 02:35:34.624628',NULL,NULL,2.00,1,NULL,40000.00,0.00,0.00,NULL,0.00,NULL,'patched-note',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,5,8,NULL),(1535,'XE26GP000027',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','HOME_TO_COUNTER','Renamed','0902111001','PatchDst','0912111001',NULL,'52 Nguyen Trai',1,0,0,NULL,NULL,NULL,NULL,NULL,3.00,2,NULL,50000.00,10000.00,0.00,NULL,0.00,NULL,'status-probe',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1536,'XE26GP000028',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','FareSrc','0902111002','FareDst','0912111002',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,10000.00,0.00,0.00,NULL,30000.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1537,'XE26ND000002',NULL,'AT_DEST',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','LegSrc','0902111003','LegDst','0912111003',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,2.00,1,NULL,35000.00,0.00,0.00,NULL,0.00,NULL,'leg-safe',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,5,8,NULL),(1538,'XE26GP000029',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Single','0902111004','SingleD','0912111004',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,20000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1539,'XE26GP000030',NULL,'DELIVERED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','PodSrc','0902111005','PodDst','0912111005',NULL,NULL,0,0,0,NULL,NULL,NULL,'Pod Actual',NULL,1.00,1,NULL,50000.00,0.00,0.00,NULL,50000.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1540,'XE26GP000031',NULL,'DELIVERED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','USrc','0902111006','UDst','0912111006',NULL,NULL,0,0,0,NULL,NULL,NULL,'UDst',NULL,1.00,1,NULL,40000.00,0.00,0.00,NULL,40000.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1541,'XE26GP000032',NULL,'AT_DEST',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','TSrc','0902111008','TDst','0912111008',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,10000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1542,'XE26GP000033',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','IssSrc','0902111007','IssDst','0912111007',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,15000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,1509,NULL,NULL,NULL,5,8,NULL,8,NULL),(1543,'XE26GP000034',NULL,'DELIVERED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','DaySrc','0902111009','DayDst','0912111009',NULL,NULL,0,0,0,NULL,NULL,NULL,'DayDst',NULL,1.00,1,NULL,25000.00,0.00,0.00,NULL,0.00,NULL,'after-close',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1544,'XE26GP000035',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','A','0903111001','B','0913111001',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,10000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1545,'XE26GP000036',NULL,'IN_TRANSIT',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','A','0903111002','B','0913111002',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,10000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1546,'XE26ND000003',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','A','0903111003','B','0913111003',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,10000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,5,8,NULL),(1547,'XE26GP000037',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','A','0903111001','B','0913111001',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,10000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1548,'XE26GP000038',NULL,'IN_TRANSIT',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','A','0903111002','B','0913111002',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,10000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1549,'XE26ND000004',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','A','0903111003','B','0913111003',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,10000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,5,8,NULL),(1550,'XE26GP000039',NULL,'DELIVERED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','A','0903111099','B','0913111099',NULL,NULL,0,0,0,NULL,NULL,NULL,'B',NULL,1.00,1,NULL,10000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1551,'XE26GP000040',NULL,'IN_TRANSIT',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','OpenSrc','0904111001','OpenDst','0914111001',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,30000.00,0.00,0.00,NULL,5000.00,NULL,'patched-open',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1552,'XE26ND000005',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Leg','0904111002','LegD','0914111002',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,20000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,5,8,NULL),(1553,'XE26GP000041',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Ov','0904111003','OvD','0914111003',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,10000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1554,'XE26GP000042',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','ClosedSrc','0904111004','ClosedDst','0914111004',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,25000.00,0.00,0.00,NULL,0.00,NULL,'after-reopen',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1555,'XE26GP000043',NULL,'IN_TRANSIT',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','OpenSrc','0904111001','OpenDst','0914111001',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,30000.00,0.00,0.00,NULL,5000.00,NULL,'patched-open',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1556,'XE26ND000006',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Leg','0904111002','LegD','0914111002',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,20000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,5,8,NULL),(1557,'XE26GP000044',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Ov','0904111003','OvD','0914111003',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,10000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1558,'XE26GP000045',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','ClosedSrc','0904111004','ClosedDst','0914111004',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,25000.00,0.00,0.00,NULL,0.00,NULL,'after-reopen',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1559,'XE26GP000046',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Iss','0905111001','IssD','0915111001',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,12000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,1512,NULL,NULL,NULL,5,8,NULL,8,NULL),(1560,'XE26GP000047',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','D','0905111002','E','0915111002',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,15000.00,0.00,0.00,NULL,0.00,NULL,'pre-close',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1561,'XE26ND000007',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','L','0905111003','M','0915111003',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,10000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,5,8,NULL),(1562,'XE26GP000048',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','H1 Renamed','0901234567','H1 Recv','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,50000.00,0.00,0.00,NULL,30000.00,NULL,'h1-only-note',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1563,'XE26GP000049',NULL,'IN_TRANSIT',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','OpenSrc','0904111001','OpenDst','0914111001',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,30000.00,0.00,0.00,NULL,5000.00,NULL,'patched-open',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1564,'XE26GP000050',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Iss','0905111001','IssD','0915111001',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,12000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,1513,NULL,NULL,NULL,5,8,NULL,8,NULL),(1565,'XE26ND000008',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Leg','0904111002','LegD','0914111002',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,20000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,5,8,NULL),(1566,'XE26GP000051',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Ov','0904111003','OvD','0914111003',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,10000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1567,'XE26GP000052',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','ClosedSrc','0904111004','ClosedDst','0914111004',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,25000.00,0.00,0.00,NULL,0.00,NULL,'after-reopen',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1568,'XE26GP000053',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','D','0905111002','E','0915111002',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,15000.00,0.00,0.00,NULL,0.00,NULL,'pre-close',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1569,'XE26ND000009',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','L','0905111003','M','0915111003',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,10000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,5,8,NULL),(1570,'XE26GP000054',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Iss','0905111001','IssD','0915111001',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,12000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,1516,NULL,NULL,NULL,5,8,NULL,8,NULL),(1571,'XE26GP000055',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','D','0905111002','E','0915111002',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,15000.00,0.00,0.00,NULL,0.00,NULL,'pre-close',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1572,'XE26ND000010',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','L','0905111003','M','0915111003',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,10000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,5,8,NULL),(1573,'XE26GP000056',NULL,'DELIVERED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','M1S','0901234567','M1R','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,'Recv',NULL,1.00,1,NULL,40000.00,0.00,0.00,NULL,40000.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1574,'XE26GP000057',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','M1S2','0901234567','M1R2','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,40000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1575,'XE26GP000058',NULL,'DELIVERED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','M1S3','0901234567','M1R3','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,'Z',NULL,1.00,1,NULL,40000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1576,'XE26GP000059',NULL,'IN_TRANSIT',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','OpenSrc','0904111001','OpenDst','0914111001',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,30000.00,0.00,0.00,NULL,5000.00,NULL,'patched-open',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1577,'XE26ND000011',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Leg','0904111002','LegD','0914111002',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,20000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,5,8,NULL),(1578,'XE26GP000060',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Ov','0904111003','OvD','0914111003',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,10000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1579,'XE26GP000061',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','ClosedSrc','0904111004','ClosedDst','0914111004',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,25000.00,0.00,0.00,NULL,0.00,NULL,'after-reopen',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1580,'XE26GP000062',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','H1 Renamed','0901234567','H1 Recv','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,50000.00,0.00,0.00,NULL,30000.00,NULL,'h1-only-note',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1581,'XE26GP000063',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Iss','0905111001','IssD','0915111001',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,12000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,1519,NULL,NULL,NULL,5,8,NULL,8,NULL),(1582,'XE26GP000064',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','D','0905111002','E','0915111002',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,15000.00,0.00,0.00,NULL,0.00,NULL,'pre-close',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1583,'XE26ND000012',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','L','0905111003','M','0915111003',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,10000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,5,8,NULL),(1584,'XE26GP000065',NULL,'IN_TRANSIT',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','OpenSrc','0904111001','OpenDst','0914111001',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,30000.00,0.00,0.00,NULL,5000.00,NULL,'patched-open',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1585,'XE26ND000013',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Leg','0904111002','LegD','0914111002',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,20000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,5,8,NULL),(1586,'XE26GP000066',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Ov','0904111003','OvD','0914111003',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,10000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1587,'XE26GP000067',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','ClosedSrc','0904111004','ClosedDst','0914111004',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,25000.00,0.00,0.00,NULL,0.00,NULL,'after-reopen',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1588,'XE26GP000068',NULL,'DELIVERED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','M2S','0901234567','M2R','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,'M2',NULL,1.00,1,NULL,50000.00,0.00,0.00,NULL,0.00,NULL,'origin-open-dest-closed',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1589,'XE26GP000069',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','H1 Renamed','0901234567','H1 Recv','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,50000.00,0.00,0.00,NULL,30000.00,NULL,'h1-only-note',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1590,'XE26GP000070',NULL,'DELIVERED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','M1S','0901234567','M1R','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,'Recv',NULL,1.00,1,NULL,40000.00,0.00,0.00,NULL,40000.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1591,'XE26GP000071',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','M1S2','0901234567','M1R2','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,40000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1592,'XE26GP000072',NULL,'DELIVERED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','M1S3','0901234567','M1R3','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,'Z',NULL,1.00,1,NULL,40000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1593,'XE26GP000073',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Iss','0905111001','IssD','0915111001',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,12000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,1522,NULL,NULL,NULL,5,8,NULL,8,NULL),(1594,'XE26GP000074',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','D','0905111002','E','0915111002',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,15000.00,0.00,0.00,NULL,0.00,NULL,'pre-close',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1595,'XE26ND000014',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','L','0905111003','M','0915111003',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,10000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,5,8,NULL),(1596,'XE26GP000075',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','P4','0901234567','R4','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,35000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1597,'XE26GP000076',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','P4b','0901234567','R4b','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,15000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1598,'XE26GP000077',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_HOME','P4c','0901234567','R4c','0912345678','1 Street',NULL,0,1,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,36000.00,0.00,21000.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,8,8,NULL),(1599,'XE26GP000078',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','P4d','0901234567','R4d','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,15000.00,0.00,0.00,NULL,10000.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1600,'XE26GP000079',NULL,'IN_TRANSIT',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','OpenSrc','0904111001','OpenDst','0914111001',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,30000.00,0.00,0.00,NULL,5000.00,NULL,'patched-open',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1601,'XE26ND000015',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Leg','0904111002','LegD','0914111002',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,20000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,5,8,NULL),(1602,'XE26GP000080',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Ov','0904111003','OvD','0914111003',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,10000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1603,'XE26GP000081',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','ClosedSrc','0904111004','ClosedDst','0914111004',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,25000.00,0.00,0.00,NULL,0.00,NULL,'after-reopen',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1604,'XE26GP000082',NULL,'DELIVERED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','M2S','0901234567','M2R','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,'M2',NULL,1.00,1,NULL,50000.00,0.00,0.00,NULL,0.00,NULL,'origin-open-dest-closed',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1605,'XE26GP000083',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','H1 Renamed','0901234567','H1 Recv','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,50000.00,0.00,0.00,NULL,30000.00,NULL,'h1-only-note',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1606,'XE26GP000084',NULL,'RETURNING',NULL,'RETURN_PENDING','GUI_TRA','THUONG','COUNTER_TO_COUNTER','R8','0901234567','R8r','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,'X',NULL,1.00,1,NULL,40000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,1505,NULL,NULL,5,8,NULL,8,NULL),(1607,'XE26GP000085',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','C3','0901234567','C3r','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,20000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,1523,NULL,NULL,NULL,5,8,NULL,8,NULL),(1608,'XE26GP000086',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','X','0901234567','Y','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,20000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,1524,NULL,NULL,NULL,5,8,NULL,8,NULL),(1609,'XE26GP000087',NULL,'RETURNING',NULL,'RETURN_PENDING','GUI_TRA','THUONG','COUNTER_TO_COUNTER','R8','0901234567','R8r','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,'X',NULL,1.00,1,NULL,40000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,1507,NULL,NULL,5,8,NULL,8,NULL),(1610,'XE26GP000088',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','C3','0901234567','C3r','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,20000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,1526,NULL,NULL,NULL,5,8,NULL,8,NULL),(1611,'XE26GP000089',NULL,'IN_TRANSIT',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','OpenSrc','0904111001','OpenDst','0914111001',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,30000.00,0.00,0.00,NULL,5000.00,NULL,'patched-open',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1612,'XE26ND000016',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Leg','0904111002','LegD','0914111002',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,20000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,5,8,NULL),(1613,'XE26GP000090',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Ov','0904111003','OvD','0914111003',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,10000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1614,'XE26GP000091',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','ClosedSrc','0904111004','ClosedDst','0914111004',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,25000.00,0.00,0.00,NULL,0.00,NULL,'after-reopen',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1615,'XE26GP000092',NULL,'DELIVERED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','M2S','0901234567','M2R','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,'M2',NULL,1.00,1,NULL,50000.00,0.00,0.00,NULL,0.00,NULL,'origin-open-dest-closed',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1616,'XE26GP000093',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Iss','0905111001','IssD','0915111001',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,12000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,1529,NULL,NULL,NULL,5,8,NULL,8,NULL),(1617,'XE26GP000094',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','D','0905111002','E','0915111002',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,15000.00,0.00,0.00,NULL,0.00,NULL,'pre-close',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1618,'XE26ND000017',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','L','0905111003','M','0915111003',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,10000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,5,8,NULL),(1619,'XE26GP000095',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','H1 Renamed','0901234567','H1 Recv','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,50000.00,0.00,0.00,NULL,30000.00,NULL,'h1-only-note',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1620,'N-GP-4971','N-GP-4971','CANCELLED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER',NULL,'0901234567','D9','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,15000.00,0.00,0.00,NULL,0.00,NULL,NULL,'Hết hạn 24h (hệ thống)',NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1621,'XE26GP000096',NULL,'AT_DEST',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','F9','0901234567','F9r','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,30000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,3,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1622,'N-GP-5072','N-GP-5072','CANCELLED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER',NULL,'0901234567','D9','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,15000.00,0.00,0.00,NULL,0.00,NULL,NULL,'Hết hạn 24h (hệ thống)',NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1623,'XE26GP000097',NULL,'AT_DEST',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','F9','0901234567','F9r','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,30000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,3,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1624,'N-GP-6400','N-GP-6400','CANCELLED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER',NULL,'0901234567','D9','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,15000.00,0.00,0.00,NULL,0.00,NULL,NULL,'Hết hạn 24h (hệ thống)',NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1625,'XE26GP000098',NULL,'AT_DEST',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','F9','0901234567','F9r','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,30000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,3,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1626,'XE26GP000099',NULL,'IN_TRANSIT',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','OpenSrc','0904111001','OpenDst','0914111001',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,30000.00,0.00,0.00,NULL,5000.00,NULL,'patched-open',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1627,'XE26ND000018',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Leg','0904111002','LegD','0914111002',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,20000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,5,8,NULL),(1628,'XE26GP000100',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Ov','0904111003','OvD','0914111003',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,10000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1629,'XE26GP000101',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','ClosedSrc','0904111004','ClosedDst','0914111004',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,25000.00,0.00,0.00,NULL,0.00,NULL,'after-reopen',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1630,'XE26GP000102',NULL,'DELIVERED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','M2S','0901234567','M2R','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,'M2',NULL,1.00,1,NULL,50000.00,0.00,0.00,NULL,0.00,NULL,'origin-open-dest-closed',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1631,'XE26GP000103',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','H1 Renamed','0901234567','H1 Recv','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,50000.00,0.00,0.00,NULL,30000.00,NULL,'h1-only-note',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1632,'XE26GP000104',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Iss','0905111001','IssD','0915111001',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,12000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,1532,NULL,NULL,NULL,5,8,NULL,8,NULL),(1633,'XE26GP000105',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','D','0905111002','E','0915111002',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,15000.00,0.00,0.00,NULL,0.00,NULL,'pre-close',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1634,'XE26ND000019',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','L','0905111003','M','0915111003',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,10000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,5,8,NULL),(1635,'XE26GP000106',NULL,'DELIVERED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','M1S','0901234567','M1R','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,'Recv',NULL,1.00,1,NULL,40000.00,0.00,0.00,NULL,40000.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1636,'XE26GP000107',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','M1S2','0901234567','M1R2','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,40000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1637,'XE26GP000108',NULL,'DELIVERED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','M1S3','0901234567','M1R3','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,'Z',NULL,1.00,1,NULL,40000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1638,'XE26GP000109',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','H1 Renamed','0901234567','H1 Recv','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,50000.00,0.00,0.00,NULL,30000.00,NULL,'h1-only-note',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1639,'XE26GP000110',NULL,'DELIVERED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','M1S','0901234567','M1R','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,'Recv',NULL,1.00,1,NULL,40000.00,0.00,0.00,NULL,40000.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1640,'XE26GP000111',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','M1S2','0901234567','M1R2','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,40000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1641,'XE26GP000112',NULL,'DELIVERED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','M1S3','0901234567','M1R3','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,'Z',NULL,1.00,1,NULL,40000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1642,'XE26GP000113',NULL,'IN_TRANSIT',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','OpenSrc','0904111001','OpenDst','0914111001',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,30000.00,0.00,0.00,NULL,5000.00,NULL,'patched-open',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1643,'XE26ND000020',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Leg','0904111002','LegD','0914111002',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,20000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,5,8,NULL),(1644,'XE26GP000114',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Ov','0904111003','OvD','0914111003',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,10000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1645,'XE26GP000115',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','ClosedSrc','0904111004','ClosedDst','0914111004',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,25000.00,0.00,0.00,NULL,0.00,NULL,'after-reopen',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1646,'XE26GP000116',NULL,'DELIVERED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','M2S','0901234567','M2R','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,'M2',NULL,1.00,1,NULL,50000.00,0.00,0.00,NULL,0.00,NULL,'origin-open-dest-closed',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1647,'XE26GP000117',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Iss','0905111001','IssD','0915111001',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,12000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,1535,NULL,NULL,NULL,5,8,NULL,8,NULL),(1648,'XE26GP000118',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','D','0905111002','E','0915111002',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,15000.00,0.00,0.00,NULL,0.00,NULL,'pre-close',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1649,'XE26ND000021',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','L','0905111003','M','0915111003',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,10000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,5,8,NULL),(1650,'XE26GP000119',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','P4','0901234567','R4','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,15000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1651,'XE26GP000120',NULL,'RETURNING',NULL,'RT_TRANSFER_PENDING','GUI_TRA','THUONG','COUNTER_TO_COUNTER','R8','0901234567','R8r','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,'X',NULL,1.00,1,NULL,40000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,1509,NULL,NULL,5,8,NULL,8,NULL),(1652,'XE26GP000121',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','C3','0901234567','C3r','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,20000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,1537,NULL,NULL,NULL,5,8,NULL,8,NULL),(1653,'N-GP-4047','N-GP-4047','CANCELLED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER',NULL,'0901234567','D9','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,15000.00,0.00,0.00,NULL,0.00,NULL,NULL,'Hết hạn 24h (hệ thống)',NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1654,'XE26GP000122',NULL,'AT_DEST',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','F9','0901234567','F9r','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,30000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,3,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1655,'XE26GP000123',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','P4','0901234567','R4','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,15000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1656,'XE26GP000124',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','P4b','0901234567','R4b','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,15000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1657,'XE26GP000125',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_HOME','P4c','0901234567','R4c','0912345678','1 Street',NULL,0,1,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,36000.00,0.00,21000.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,8,8,NULL),(1658,'XE26GP000126',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','P4d','0901234567','R4d','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,15000.00,0.00,0.00,NULL,10000.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1659,'XE26GP000127',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','H1 Renamed','0901234567','H1 Recv','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,50000.00,0.00,0.00,NULL,30000.00,NULL,'h1-only-note',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1660,'XE26GP000128',NULL,'DELIVERED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','M1S','0901234567','M1R','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,'Recv',NULL,1.00,1,NULL,40000.00,0.00,0.00,NULL,40000.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1661,'XE26GP000129',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','M1S2','0901234567','M1R2','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,40000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1662,'XE26GP000130',NULL,'DELIVERED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','M1S3','0901234567','M1R3','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,'Z',NULL,1.00,1,NULL,40000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1663,'XE26GP000131',NULL,'IN_TRANSIT',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','OpenSrc','0904111001','OpenDst','0914111001',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,30000.00,0.00,0.00,NULL,5000.00,NULL,'patched-open',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1664,'XE26ND000022',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Leg','0904111002','LegD','0914111002',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,20000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,5,8,NULL),(1665,'XE26GP000132',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Ov','0904111003','OvD','0914111003',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,10000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1666,'XE26GP000133',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','ClosedSrc','0904111004','ClosedDst','0914111004',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,25000.00,0.00,0.00,NULL,0.00,NULL,'after-reopen',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1667,'XE26GP000134',NULL,'DELIVERED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','M2S','0901234567','M2R','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,'M2',NULL,1.00,1,NULL,50000.00,0.00,0.00,NULL,0.00,NULL,'origin-open-dest-closed',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1668,'XE26GP000135',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','Iss','0905111001','IssD','0915111001',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,12000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,1540,NULL,NULL,NULL,5,8,NULL,8,NULL),(1669,'XE26GP000136',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','D','0905111002','E','0915111002',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,15000.00,0.00,0.00,NULL,0.00,NULL,'pre-close',NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1670,'XE26ND000023',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','L','0905111003','M','0915111003',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,10000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,5,8,NULL),(1671,'XE26GP000137',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','P4','0901234567','R4','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,15000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1672,'XE26GP000138',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','P4b','0901234567','R4b','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,15000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1673,'XE26GP000139',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_HOME','P4c','0901234567','R4c','0912345678','1 Street',NULL,0,1,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,36000.00,0.00,21000.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,8,8,NULL),(1674,'XE26GP000140',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','P4d','0901234567','R4d','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,15000.00,0.00,0.00,NULL,10000.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1675,'XE26GP000141',NULL,'RETURNED',NULL,'RT_DONE','GUI_TRA','THUONG','COUNTER_TO_COUNTER','R8','0901234567','R8r','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,'X',NULL,1.00,1,NULL,40000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,NULL,1511,NULL,NULL,5,8,NULL,8,NULL),(1676,'XE26GP000142',NULL,'CONFIRMED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','C3','0901234567','C3r','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,20000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,0,NULL,NULL,1,1542,NULL,NULL,NULL,5,8,NULL,8,NULL),(1677,'N-GP-5593','N-GP-5593','CANCELLED',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER',NULL,'0901234567','D9','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,15000.00,0.00,0.00,NULL,0.00,NULL,NULL,'Hết hạn 24h (hệ thống)',NULL,0,0,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL),(1678,'XE26GP000143',NULL,'AT_DEST',NULL,NULL,'GUI_TRA','THUONG','COUNTER_TO_COUNTER','F9','0901234567','F9r','0912345678',NULL,NULL,0,0,0,NULL,NULL,NULL,NULL,NULL,1.00,1,NULL,30000.00,0.00,0.00,NULL,0.00,NULL,NULL,NULL,NULL,0,3,NULL,NULL,1,NULL,NULL,NULL,NULL,5,8,NULL,8,NULL);
/*!40000 ALTER TABLE `shipment_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_profile`
--

DROP TABLE IF EXISTS `staff_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff_profile` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `staff_code` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_login` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `scope_all_offices` tinyint NOT NULL,
  `active` tinyint NOT NULL,
  `office_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_staff_profile__user_login` (`user_login`),
  UNIQUE KEY `ux_staff_profile__staff_code` (`staff_code`),
  KEY `fk_staff_profile__office_id` (`office_id`),
  CONSTRAINT `fk_staff_profile__office_id` FOREIGN KEY (`office_id`) REFERENCES `office` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1512 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_profile`
--

LOCK TABLES `staff_profile` WRITE;
/*!40000 ALTER TABLE `staff_profile` DISABLE KEYS */;
INSERT INTO `staff_profile` VALUES (1500,'STF-AD-ADMIN','admin','Administrator','AD',1,1,5),(1501,'STF-Q-QUAY-HN','quay.hn','Quầy HN','Q',0,1,5),(1502,'STF-Q-QUAY-HCM','quay.hcm','Quầy NB','Q',0,1,8),(1503,'STF-BX-BX-HN','bx.hn','Bốc xếp HN','BX',0,1,5),(1504,'STF-G-GIAO-HN-01','giao.hn.01','Giao HN 01','G',0,1,5),(1505,'STF-KT-KT-HN','kt.hn','Kế toán HN','KT',0,1,5),(1506,'STF-TCN-TCN-HN','tcn.hn','Trưởng CN HN','TCN',0,1,5),(1507,'STF-DH-DH','dh','Điều hành','DH',1,1,5),(1508,'STF-BL-BL','bl','Ban lãnh đạo','BL',1,1,5),(1509,'T005_988D69F0','t005_988d69f0','t005_988d69f0','Q',0,0,5),(1510,'T005_09C9E3E1','t005_09c9e3e1','t005_09c9e3e1','Q',0,0,5),(1511,'T005_42377D6D','t005_42377d6d','t005_42377d6d','Q',0,0,5);
/*!40000 ALTER TABLE `staff_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `surcharge_policy`
--

DROP TABLE IF EXISTS `surcharge_policy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `surcharge_policy` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `home_delivery_enabled` tinyint NOT NULL,
  `default_home_delivery_amount` decimal(21,2) NOT NULL,
  `cod_enabled` tinyint NOT NULL,
  `cod_percent` decimal(21,2) NOT NULL,
  `cod_min_fee` decimal(21,2) NOT NULL,
  `storage_enabled` tinyint NOT NULL,
  `storage_free_days` int NOT NULL,
  `storage_fee_per_day` decimal(21,2) NOT NULL,
  `insurance_enabled` tinyint NOT NULL,
  `insurance_threshold` decimal(21,2) NOT NULL,
  `insurance_percent_under` decimal(21,2) NOT NULL,
  `insurance_percent_over` decimal(21,2) NOT NULL,
  `refund_enabled` tinyint NOT NULL,
  `refund_percent` decimal(21,2) NOT NULL,
  `updated_at` datetime(6),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1501 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `surcharge_policy`
--

LOCK TABLES `surcharge_policy` WRITE;
/*!40000 ALTER TABLE `surcharge_policy` DISABLE KEYS */;
INSERT INTO `surcharge_policy` VALUES (1500,1,21000.00,0,1.00,10000.00,1,3,10000.00,1,10000000.00,1.50,1.00,0,50.00,'2026-08-12 02:21:02.829368');
/*!40000 ALTER TABLE `surcharge_policy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trip`
--

DROP TABLE IF EXISTS `trip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trip` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `trip_code` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `depart_at` datetime(6) NOT NULL,
  `loaded_count` int DEFAULT NULL,
  `scanned_count` int DEFAULT NULL,
  `closed_at` datetime(6),
  `force_closed` tinyint NOT NULL,
  `force_close_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `office_id` bigint NOT NULL,
  `route_id` bigint NOT NULL,
  `vehicle_id` bigint NOT NULL,
  `driver_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_trip__trip_code` (`trip_code`),
  KEY `fk_trip__office_id` (`office_id`),
  KEY `fk_trip__route_id` (`route_id`),
  KEY `fk_trip__vehicle_id` (`vehicle_id`),
  KEY `fk_trip__driver_id` (`driver_id`),
  CONSTRAINT `fk_trip__driver_id` FOREIGN KEY (`driver_id`) REFERENCES `driver` (`id`),
  CONSTRAINT `fk_trip__office_id` FOREIGN KEY (`office_id`) REFERENCES `office` (`id`),
  CONSTRAINT `fk_trip__route_id` FOREIGN KEY (`route_id`) REFERENCES `route` (`id`),
  CONSTRAINT `fk_trip__vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1505 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trip`
--

LOCK TABLES `trip` WRITE;
/*!40000 ALTER TABLE `trip` DISABLE KEYS */;
INSERT INTO `trip` VALUES (1500,'TGP260811-01','LOADING','2026-08-12 10:00:00.000000',1,1,NULL,0,NULL,5,1,1,1),(1501,'TGP260812-01','UNLOADING','2026-08-13 08:00:00.000000',1,1,NULL,0,NULL,5,1,1,1),(1502,'TGP260812-02','UNLOADING','2026-08-13 08:00:00.000000',1,1,NULL,0,NULL,5,1,1,1),(1503,'TGP260812-03','UNLOADING','2026-08-13 08:00:00.000000',1,1,NULL,0,NULL,5,1,1,1),(1504,'TGP260812-04','UNLOADING','2026-08-13 08:00:00.000000',1,1,NULL,0,NULL,5,1,1,1);
/*!40000 ALTER TABLE `trip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trip_order_assignment`
--

DROP TABLE IF EXISTS `trip_order_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trip_order_assignment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `assignment_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `scanned_at` datetime(6),
  `loaded_at` datetime(6),
  `removed_at` datetime(6),
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trip_id` bigint NOT NULL,
  `order_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_trip_order_assignment__trip_id` (`trip_id`),
  KEY `fk_trip_order_assignment__order_id` (`order_id`),
  CONSTRAINT `fk_trip_order_assignment__order_id` FOREIGN KEY (`order_id`) REFERENCES `shipment_order` (`id`),
  CONSTRAINT `fk_trip_order_assignment__trip_id` FOREIGN KEY (`trip_id`) REFERENCES `trip` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1507 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trip_order_assignment`
--

LOCK TABLES `trip_order_assignment` WRITE;
/*!40000 ALTER TABLE `trip_order_assignment` DISABLE KEYS */;
INSERT INTO `trip_order_assignment` VALUES (1500,'LOADED','2026-08-11 16:56:10.741736','2026-08-11 16:56:10.741736',NULL,NULL,1500,1504),(1501,'SCANNED',NULL,NULL,NULL,NULL,1500,1506),(1502,'SCANNED',NULL,NULL,NULL,NULL,1500,1507),(1503,'LOADED','2026-08-11 17:16:37.555652','2026-08-11 17:16:37.555652',NULL,NULL,1501,1512),(1504,'LOADED','2026-08-11 17:21:52.483404','2026-08-11 17:21:52.483404',NULL,NULL,1502,1517),(1505,'LOADED','2026-08-11 17:28:23.369152','2026-08-11 17:28:23.369152',NULL,NULL,1503,1525),(1506,'LOADED','2026-08-12 02:21:01.123481','2026-08-12 02:21:01.123481',NULL,NULL,1504,1531);
/*!40000 ALTER TABLE `trip_order_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicle` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `plate_number` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `capacity_kg` decimal(21,2) NOT NULL,
  `active` tinyint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_vehicle__plate_number` (`plate_number`)
) ENGINE=InnoDB AUTO_INCREMENT=1500 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle`
--

LOCK TABLES `vehicle` WRITE;
/*!40000 ALTER TABLE `vehicle` DISABLE KEYS */;
INSERT INTO `vehicle` VALUES (1,'29H-123.45',3500.00,1),(2,'51C-678.90',5000.00,1),(3,'43A-111.22',2500.00,1),(4,'30F-456.78',4000.00,1),(5,'51G-234.56',6000.00,1),(6,'43B-987.65',3000.00,1),(7,'15C-321.54',2000.00,1),(8,'65D-159.75',5500.00,1);
/*!40000 ALTER TABLE `vehicle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'cpn'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-12 22:42:29

SET FOREIGN_KEY_CHECKS=1;
SET UNIQUE_CHECKS=1;
