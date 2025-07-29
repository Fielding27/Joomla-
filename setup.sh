#!/bin/bash

# יצירת רשת
docker network create Network

# הרצת בסיס נתונים
docker run -d \
  --name mysql-container \
  --network Network \
  -e MYSQL_ROOT_PASSWORD=my-secret-pw \
  -e MYSQL_DATABASE=joomladb \
  -e MYSQL_USER=joomlauser \
  -e MYSQL_PASSWORD=joomlapass \
  mysql:latest

# המתנה לוודא ש-MySQL מוכן (חובה!)
echo "מחכה 20 שניות שה-MySQL יעלה..."
sleep 20

# הרצת Joomla
docker run -d \
  --name joomla-container \
  --network Network \
  -e JOOMLA_DB_HOST=mysql-container \
  -e JOOMLA_DB_USER=joomlauser \
  -e JOOMLA_DB_PASSWORD=joomlapass \
  -e JOOMLA_DB_NAME=joomladb \
  -p 8080:80 \
  joomla:latest
