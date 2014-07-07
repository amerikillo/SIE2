/*
Navicat MySQL Data Transfer

Source Server         : Local
Source Server Version : 50610
Source Host           : localhost:3306
Source Database       : gnklmex_consolidada

Target Server Type    : MYSQL
Target Server Version : 50610
File Encoding         : 65001

Date: 2014-06-11 10:25:58
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `tb_compra`
-- ----------------------------
DROP TABLE IF EXISTS `tb_compra`;
CREATE TABLE `tb_compra` (
`F_IdCom`  int(11) NOT NULL AUTO_INCREMENT ,
`F_ClaDoc`  int(11) NOT NULL ,
`F_ProVee`  int(11) NOT NULL ,
`F_StsCom`  varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_FecApl`  date NOT NULL ,
`F_ClaPro`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_CanCom`  int(11) NOT NULL ,
`F_Costo`  double(20,2) NOT NULL ,
`F_ImpTo`  double(20,2) NOT NULL ,
`F_ComTot`  double(20,2) NOT NULL ,
`F_Lote`  int(11) NOT NULL ,
`F_FolRemi`  varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_OrdCom`  varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_User`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
PRIMARY KEY (`F_IdCom`),
FOREIGN KEY (`F_ClaPro`) REFERENCES `tb_medica` (`F_ClaPro`) ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY (`F_Lote`) REFERENCES `tb_lote` (`F_FolLot`) ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY (`F_User`) REFERENCES `tb_usuario` (`F_Usu`) ON DELETE NO ACTION ON UPDATE NO ACTION,
INDEX `FK_Lot` (`F_Lote`) USING BTREE ,
INDEX `FK_Claprod` (`F_ClaPro`) USING BTREE ,
INDEX `tb_compra_ibfk_4` (`F_User`) USING BTREE 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=22

;

-- ----------------------------
-- Records of tb_compra
-- ----------------------------
BEGIN;
INSERT INTO `tb_compra` VALUES ('4', '1', '1', 'A', '2014-06-09', '0101', '0', '58.02', '0.00', '522.18', '1', '', '', 'anibal'), ('5', '2', '1', 'A', '2014-06-09', '0101', '7', '58.02', '0.00', '406.14', '2', '', '', 'anibal'), ('6', '2', '1', 'A', '2014-06-09', '0101', '11', '58.02', '0.00', '638.22', '2', '', '', 'anibal'), ('7', '2', '1', 'A', '2014-06-09', '0101', '43', '58.02', '0.00', '2494.86', '2', '', '', 'anibal'), ('8', '3', '1', 'A', '2014-06-09', '0101', '9', '58.02', '0.00', '522.18', '3', '', '', 'anibal'), ('9', '3', '1', 'A', '2014-06-09', '0101', '22', '58.02', '0.00', '1276.44', '3', '', '', 'anibal'), ('10', '3', '1', 'A', '2014-06-09', '0101', '50', '58.02', '0.00', '2901.00', '3', '', '', 'anibal'), ('11', '4', '1', 'A', '2014-06-09', '0101', '7', '58.02', '0.00', '406.14', '4', '', '', 'anibal'), ('12', '5', '1', 'A', '2014-06-09', '0101', '5', '58.02', '0.00', '290.10', '5', '', '', 'anibal'), ('13', '5', '1', 'A', '2014-06-09', '0101', '7', '58.02', '0.00', '406.14', '5', '', '', 'anibal'), ('14', '6', '1', 'A', '2014-06-10', '0101', '7', '58.02', '0.00', '406.14', '6', '', '', 'anibal'), ('15', '6', '1', 'A', '2014-06-10', '0101', '30', '58.02', '0.00', '1740.60', '7', '', '', 'anibal'), ('16', '7', '1', 'A', '2014-06-10', '0101', '22', '58.02', '0.00', '1276.44', '8', '123456', '987654', 'anibal'), ('17', '7', '1', 'A', '2014-06-10', '0101', '31', '58.02', '0.00', '1798.62', '9', '123456', '987654', 'anibal'), ('18', '8', '1', 'A', '2014-06-10', '0101', '55', '58.02', '0.00', '3191.10', '1', '748', '654', 'anibal'), ('19', '9', '1', 'A', '2014-06-10', '0101', '3', '58.02', '0.00', '174.06', '1', '7652', '87421', 'anibal'), ('20', '9', '1', 'A', '2014-06-10', '0101', '20', '58.02', '0.00', '1160.40', '10', '7652', '87421', 'anibal'), ('21', '10', '2', 'A', '2014-06-11', '0101', '23', '58.02', '0.00', '1334.46', '11', '7454', '2145', 'anibal');
COMMIT;

-- ----------------------------
-- Table structure for `tb_compratemp`
-- ----------------------------
DROP TABLE IF EXISTS `tb_compratemp`;
CREATE TABLE `tb_compratemp` (
`F_IdCom`  int(11) NOT NULL AUTO_INCREMENT ,
`F_FecApl`  date NOT NULL ,
`F_ClaPro`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_Lote`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_FecCad`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_FecFab`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_Marca`  int(11) NOT NULL ,
`F_Provee`  int(11) NOT NULL ,
`F_Cb`  int(13) NOT NULL ,
`F_CanCom`  int(11) NOT NULL ,
`F_Costo`  double(20,2) NOT NULL ,
`F_ImpTo`  double(20,2) NOT NULL ,
`F_ComTot`  double(20,2) NOT NULL ,
`F_FolRemi`  varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_OrdCom`  varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_User`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
PRIMARY KEY (`F_IdCom`),
FOREIGN KEY (`F_User`) REFERENCES `tb_usuario` (`F_Usu`) ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY (`F_ClaPro`) REFERENCES `tb_medica` (`F_ClaPro`) ON DELETE NO ACTION ON UPDATE NO ACTION,
INDEX `FK_Claprod` (`F_ClaPro`) USING BTREE ,
INDEX `tb_compra_ibfk_4` (`F_User`) USING BTREE 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=2

;

-- ----------------------------
-- Records of tb_compratemp
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for `tb_coninv`
-- ----------------------------
DROP TABLE IF EXISTS `tb_coninv`;
CREATE TABLE `tb_coninv` (
`F_IdCon`  int(11) NOT NULL ,
`F_DesCon`  varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
PRIMARY KEY (`F_IdCon`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Records of tb_coninv
-- ----------------------------
BEGIN;
INSERT INTO `tb_coninv` VALUES ('1', 'COMPRAS');
COMMIT;

-- ----------------------------
-- Table structure for `tb_factura`
-- ----------------------------
DROP TABLE IF EXISTS `tb_factura`;
CREATE TABLE `tb_factura` (
`F_IdFact`  int(11) NOT NULL AUTO_INCREMENT ,
`F_ClaDoc`  int(11) NOT NULL ,
`F_ClaCli`  varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_StsFact`  varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_FecApl`  date NOT NULL ,
`F_ClaPro`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_CantReq`  int(11) NOT NULL ,
`F_CantSur`  int(11) NOT NULL ,
`F_Costo`  double(2,0) NOT NULL ,
`F_Lote`  int(11) NOT NULL ,
`F_FecEnt`  date NOT NULL ,
`F_User`  int(11) NOT NULL ,
PRIMARY KEY (`F_IdFact`),
FOREIGN KEY (`F_ClaDoc`) REFERENCES `tb_indice` (`F_IndFact`) ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY (`F_ClaPro`) REFERENCES `tb_medica` (`F_ClaPro`) ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY (`F_Lote`) REFERENCES `tb_lote` (`F_FolLot`) ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY (`F_ClaCli`) REFERENCES `tb_uniatn` (`F_ClaCli`) ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY (`F_User`) REFERENCES `tb_usuario` (`F_IdUsu`) ON DELETE NO ACTION ON UPDATE NO ACTION,
INDEX `FK_Lotef` (`F_Lote`) USING BTREE ,
INDEX `FK_ClaMed` (`F_ClaPro`) USING BTREE ,
INDEX `FK_Usua` (`F_User`) USING BTREE ,
INDEX `FK_UniAt` (`F_ClaCli`) USING BTREE ,
INDEX `FK_IndF` (`F_ClaDoc`) USING BTREE 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=1

;

-- ----------------------------
-- Records of tb_factura
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for `tb_indice`
-- ----------------------------
DROP TABLE IF EXISTS `tb_indice`;
CREATE TABLE `tb_indice` (
`F_IndFact`  int(11) NOT NULL ,
`F_IndCom`  int(11) NOT NULL ,
`F_IndLote`  int(11) NOT NULL ,
PRIMARY KEY (`F_IndFact`, `F_IndCom`, `F_IndLote`),
INDEX `F_IndCom` (`F_IndCom`) USING BTREE ,
INDEX `F_IndFact` (`F_IndFact`) USING BTREE ,
INDEX `F_IndLote` (`F_IndLote`) USING BTREE 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Records of tb_indice
-- ----------------------------
BEGIN;
INSERT INTO `tb_indice` VALUES ('1', '11', '12');
COMMIT;

-- ----------------------------
-- Table structure for `tb_lote`
-- ----------------------------
DROP TABLE IF EXISTS `tb_lote`;
CREATE TABLE `tb_lote` (
`F_ClaPro`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_ClaLot`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_FecCad`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_ExiLot`  int(10) NOT NULL ,
`F_FolLot`  int(11) NOT NULL ,
`F_ClaProve`  int(11) NOT NULL ,
`F_Ubica`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_FecFab`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_Cb`  int(13) NOT NULL ,
`F_ClaMar`  int(11) NOT NULL ,
PRIMARY KEY (`F_FolLot`),
FOREIGN KEY (`F_ClaProve`) REFERENCES `tb_proveedor` (`F_ClaProve`) ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY (`F_ClaPro`) REFERENCES `tb_medica` (`F_ClaPro`) ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY (`F_ClaMar`) REFERENCES `tb_marca` (`F_ClaMar`) ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY (`F_Ubica`) REFERENCES `tb_ubica` (`F_ClaUbi`) ON DELETE NO ACTION ON UPDATE NO ACTION,
INDEX `FK_Marc` (`F_ClaMar`) USING BTREE ,
INDEX `FK_Clapro` (`F_ClaPro`) USING BTREE ,
INDEX `FK_Ubic` (`F_Ubica`) USING BTREE ,
INDEX `fk_idprov` (`F_ClaProve`) USING BTREE 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Records of tb_lote
-- ----------------------------
BEGIN;
INSERT INTO `tb_lote` VALUES ('0101', '123', '30/06/2014', '58', '1', '1', 'NUEVA', '23/06/2014', '465461', '1'), ('0101', '1454', '30/06/2014', '61', '2', '1', 'NUEVA', '17/06/2014', '1234654', '1'), ('0101', '4751', '04/07/2014', '81', '3', '1', 'NUEVA', '16/06/2014', '4564', '1'), ('0101', '47', '30/06/2014', '7', '4', '1', 'NUEVA', '17/06/2014', '4121', '1'), ('0101', '6325', '30/06/2014', '12', '5', '1', 'NUEVA', '16/06/2014', '644', '1'), ('0101', '2584', '03/06/2014', '7', '6', '1', 'NUEVA', '01/06/2014', '321455', '1'), ('0101', '32A', '30/06/2014', '30', '7', '1', 'NUEVA', '02/06/2014', '13212', '1'), ('0101', '9A23', '30/06/2014', '22', '8', '1', 'NUEVA', '02/06/2014', '25631', '1'), ('0101', '2B14', '28/08/2014', '31', '9', '1', 'NUEVA', '09/07/2014', '325641', '1'), ('0101', '54PO', '25/07/2014', '20', '10', '1', 'NUEVA', '11/06/2014', '3652', '1'), ('0101', '124', '30/06/2014', '23', '11', '2', 'NUEVA', '10/06/2014', '456132', '4');
COMMIT;

-- ----------------------------
-- Table structure for `tb_marca`
-- ----------------------------
DROP TABLE IF EXISTS `tb_marca`;
CREATE TABLE `tb_marca` (
`F_ClaMar`  int(11) NOT NULL AUTO_INCREMENT ,
`F_DesMar`  varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
PRIMARY KEY (`F_ClaMar`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=5

;

-- ----------------------------
-- Records of tb_marca
-- ----------------------------
BEGIN;
INSERT INTO `tb_marca` VALUES ('1', 'FC'), ('3', 'HP'), ('4', 'HP2');
COMMIT;

-- ----------------------------
-- Table structure for `tb_medica`
-- ----------------------------
DROP TABLE IF EXISTS `tb_medica`;
CREATE TABLE `tb_medica` (
`F_ClaPro`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_DesPro`  varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_StsPro`  varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_TipMed`  int(4) NOT NULL ,
`F_Costo`  varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
PRIMARY KEY (`F_ClaPro`),
FOREIGN KEY (`F_TipMed`) REFERENCES `tb_tipmed` (`F_TipMed`) ON DELETE NO ACTION ON UPDATE NO ACTION,
INDEX `FK_TipMed` (`F_TipMed`) USING BTREE 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Records of tb_medica
-- ----------------------------
BEGIN;
INSERT INTO `tb_medica` VALUES ('0101', 'acido', 'A', '2504', '58.02');
COMMIT;

-- ----------------------------
-- Table structure for `tb_movinv`
-- ----------------------------
DROP TABLE IF EXISTS `tb_movinv`;
CREATE TABLE `tb_movinv` (
`F_IdMov`  int(11) NOT NULL AUTO_INCREMENT ,
`F_FecMov`  date NOT NULL ,
`F_DocMov`  int(11) NOT NULL ,
`F_ConMov`  int(11) NOT NULL ,
`F_ProMov`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_CantMov`  int(11) NOT NULL ,
`F_CostMov`  double(20,2) NOT NULL ,
`F_TotMov`  double(20,2) NOT NULL ,
`F_SigMov`  int(2) NOT NULL ,
`F_LotMov`  int(11) NOT NULL ,
`F_UbiMov`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_User`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
PRIMARY KEY (`F_IdMov`),
FOREIGN KEY (`F_ConMov`) REFERENCES `tb_coninv` (`F_IdCon`) ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY (`F_LotMov`) REFERENCES `tb_lote` (`F_FolLot`) ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY (`F_UbiMov`) REFERENCES `tb_ubica` (`F_ClaUbi`) ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY (`F_User`) REFERENCES `tb_usuario` (`F_Usu`) ON DELETE NO ACTION ON UPDATE NO ACTION,
INDEX `FK_LotM` (`F_LotMov`) USING BTREE ,
INDEX `FK_Usu` (`F_User`) USING BTREE ,
INDEX `FK_ConIn` (`F_ConMov`) USING BTREE ,
INDEX `FK_UbMov` (`F_UbiMov`) USING BTREE 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=24

;

-- ----------------------------
-- Records of tb_movinv
-- ----------------------------
BEGIN;
INSERT INTO `tb_movinv` VALUES ('6', '2014-06-09', '1', '1', '0101', '0', '58.02', '522.18', '1', '1', 'NUEVA', 'anibal'), ('7', '2014-06-09', '2', '1', '0101', '7', '58.02', '406.14', '1', '2', 'NUEVA', 'anibal'), ('8', '2014-06-09', '2', '1', '0101', '11', '58.02', '638.22', '1', '2', 'NUEVA', 'anibal'), ('9', '2014-06-09', '2', '1', '0101', '43', '58.02', '2494.86', '1', '2', 'NUEVA', 'anibal'), ('10', '2014-06-09', '3', '1', '0101', '9', '58.02', '522.18', '1', '3', 'NUEVA', 'anibal'), ('11', '2014-06-09', '3', '1', '0101', '22', '58.02', '1276.44', '1', '3', 'NUEVA', 'anibal'), ('12', '2014-06-09', '3', '1', '0101', '50', '58.02', '2901.00', '1', '3', 'NUEVA', 'anibal'), ('13', '2014-06-09', '4', '1', '0101', '7', '58.02', '406.14', '1', '4', 'NUEVA', 'anibal'), ('14', '2014-06-09', '5', '1', '0101', '5', '58.02', '290.10', '1', '5', 'NUEVA', 'anibal'), ('15', '2014-06-09', '5', '1', '0101', '7', '58.02', '406.14', '1', '5', 'NUEVA', 'anibal'), ('16', '2014-06-10', '6', '1', '0101', '7', '58.02', '406.14', '1', '6', 'NUEVA', 'anibal'), ('17', '2014-06-10', '6', '1', '0101', '30', '58.02', '1740.60', '1', '7', 'NUEVA', 'anibal'), ('18', '2014-06-10', '7', '1', '0101', '22', '58.02', '1276.44', '1', '8', 'NUEVA', 'anibal'), ('19', '2014-06-10', '7', '1', '0101', '31', '58.02', '1798.62', '1', '9', 'NUEVA', 'anibal'), ('20', '2014-06-10', '8', '1', '0101', '55', '58.02', '3191.10', '1', '1', 'NUEVA', 'anibal'), ('21', '2014-06-10', '9', '1', '0101', '3', '58.02', '174.06', '1', '1', 'NUEVA', 'anibal'), ('22', '2014-06-10', '9', '1', '0101', '20', '58.02', '1160.40', '1', '10', 'NUEVA', 'anibal'), ('23', '2014-06-11', '10', '1', '0101', '23', '58.02', '1334.46', '1', '11', 'NUEVA', 'anibal');
COMMIT;

-- ----------------------------
-- Table structure for `tb_proveedor`
-- ----------------------------
DROP TABLE IF EXISTS `tb_proveedor`;
CREATE TABLE `tb_proveedor` (
`F_ClaProve`  int(11) NOT NULL AUTO_INCREMENT ,
`F_NomPro`  varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_Dir`  varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_Col`  varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_Cp`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_Tel`  int(14) NOT NULL ,
`F_Rfc`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_Fax`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_Mail`  varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
PRIMARY KEY (`F_ClaProve`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=3

;

-- ----------------------------
-- Records of tb_proveedor
-- ----------------------------
BEGIN;
INSERT INTO `tb_proveedor` VALUES ('1', 'PISSA', 'GHJGJ', 'GJHGJ', '54', '4654', '654', '', ''), ('2', 'ALFA', '', '', '', '132', '', '', '');
COMMIT;

-- ----------------------------
-- Table structure for `tb_tipmed`
-- ----------------------------
DROP TABLE IF EXISTS `tb_tipmed`;
CREATE TABLE `tb_tipmed` (
`F_TipMed`  int(4) NOT NULL ,
`F_DesMed`  varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
PRIMARY KEY (`F_TipMed`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Records of tb_tipmed
-- ----------------------------
BEGIN;
INSERT INTO `tb_tipmed` VALUES ('2504', 'MEDICAMENTO'), ('2505', 'MATERIAL DE CURACIÓN');
COMMIT;

-- ----------------------------
-- Table structure for `tb_tipusuario`
-- ----------------------------
DROP TABLE IF EXISTS `tb_tipusuario`;
CREATE TABLE `tb_tipusuario` (
`F_IdTipo`  int(11) NOT NULL AUTO_INCREMENT ,
`F_DesTipo`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
PRIMARY KEY (`F_IdTipo`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=3

;

-- ----------------------------
-- Records of tb_tipusuario
-- ----------------------------
BEGIN;
INSERT INTO `tb_tipusuario` VALUES ('1', 'Super usuario'), ('2', 'Maximo');
COMMIT;

-- ----------------------------
-- Table structure for `tb_ubica`
-- ----------------------------
DROP TABLE IF EXISTS `tb_ubica`;
CREATE TABLE `tb_ubica` (
`F_ClaUbi`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_DesUbi`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_Cb`  int(11) NOT NULL ,
PRIMARY KEY (`F_ClaUbi`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Records of tb_ubica
-- ----------------------------
BEGIN;
INSERT INTO `tb_ubica` VALUES ('NUEVA', 'NUEVA', '1');
COMMIT;

-- ----------------------------
-- Table structure for `tb_uniatn`
-- ----------------------------
DROP TABLE IF EXISTS `tb_uniatn`;
CREATE TABLE `tb_uniatn` (
`F_ClaCli`  varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_NomCli`  varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_StsCli`  varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
PRIMARY KEY (`F_ClaCli`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Records of tb_uniatn
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for `tb_usuario`
-- ----------------------------
DROP TABLE IF EXISTS `tb_usuario`;
CREATE TABLE `tb_usuario` (
`F_IdUsu`  int(11) NOT NULL AUTO_INCREMENT ,
`F_Usu`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_Pass`  varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_Nombre`  varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_Apellido`  varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_Status`  varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`F_TipUsu`  int(11) NOT NULL ,
PRIMARY KEY (`F_IdUsu`),
FOREIGN KEY (`F_TipUsu`) REFERENCES `tb_tipusuario` (`F_IdTipo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
INDEX `FK_TipUsu` (`F_TipUsu`) USING BTREE ,
INDEX `F_Usu` (`F_Usu`) USING BTREE 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=2

;

-- ----------------------------
-- Records of tb_usuario
-- ----------------------------
BEGIN;
INSERT INTO `tb_usuario` VALUES ('1', 'anibal', '*81F5E21E35407D884A6CD4A731AEBFB6AF209E1B', 'anibal', 'rincon', 'A', '1');
COMMIT;

-- ----------------------------
-- Auto increment value for `tb_compra`
-- ----------------------------
ALTER TABLE `tb_compra` AUTO_INCREMENT=22;

-- ----------------------------
-- Auto increment value for `tb_compratemp`
-- ----------------------------
ALTER TABLE `tb_compratemp` AUTO_INCREMENT=2;

-- ----------------------------
-- Auto increment value for `tb_factura`
-- ----------------------------
ALTER TABLE `tb_factura` AUTO_INCREMENT=1;

-- ----------------------------
-- Auto increment value for `tb_marca`
-- ----------------------------
ALTER TABLE `tb_marca` AUTO_INCREMENT=5;

-- ----------------------------
-- Auto increment value for `tb_movinv`
-- ----------------------------
ALTER TABLE `tb_movinv` AUTO_INCREMENT=24;

-- ----------------------------
-- Auto increment value for `tb_proveedor`
-- ----------------------------
ALTER TABLE `tb_proveedor` AUTO_INCREMENT=3;

-- ----------------------------
-- Auto increment value for `tb_tipusuario`
-- ----------------------------
ALTER TABLE `tb_tipusuario` AUTO_INCREMENT=3;

-- ----------------------------
-- Auto increment value for `tb_usuario`
-- ----------------------------
ALTER TABLE `tb_usuario` AUTO_INCREMENT=2;
