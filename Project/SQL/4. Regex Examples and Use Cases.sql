USE `bakery`;
CREATE TABLE `z_regular_expression` (
  `reg_id` smallint(6) NOT NULL AUTO_INCREMENT,
  `phone` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phrase` varchar(150) NOT NULL,
  PRIMARY KEY (`reg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `z_regular_expression` VALUES (1,'123-456-789', 'sqlisfun@gmail.com','I love SQL');
INSERT INTO `z_regular_expression` VALUES (2,'123\765\7565','mysqlpro@apple.com','I love MySQL');
INSERT INTO `z_regular_expression` VALUES (3,'123-846-6546','regxpress@yahoo.com','SQL is fun');
INSERT INTO `z_regular_expression` VALUES (4,'123 545 8657','sql4life@gmail.com','IlikeSQLForReal');



SELECT *
FROM z_regular_expression;





