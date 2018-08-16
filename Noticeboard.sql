/*表格显示*/
SELECT category, edited_by, IFNULL(content, ) FROM NoticeBoard 

WHERE target_at LIKE '%' valid_until >= CURRENT_DATE /*只查看未过期公告*/
AND 