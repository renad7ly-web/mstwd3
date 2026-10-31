-- أصناف إضافية: شغّله على قاعدة warehouse_site (آمن للتكرار، ما يكرر الأصناف الموجودة)
USE warehouse_site;

INSERT IGNORE INTO categories (name) VALUES ('قرطاسية'), ('أجهزة'), ('نظافة'), ('مستلزمات طباعة'), ('أدوات سلامة');
INSERT INTO items (category_id, name, quantity, min_quantity)
SELECT c.id, s.n, s.q, s.m FROM (SELECT 'قرطاسية' AS cat,'أقلام حبر' AS n,40 AS q,10 AS m UNION ALL SELECT 'قرطاسية','ورق A4 (رزمة)',12,5 UNION ALL SELECT 'قرطاسية','دفاتر ملاحظات',30,8 UNION ALL SELECT 'قرطاسية','أقلام رصاص',60,15 UNION ALL SELECT 'قرطاسية','أقلام تحديد',18,6 UNION ALL SELECT 'قرطاسية','دباسة',7,3 UNION ALL SELECT 'قرطاسية','دبابيس (علبة)',4,5 UNION ALL SELECT 'أجهزة','فلاشات 32GB',6,5 UNION ALL SELECT 'أجهزة','ماوس لاسلكي',14,4 UNION ALL SELECT 'أجهزة','لوحات مفاتيح',10,3 UNION ALL SELECT 'أجهزة','سماعات رأس',8,4 UNION ALL SELECT 'أجهزة','كابلات HDMI',5,5 UNION ALL SELECT 'نظافة','مناديل (علبة)',50,12 UNION ALL SELECT 'نظافة','معقم أيدي',20,6 UNION ALL SELECT 'نظافة','أكياس قمامة (رزمة)',3,5 UNION ALL SELECT 'مستلزمات طباعة','حبر طابعة أسود',6,3 UNION ALL SELECT 'مستلزمات طباعة','ورق ملصقات',22,5 UNION ALL SELECT 'أدوات سلامة','كمامات (علبة)',15,5 UNION ALL SELECT 'أدوات سلامة','قفازات (علبة)',9,4) s
JOIN categories c ON c.name = s.cat COLLATE utf8mb4_unicode_ci
WHERE NOT EXISTS (SELECT 1 FROM items i WHERE i.name = s.n COLLATE utf8mb4_unicode_ci);
