/*表格显示*/
SELECT category, edited_by, content FROM NoticeBoard 
WHERE target_at LIKE '%' valid_until >= CURRENT_DATE;