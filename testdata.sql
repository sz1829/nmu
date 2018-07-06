insert into department values 
(1, 'Xian', '纳美旅游西安分部'),
(2, 'Beijing', '纳美旅游北京分部'),
(3, 'Manhattan', '纳美旅游曼哈顿分部'),
(4, 'Flushing', '纳美旅游法拉盛分部');

insert into salesperson VALUES
(1, 'Shuangjin', 'Zhang', 'sj', '3', '6464968194', 'shuangjin.zhang@aotrip.net', 'IT Department', NULL, 'M', 'Y'),
(2, '希', '陈', 'xi', '3', '1234567890', 'xi.chen@aotrip.net', 'IT Department', NULL, 'M', 'Y'),
(3, 'Xirui', 'Dai', 'daisy', '3', '1234567890', 'daisy.dai@aotrip.net', 'Marketing Department', NULL, 'F', 'Y');

insert into customer VALUES 
(1, 'Fname', 'Lname', 'test@test.com', '1234567890', 'wechat', 'test', '2018-06-14', 'M', '11377'),
(2, '名字T', '一', 'test2@test.com', '1234567890', 'wechat', 'test2', '2018-06-15', 'M', '11377'), 
(3, 'Fname2', 'Lname2', 'test@test.com', '1234567890', 'wechat', 'test', '2018-06-14', 'M', '11377'),
(4, '名字2', '二', 'test2@test.com', '1234567890', 'wechat', 'test2', '2018-06-15', 'M', '11377'), 
(5, 'Fname3', 'Lname3', 'test@test.com', '1234567890', 'wechat', 'test', '2018-06-14', 'M', '11377'),
(6, '名字3', '三', 'test2@test.com', '1234567890', 'wechat', 'test2', '2018-06-15', 'M', '11377'), 
(7, 'Fname4', 'Lname4', 'test@test.com', '1234567890', 'wechat', 'test', '2018-06-14', 'M', '11377'),
(8, '名字4', '四', 'test2@test.com', '1234567890', 'wechat', 'test2', '2018-06-15', 'M', '11377'), 
(9, 'Fname5', 'Lname5', 'test@test.com', '1234567890', 'wechat', 'test', '2018-06-14', 'M', '11377'),
(10, '名字5', '五', 'test2@test.com', '1234567890', 'wechat', 'test2', '2018-06-15', 'M', '11377'), 
(11, 'Fname6', 'Lname6', 'test@test.com', '1234567890', 'wechat', 'test', '2018-06-14', 'M', '11377'),
(12, '名字6', '六', 'test2@test.com', '1234567890', 'wechat', 'test2', '2018-06-15', 'M', '11377'), 
(13, 'Fname7', 'Lname7', 'test@test.com', '1234567890', 'wechat', 'test', '2018-06-14', 'M', '11377'),
(14, '名字7', '七', 'test2@test.com', '1234567890', 'wechat', 'test2', '2018-06-15', 'M', '11377'), 
(15, 'Fname8', 'Lname8', 'test@test.com', '1234567890', 'wechat', 'test', '2018-06-14', 'M', '11377'),
(16, '名字8', '八', 'test2@test.com', '1234567890', 'wechat', 'test2', '2018-06-15', 'M', '11377');


insert into airtickettour values 
(1, 1, 1, 'QPJZ7Y', '3B39JG', 'group', 'round', 1, 0, 0, 'N', 'Song Xue', 
'1P', 'NL5WED-649378'),

(2, 2, 2, 'PC5CBH', '38HFQG', 'individual', 'oneway', 2, 2, 0, 'N', 'Siyuan Zhou, Yitong Yu, Zhouhan Yu, Na Li', 
'1P', 'NL5WED-649378');

insert into airschedule VALUES
(1, 1, 'PEK', 'JFK', '2018-06-14', 'AA123', '2018-08-14'),
(2, 2, 'PEK', 'JFK', '2018-06-14', 'AA123', '2018-08-14'),
(3, 2, 'JFK', 'EWK', '2018-07-02', 'AA123', '2018-08-14'),
(4, 2, 'EWK', 'JFK', '2018-07-04', 'AA123', '2018-08-14'),
(5, 2, 'JFK', 'PEK', '2018-07-05', 'AA123', '2018-08-14');

insert into couponcode values 
(1, 'TEST', 100, 'N', 1, 'Special Discount for Test'),
(2, 'TEST2', 999, 'N', 2, 'Special Discount for TEST'),
(3, 'TEST3', 10, 'N', 3, '测试专用折扣码');

insert into customersource VALUES
(1, '途牛网'),
(2, '谷歌搜索');

insert into touristguide VALUES
(1, 'Nancy', 'Wong', 'nancy.wong@aotrip.net', '1234567890', 'wechat', 'nancy', 'F', 'Nice person', '26'),
(2, '试', '测', 'test@test.com', '1234567890', 'QQ', '1232137219', 'M', 'Only for testing', '1');

insert into grouptour VALUES
(1, 'TEST', 1, '2018-06-15', '2018-07-01', 15, 'TEST0615', 'Test Bus', 1000, 500, 200, 800, 100, 'Tuniu', 1, 1, 4),
(2, 'TEST2', 2, '2017-12-12', '2018-01-01', 18, 'TEST2018', 'Test Big Bus', 4500, 3000, 500, 4000, 500, 'Tufeng', 2, 2, 10);

insert into wholesaler VALUES
(1, '途牛', '1234567890', 'test@test.com', '途牛国际合作部', 'Beijing', 'Platform Product', 'tuniu', '陈先生', '1234567890'),
(2, '迪峰', '1234354393', 'difeng@test.com', '线上产品分销', 'New York', 'Profuct Distribution', 'difeng', 'Mr. Chen', '1237826434');

insert into individualtour VALUES
(1, 1, 1, 4, '2017-12-12', '2017-12-18', 'Pubu5days', '大瀑布5日游', 6.40),
(2, 2, 3, 10, '2018-08-01', '2018-08-15', 'Tokyo15days', '东京15日深度游', 6.39);

insert into tourdetails VALUES
(1, 3, 1, '2017-12-12', '2017-12-18', 'Beijing', 'New York', NULL, 'USD', 'creditcard', 1000, 'N', 'N', 1, 100),
(2, 4, 1, '2017-12-12', '2017-12-18', 'Beijing', 'New York', NULL, 'USD', 'mco', 1000, 'N', 'N', NULL, 0),
(3, 5, 1, '2017-12-12', '2017-12-18', 'Beijing', 'New York', NULL, 'USD', 'alipay', 1000, 'N', 'N', NULL, 10),
(4, 6, 1, '2017-12-12', '2017-12-18', 'Beijing', 'New York', NULL, 'USD', 'wechat', 1000, 'N', 'N', NULL, 0),
(5, 7, 2, '2018-01-01', '2018-08-15', 'Beijing', 'New York', NULL, 'USD', 'cash', 1000, 'N', 'N', 1, 100),
(6, 8, 2, '2018-01-01', '2018-08-15', 'Beijing', 'New York', NULL, 'RMB', 'check', 1000, 'N', 'N', 2, 999),
(7, 9, 2, '2018-01-02', '2018-08-15', 'Los Angeles', 'New York', NULL, 'USD', 'other', 1000, 'N', 'N', NULL, 5),
(8, 10, 2, '2018-01-03', '2018-08-15', 'Beijing', 'New York', NULL, 'USD', 'creditcard', 1000, 'N', 'N', 1, 100),
(9, 11, 2, '2018-01-04', '2018-08-15', 'Beijing', 'New York', NULL, 'USD', 'mco', 1000, 'N', 'N', NULL, 200),
(10, 12, 2, '2018-01-01', '2018-08-15', 'Beijing', 'New York', NULL, 'RMB', 'alipay', 1000, 'N', 'N', NULL, 50),
(11, 13, 2, '2018-01-01', '2018-08-14', 'Beijing', 'New York', NULL, 'USD', 'wechat', 1000, 'N', 'N', 3, 10),
(12, 14, 2, '2018-01-01', '2018-08-13', 'Beijing', 'New York', NULL, 'RMB', 'cash', 1000, 'N', 'N', 3, 10),
(13, 15, 2, '2018-01-01', '2018-08-12', 'Beijing', 'Boston', NULL, 'USD', 'check', 1000, 'N', 'N', NULL, 45),
(14, 16, 2, '2018-01-01', '2018-08-15', 'Beijing', 'New York', NULL, 'USD', 'other', 1000, 'N', 'N', 3, 10);

insert into usergroup VALUES
(1, 'normal', '普通用户，仅销售权限，仅能查看用户相关订单'),
(2, 'accounting', '会计用户，可以查看所有订单并执行clear和lock'),
(3, 'admin', '管理员用户，拥有所有权限');

insert into useraccount VALUES
(1, 'sj', '123456', 3, '2018-06-19 00:00:00');

insert into noticeboard VALUES
(1, '2018-06-15', 1, 'the system is under maintenance', 'highlight', 'bold', 'top'),
(2, '2018-06-13', 1, 'the building is in construction. be aware', 'highlight', NULL, NULL);

insert into otherinfo VALUES
(1, 'default_value', 'default_currency', 6.40);

insert into questionboard VALUES
(1, '麻烦看一下有4个V嘛', '2018-05-16 00:03:36', 1, '抱歉，最低只看到Ｔ仓', '2018-05-16 00:28:09', 'solved', 'airticket', '2 DL 267V 15JUL SU JFKSFO');

insert into thingstodo values 
(1, '2018-06-19 11:03:00', '完成散拼团的更新页面', 1, 'highlight', 'notice', 'A Title'),
(2, '2018-06-19 11:03:00', '完成历史订单', 1, 'normal', 'calendar', 'B 标题');

insert into transactions VALUES
(1, 'group', 1, NULL, NULL, 1, 3, 800, 1000, 0, 'creditcard', 190, 'This is the first note for group tour', '2018-05-12 01:01:01', 1, 'USD', 'N', 'N', 10), 
(2, 'group', 2, NULL, NULL, 2, 1, 4000, 4500, 0, 'cash', 400, 'Second order', '2018-06-30', 2, 'RMB', 'N', 'N', 100), 
(3, 'individual', NULL, 1, NULL, 1, NULL, 2500, 4000, 0, 'multiple', 1390, NULL, '2017-11-22 13:00:00', 1, 'USD', 'N', 'N', 110),
(4, 'individual', NULL, 2, NULL, 2, NULL, 3000, 7469.48, 0, 'multiple', 2940.48, NULL, '2017-12-23 00:00:00', 2, 'USD', 'N', 'N', 1529),
(5, 'airticket', NULL, NULL, 1, 1, 1, 1000, 1500, 50, 'mco', 450, 'This is the first note for airticket tour', '2017-08-01', 2, 'USD', 'N', 'N', 100),
(6, 'airticket', NULL, NULL, 2, 3, 3, 400, 780, 0, 'wechat', 370, NULL, '2017-05-24', 1, 'RMB', 'N', 'N', 10);


