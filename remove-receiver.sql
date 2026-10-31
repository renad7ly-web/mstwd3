-- اختياري: يحذف عمود المسلِّم من قاعدة موجودة (الموقع يشتغل بدونه أيضاً)
USE warehouse_site;
ALTER TABLE issue_requests DROP COLUMN receiver_name;
