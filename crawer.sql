CREATE TABLE areas(
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(400),
  code varchar(255),
  lat  decimal(10, 4),
  lon  decimal(10, 4),
  created_at datetime,
  updated_at datetime,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE circles(
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(255),
  area_id int(11),
  created_at datetime,
  updated_at datetime,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE offices(
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(400),
  link varchar(400),
  source_site varchar(100),
  area_id int(11),
  circle_id int(11),
  lat decimal(10, 4),
  lon decimal(10, 4),
  tel varchar(100),
  address varchar(400),
  contact varchar(100),
  kaifashang varchar(200),
  wuye_name varchar(200),
  wuyefei varchar(100),
  mianji varchar(100),
  zhuangxiu varchar(100),
  chaoxiang varchar(100),
  page_name varchar(100),
  page_hash varchar(100),
  created_at datetime,
  updated_at datetime,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE rents(
  id int(11) NOT NULL AUTO_INCREMENT,
  source_site varchar(100),
  office_id int(11),
  price int(11),
  page_name varchar(100),
  page_hash varchar(255),
  created_at datetime,
  updated_at datetime,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
