#!/bin/bash

echo "🧹 מבצע ניקוי של כל רכיבי הפרויקט..."

# מחיקת הקונטיינרים
echo "🔴 מוחק את הקונטיינרים..."
docker rm -f joomla-container mysql-container 2>/dev/null

# מחיקת הרשת
echo "🔌 מוחק את הרשת..."
docker network rm my-joomla-network 2>/dev/null

# מחיקת התמונות (אם נבנו מקומית)
echo "🧯 מוחק את התמונות שנבנו מקומית..."
docker rmi joomla mysql 2>/dev/null

# מחיקת כל ה-volumes ששייכים לפרויקט
echo "🗑️ מוחק את ה-Volumes..."
docker volume rm joomla_volume mysql_volume 2>/dev/null

# מחיקת קבצי הגיבוי המקומיים אם קיימים
echo "🗂️ מוחק קבצי גיבוי מקומיים..."
rm -f my-joomla.backup.sql.gz
rm -f my-joomla-website.tar.gz

echo "✅ הניקוי הסתיים. הסביבה חזרה למצב נקי."
