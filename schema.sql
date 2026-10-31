CREATE DATABASE IF NOT EXISTS warehouse_site CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE warehouse_site;

CREATE TABLE IF NOT EXISTS categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  category_id INT NOT NULL,
  name VARCHAR(150) NOT NULL,
  quantity INT NOT NULL DEFAULT 0,
  min_quantity INT NOT NULL DEFAULT 5,
  unit VARCHAR(30),
  FOREIGN KEY (category_id) REFERENCES categories(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS issue_requests (
  id INT AUTO_INCREMENT PRIMARY KEY,
  item_id INT NOT NULL,
  requester_name VARCHAR(100) NOT NULL,
  quantity INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (item_id) REFERENCES items(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS alerts (
  id INT AUTO_INCREMENT PRIMARY KEY,
  item_id INT NOT NULL,
  message VARCHAR(255) NOT NULL,
  is_read BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (item_id) REFERENCES items(id) ON DELETE CASCADE
) ENGINE=InnoDB;

INSERT IGNORE INTO categories (name) VALUES ('قرطاسية'), ('أجهزة'), ('نظافة'), ('مستلزمات طباعة'), ('أدوات سلامة');
INSERT INTO items (category_id, name, quantity, min_quantity)
SELECT c.id, s.n, s.q, s.m FROM (SELECT 'قرطاسية' AS cat,'أقلام حبر' AS n,40 AS q,10 AS m UNION ALL SELECT 'قرطاسية','ورق A4 (رزمة)',12,5 UNION ALL SELECT 'قرطاسية','دفاتر ملاحظات',30,8 UNION ALL SELECT 'قرطاسية','أقلام رصاص',60,15 UNION ALL SELECT 'قرطاسية','أقلام تحديد',18,6 UNION ALL SELECT 'قرطاسية','دباسة',7,3 UNION ALL SELECT 'قرطاسية','دبابيس (علبة)',4,5 UNION ALL SELECT 'أجهزة','فلاشات 32GB',6,5 UNION ALL SELECT 'أجهزة','ماوس لاسلكي',14,4 UNION ALL SELECT 'أجهزة','لوحات مفاتيح',10,3 UNION ALL SELECT 'أجهزة','سماعات رأس',8,4 UNION ALL SELECT 'أجهزة','كابلات HDMI',5,5 UNION ALL SELECT 'نظافة','مناديل (علبة)',50,12 UNION ALL SELECT 'نظافة','معقم أيدي',20,6 UNION ALL SELECT 'نظافة','أكياس قمامة (رزمة)',3,5 UNION ALL SELECT 'مستلزمات طباعة','حبر طابعة أسود',6,3 UNION ALL SELECT 'مستلزمات طباعة','ورق ملصقات',22,5 UNION ALL SELECT 'أدوات سلامة','كمامات (علبة)',15,5 UNION ALL SELECT 'أدوات سلامة','قفازات (علبة)',9,4) s
JOIN categories c ON c.name = s.cat COLLATE utf8mb4_unicode_ci
WHERE NOT EXISTS (SELECT 1 FROM items i WHERE i.name = s.n COLLATE utf8mb4_unicode_ci);
