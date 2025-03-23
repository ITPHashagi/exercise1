CREATE TABLE `Users` (
	`id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	`fullName` VARCHAR(255) NOT NULL,
	`email` VARCHAR(255) NOT NULL UNIQUE,
	`password` VARCHAR(255) NOT NULL,
	
	`deletedBy` INT NOT NULL DEFAULT 0,
	`isDeleted` TINYINT(1) NOT NULL DEFAULT 0,
	`deletedAt` TIMESTAMP NULL DEFAULT NULL,
	`createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)

INSERT INTO `Users` (`fullname`, `email`, `password`) 
VALUES
('Nguyen Van A', 'nguyenvana@gmail.com', 'hashed_password_123'),
('Tran Thi B', 'tranthib@yahoo.com', 'hashed_password_123'),
('Le Van C', 'levanc@outlook.com', 'hashed_password_123'),
('Pham Thi D', 'phamthid@gmail.com', 'hashed_password_123'),
('Hoang Van E', 'hoangvane@domain.com', 'hashed_password_123')
('Nguyen Van F', 'nguyenvanf@gmail.com', 'hashed_password_123'),
('Tran Thi G', 'tranthig@yahoo.com', 'hashed_password_123'),
('Le Van H', 'levanh@outlook.com', 'hashed_password_123'),
('Pham Thi I', 'phamthii@gmail.com', 'hashed_password_123'),
('Hoang Van K', 'hoangvank@domain.com', 'hashed_password_123')
('Nguyen Thi F', 'nguyenthif@gmail.com', 'hashed_password_123'),
('Tran Van G', 'tranvang@domain.com', 'hashed_password_123');

CREATE TABLE `Foods` (
	`id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	`foodName` VARCHAR(255) NOT NULL,
	`image` VARCHAR(255),
	`price` FLOAT NOT NULL,
	`desc` VARCHAR(255),
	`type_id` INT,
	
	FOREIGN KEY (`type_id`) REFERENCES `Food_type`(`id`),
	
	`deletedBy` INT NOT NULL DEFAULT 0,
	`isDeleted` TINYINT(1) NOT NULL DEFAULT 0,
	`deletedAt` TIMESTAMP NULL DEFAULT NULL,
	`createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)
UPDATE `Foods`
SET `type_id` = 1
WHERE `id` IN (1,5);

INSERT INTO `Foods`(`foodName`,`image`,`price`,`desc`)
VALUES
('Phở Bò', 'pho_bo.jpg', 50000.00, 'Phở bò truyền thống với nước dùng thơm ngon'),
('Bánh Mì Thịt', 'banh_mi.jpg', 25000.50, 'Bánh mì kẹp thịt heo nướng'),
('Gỏi Cuốn', 'goi_cuon.jpg', 30000.00, 'Gỏi cuốn tôm thịt tươi ngon'),
('Cơm Tấm', 'com_tam.jpg', 45000.75, 'Cơm tấm sườn nướng đặc biệt'),
('Bún Chả', 'bun_cha.jpg', 40000.00, 'Bún chả Hà Nội chuẩn vị')

CREATE TABLE `Food_type`(
	`id` INT PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(255),
	
	`deletedBy` INT NOT NULL DEFAULT 0,
	`isDeleted` TINYINT(1) NOT NULL DEFAULT 0,
	`deletedAt` TIMESTAMP NULL DEFAULT NULL,
	`createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)

-- Liên kết food và food_type: 
-- SELECT f.id, f.foodName, f.image, f.price, f.desc, ft.name AS food_type
-- FROM Foods AS f
-- JOIN Food_type AS ft ON f.type_id = ft.id;

INSERT INTO `Food_type`(`name`)
VALUES
('Món Nước'),
('Món Khô')

ALTER TABLE `Foods` 
ADD CONSTRAINT `fk_Food_type`
FOREIGN KEY (`type_id`) 
REFERENCES `Food_type`(`id`) 

CREATE TABLE `order` (
	`id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	`amount` int NOT NULL,
	`code` VARCHAR(255) NOT NULL,
	`arr_sub_id` VARCHAR(255),
	`user_id` int NOT NULL,
	`food_id` int NOT NULL,
	
	FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`),
	FOREIGN KEY (`food_id`) REFERENCES `Foods` (`id`),
	
	`deletedBy` INT NOT NULL DEFAULT 0,
	`isDeleted` TINYINT(1) NOT NULL DEFAULT 0,
	`deletedAt` TIMESTAMP NULL DEFAULT NULL,
	`createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)
INSERT INTO `order`(`amount`, `code`, `arr_sub_id`, `user_id`, `food_id`)
VALUES
(2, 'ORDER001', '1,2', 1, 1),
(1, 'ORDER002', NULL, 2, 2),
(3, 'ORDER003', '3', 3, 3),
(1, 'ORDER004', NULL, 4, 4),
(2, 'ORDER005', '2,4', 5, 5)
(1, 'ORDER001', '1,2', 1, 1),
(1, 'ORDER002', NULL, 1, 2),
(3, 'ORDER003', '3', 5, 3),
(1, 'ORDER004', NULL, 4, 4),
(1, 'ORDER005', '2,4', 3, 5)

CREATE TABLE `Sub_food`(
	`id` INT PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(255),
	`price` FLOAT,
	`food_id` INT,
	FOREIGN KEY (`food_id`) REFERENCES `Foods` (`id`)
)
INSERT INTO `Sub_food` (`name`, `price`, `food_id`)
VALUES
('Quẩy', 5000.00, 1),
('Thịt Bò Thêm', 15000.00, 1),
('Pate', 7000.00, 2),
('Nước Mắm Pha', 3000.00, 3),
('Sườn Nướng Thêm', 20000.00, 4);

-- Kiểm tra thông tin đơn hàng người dùng đã order
SELECT o.code, o.amount, f.foodName, u.fullName, o.arr_sub_id 
FROM `order` o
JOIN `Foods` f ON o.food_id = f.id
JOIN `Users` u ON o.user_id = u.id
WHERE o.isDeleted=0;

CREATE TABLE `Restaurant`(
	`id` INT PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(255),
	`image` VARCHAR(255),
	`desc` VARCHAR(255),
	
	`deletedBy` INT NOT NULL DEFAULT 0,
	`isDeleted` TINYINT(1) NOT NULL DEFAULT 0,
	`deletedAt` TIMESTAMP NULL DEFAULT NULL,
	`createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)
INSERT INTO `Restaurant`(`name`,`image`,`desc`) 
VALUES
('Nhà Hàng Phở Việt', 'pho_viet.jpg', 'Chuyên phục vụ phở bò truyền thống'),
('Quán Bánh Mì 24', 'banh_mi_24.jpg', 'Bánh mì ngon, giá rẻ'),
('Gỏi Cuốn Tươi', 'goi_cuon_tuoi.jpg', 'Gỏi cuốn tươi ngon, sạch sẽ'),
('Cơm Tấm Sài Gòn', 'com_tam_sg.jpg', 'Cơm tấm chuẩn vị Sài Gòn'),
('Bún Chả Hà Nội', 'bun_cha_hn.jpg', 'Bún chả chuẩn vị Hà Nội')
SELECT `id`,`name` FROM `Restaurant`

CREATE TABLE `Rate_res`(
	`user_id` INT,
	`res_id` INT,
	`amount` INT,
	
	FOREIGN KEY (`user_id`) REFERENCES `Users`(`id`),
	FOREIGN KEY (`res_id`) REFERENCES `Restaurant`(`id`),
	
	`date_rate` DATETIME
)
INSERT INTO `Rate_res`(`user_id`,`res_id`,`amount`,`date_rate`)
VALUES
(1, 1, 5, '2025-03-21 09:00:00'),
(2, 2, 4, '2025-03-21 10:30:00'),
(3, 3, 3, '2025-03-21 11:15:00'),
(4, 1, 4, '2025-03-21 12:00:00'),
(5, 5, 5, '2025-03-21 13:45:00')

CREATE TABLE `like_res`(
	`user_id` INT,
	`res_id` INT,
	`date_like` DATETIME,
	FOREIGN KEY (`user_id`) REFERENCES `Users`(`id`),
	FOREIGN KEY (`res_id`) REFERENCES `Restaurant`(`id`)
)
INSERT INTO `like_res` (`user_id`, `res_id`, `date_like`)
VALUES
    (1, 1, '2025-03-21 09:15:00'),
    (2, 1, '2025-03-21 10:45:00'),
    (3, 2, '2025-03-21 11:30:00'),
    (4, 3, '2025-03-21 12:15:00'),
    (5, 5, '2025-03-21 14:00:00'),
    (1, 2, '2025-03-21 15:00:00'),
    (1, 3, '2025-03-21 15:30:00'),
    (1, 4, '2025-03-21 16:00:00'),
    (3, 5, '2025-03-21 16:30:00'),
    (2, 1, '2025-03-21 17:00:00'),
    (5, 2, '2025-03-21 17:30:00'),
    (1, 3, '2025-03-21 18:00:00'),
    (2, 4, '2025-03-21 18:30:00'),
    (2, 5, '2025-03-21 19:00:00'),
    (1, 1, '2025-03-21 19:30:00');
-------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------		XỬ LÝ YÊU CẦU		-----------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-- 1. Tìm 5 người like nhiều nhất
SELECT u.fullName, 
COUNT(lr.res_id) AS like_count -- Đếm số lượt thích của mỗi người
FROM `like_res` lr
JOIN `Users` u ON lr.user_id = u.id
JOIN `Restaurant` r ON lr.res_id = r.id
WHERE r.isDeleted = 0
GROUP BY lr.user_id, u.fullName -- Gộp lại nếu bị trùng
ORDER BY like_count DESC -- Sắp xếp theo giảm dần
LIMIT 5;


-- 2. Tìm 2 nhà hàng có nhiều lượt like nhất
SELECT 
	r.name as restaurantName,
	COUNT(lr.user_id) AS like_count
FROM `like_res` lr
JOIN `Restaurant` r ON lr.res_id = r.id
WHERE r.isDeleted = 0 
GROUP BY lr.res_id, r.`name`
ORDER BY like_count DESC
limit 2;

-- 3. Tìm người đã đặt hàng nhiều nhất
SELECT u.fullName, COUNT(o.id) as order_count
FROM `order` o 
JOIN `Users` u On o.user_id = u.id
WHERE o.isDeleted = 0
GROUP BY o.user_id, u.fullName
ORDER BY order_count DESC
LIMIT 1;

-- 4. Tìm người dùng không hoạt động trong hệ thống
SELECT u.fullName
FROM `Users` u 
LEFT JOIN 
	`order` o ON u.id = o.user_id AND o.isDeleted = 0 
LEFT JOIN 
	`like_res` lr ON u.id = lr.user_id
LEFT JOIN
	`Rate_res` rr ON u.id = rr.user_id
WHERE 
	o.id IS NULL
	AND lr.user_id IS NULL
	AND rr.user_id IS NULL;