-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 09, 2026 at 10:45 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tito_venture`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(6, 'Clothing'),
(2, 'Drinks'),
(5, 'Furniture'),
(1, 'Groceries'),
(3, 'Household'),
(4, 'Personal care');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `phone`, `email`, `password_hash`, `created_at`) VALUES
(1, 'wahitu', '0712345678', 'wahitu@gmail.com', '$2y$10$5JNI9bddGk7zzW7xvbpdzeigtARh2QwGoaXZq495vewAU//HlOkEK', '2026-09-22 14:03:06');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `delivery_phone` varchar(20) NOT NULL,
  `delivery_address` varchar(255) NOT NULL,
  `payment_method` enum('cash','mpesa','bank') NOT NULL,
  `payment_reference` varchar(20) DEFAULT NULL,
  `status` enum('pending','confirmed','delivered','cancelled') NOT NULL DEFAULT 'pending',
  `total` decimal(12,2) NOT NULL,
  `confirmed_sale_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `customer_id`, `delivery_phone`, `delivery_address`, `payment_method`, `payment_reference`, `status`, `total`, `confirmed_sale_id`, `created_at`) VALUES
(1, 1, '0712345678', 'kangema', 'mpesa', 'UIMGJ7JZBX', 'delivered', 1750.00, 1, '2026-09-22 14:05:23');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `subtotal` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `unit_price`, `subtotal`) VALUES
(1, 1, 1, 1, 100.00, 100.00),
(2, 1, 2, 3, 500.00, 1500.00),
(3, 1, 3, 1, 150.00, 150.00);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `barcode` varchar(50) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `buying_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `selling_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `reorder_level` int(11) NOT NULL DEFAULT 5,
  `expiry_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `barcode`, `category_id`, `buying_price`, `selling_price`, `quantity`, `reorder_level`, `expiry_date`, `created_at`) VALUES
(1, 'A5 exercise books 200 pages', NULL, NULL, 70.00, 100.00, 61, 5, NULL, '2026-09-22 13:58:32'),
(2, 'dress', NULL, 6, 230.00, 500.00, 60, 5, NULL, '2026-09-22 13:59:46'),
(3, 'sugar', NULL, 2, 100.00, 150.00, 102, 5, '2026-09-23', '2026-09-22 14:00:50');

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `total` decimal(12,2) NOT NULL,
  `payment_method` enum('cash','mpesa','bank') NOT NULL,
  `mpesa_code` varchar(20) DEFAULT NULL,
  `bank_reference` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `user_id`, `total`, `payment_method`, `mpesa_code`, `bank_reference`, `created_at`) VALUES
(1, 1, 1750.00, 'mpesa', 'UIMGJ7JZBX', NULL, '2026-09-22 14:06:16'),
(2, 1, 1500.00, 'bank', NULL, 'SDFRE341234', '2026-09-22 14:07:59'),
(3, 4, 1050.00, 'cash', NULL, NULL, '2026-09-22 14:12:46'),
(4, 3, 600.00, 'mpesa', 'UIMLGHASDW', NULL, '2026-09-22 16:38:57'),
(5, 1, 2250.00, 'cash', NULL, NULL, '2026-09-23 13:12:29'),
(6, 1, 3200.00, 'mpesa', 'UMIKLFRWAD', NULL, '2026-09-25 17:39:08'),
(7, 1, 400.00, 'bank', NULL, 'FT234567890', '2026-09-27 07:01:33');

-- --------------------------------------------------------

--
-- Table structure for table `sale_items`
--

CREATE TABLE `sale_items` (
  `id` int(11) NOT NULL,
  `sale_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `unit_cost` decimal(10,2) NOT NULL DEFAULT 0.00,
  `subtotal` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sale_items`
--

INSERT INTO `sale_items` (`id`, `sale_id`, `product_id`, `quantity`, `unit_price`, `unit_cost`, `subtotal`) VALUES
(1, 1, 1, 1, 100.00, 70.00, 100.00),
(2, 1, 2, 3, 500.00, 230.00, 1500.00),
(3, 1, 3, 1, 150.00, 100.00, 150.00),
(4, 2, 2, 3, 500.00, 230.00, 1500.00),
(5, 3, 1, 4, 100.00, 70.00, 400.00),
(6, 3, 2, 1, 500.00, 230.00, 500.00),
(7, 3, 3, 1, 150.00, 100.00, 150.00),
(8, 4, 3, 4, 150.00, 100.00, 600.00),
(9, 5, 3, 15, 150.00, 100.00, 2250.00),
(10, 6, 1, 32, 100.00, 70.00, 3200.00),
(11, 7, 1, 4, 100.00, 70.00, 400.00);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `mpesa_number` varchar(20) DEFAULT NULL,
  `bank_name` varchar(100) DEFAULT NULL,
  `bank_account_name` varchar(100) DEFAULT NULL,
  `bank_account_number` varchar(40) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `mpesa_number`, `bank_name`, `bank_account_name`, `bank_account_number`, `updated_at`) VALUES
(1, '0717254510', 'KCB', 'Tito venture shop', '1234567890', '2026-09-22 13:57:04');

-- --------------------------------------------------------

--
-- Table structure for table `stock_movements`
--

CREATE TABLE `stock_movements` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `type` enum('restock','sale','adjustment') NOT NULL,
  `quantity` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stock_movements`
--

INSERT INTO `stock_movements` (`id`, `product_id`, `type`, `quantity`, `user_id`, `created_at`) VALUES
(1, 1, 'restock', 45, 1, '2026-09-22 13:58:32'),
(2, 2, 'restock', 12, 1, '2026-09-22 13:59:46'),
(3, 3, 'restock', 23, 1, '2026-09-22 14:00:50'),
(4, 1, 'sale', -1, 1, '2026-09-22 14:06:16'),
(5, 2, 'sale', -3, 1, '2026-09-22 14:06:16'),
(6, 3, 'sale', -1, 1, '2026-09-22 14:06:16'),
(7, 2, 'sale', -3, 1, '2026-09-22 14:07:59'),
(8, 1, 'sale', -4, 4, '2026-09-22 14:12:46'),
(9, 2, 'sale', -1, 4, '2026-09-22 14:12:46'),
(10, 3, 'sale', -1, 4, '2026-09-22 14:12:46'),
(11, 3, 'sale', -4, 3, '2026-09-22 16:38:57'),
(12, 3, 'sale', -15, 1, '2026-09-23 13:12:29'),
(13, 1, 'sale', -32, 1, '2026-09-25 17:39:08'),
(14, 1, 'sale', -4, 1, '2026-09-27 07:01:33'),
(15, 1, 'restock', 57, 1, '2026-09-27 07:04:20'),
(16, 2, 'restock', 55, 1, '2026-09-27 07:04:36'),
(17, 3, 'restock', 100, 1, '2026-09-27 07:04:53');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('admin','cashier') NOT NULL DEFAULT 'cashier',
  `status` enum('active','pending') NOT NULL DEFAULT 'active',
  `security_question` varchar(255) DEFAULT NULL,
  `security_answer_hash` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `password_hash`, `role`, `status`, `security_question`, `security_answer_hash`, `created_at`) VALUES
(1, 'Shop Admin', 'admin', '$2y$10$eX0lG93Ege3pxMItux.37uKLj2jjY/0afycxxQMJBejDo.DN1sKrm', 'admin', 'active', NULL, NULL, '2026-09-22 05:21:25'),
(2, 'Cashier One', 'cashier', '$2y$10$RhuT0QS.buz.BjVToqVaEOUTZuzAtW7hprdYjTWORKMPA1dVJjPCu', 'cashier', 'active', NULL, NULL, '2026-09-22 05:21:26'),
(3, 'David Frankline', 'Tito', '$2y$10$szHgjoX/FjEyzrI4D1ZfSexIkBc02i3LqbCcOUAqHDWTR69tVnMZa', 'admin', 'active', 'year of birth', '$2y$10$LqL19/TRXg6hcvgmTZ2b3.DeDroE2MVnZR1Jk/zICDRZU1CI4g/4K', '2026-09-22 13:52:30'),
(4, 'Jane', 'Jane', '$2y$10$Xbw9gZE6OHu5hgjrn1HFwOTC/pX14RQiIwaATvoRqK44ZFSd.9KWK', 'cashier', 'active', 'year of birth', '$2y$10$GhJnmZbYz59T/bZiLpHSmeuhlAfX99Go7.EtNmyEWLDrDa04hgCZu', '2026-09-22 13:53:56'),
(5, 'SUPPER', 'supper', '$2y$10$XwvFN3S.r/jTyMChVtEbz.FTMED6Dc7MAHO2cLcSM3u/DUTt4fMh6', 'admin', 'active', 'best school subject', '$2y$10$j1LdiskmUvR8AYK9oauFEuxqHJoT7.bb1z1nGtZXtRoW2fjQRYZDW', '2026-09-24 06:46:05');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_orders_customer` (`customer_id`),
  ADD KEY `fk_orders_sale` (`confirmed_sale_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_oitems_order` (`order_id`),
  ADD KEY `fk_oitems_product` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `barcode` (`barcode`),
  ADD KEY `fk_products_category` (`category_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mpesa_code` (`mpesa_code`),
  ADD UNIQUE KEY `bank_reference` (`bank_reference`),
  ADD KEY `fk_sales_user` (`user_id`);

--
-- Indexes for table `sale_items`
--
ALTER TABLE `sale_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_items_sale` (`sale_id`),
  ADD KEY `fk_items_product` (`product_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stock_movements`
--
ALTER TABLE `stock_movements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_moves_product` (`product_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `sale_items`
--
ALTER TABLE `sale_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `stock_movements`
--
ALTER TABLE `stock_movements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `fk_orders_sale` FOREIGN KEY (`confirmed_sale_id`) REFERENCES `sales` (`id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `fk_oitems_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_oitems_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `fk_products_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `fk_sales_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `sale_items`
--
ALTER TABLE `sale_items`
  ADD CONSTRAINT `fk_items_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `fk_items_sale` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `stock_movements`
--
ALTER TABLE `stock_movements`
  ADD CONSTRAINT `fk_moves_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
