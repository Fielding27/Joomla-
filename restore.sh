#!/bin/bash

# הגדרות קבועות
MYSQL_CONTAINER="mysql-container"
JOOMLA_CONTAINER="joomla-container"
DB_NAME="joomladb"
DB_USER="joomlauser"
DB_PASS="joomlapass"
BACKUPS_DIR="./backups"

# איתור תיקיית הגיבוי האחרונה שנוצרה לפי תאריך
LATEST_BACKUP=$(ls -td "$BACKUPS_DIR"/backup_* | head -n 1)

# בדיקה שהתיקייה קיימת
if [ ! -d "$LATEST_BACKUP" ]; then
  echo "❌ לא נמצאה תיקיית גיבוי בתיקיית $BACKUPS_DIR"
  exit 1
fi

echo "📁 מתבצע שחזור מתוך: $LATEST_BACKUP"

SQL_BACKUP="$LATEST_BACKUP/joomla-db.sql.gz"
FILES_BACKUP="$LATEST_BACKUP/joomla-files.tar.gz"

# שחזור בסיס הנתונים
echo "🔄 משחזר את בסיס הנתונים..."
gunzip < "$SQL_BACKUP" | docker exec -i "$MYSQL_CONTAINER" \
  sh -c "exec mysql -u$DB_USER -p$DB_PASS $DB_NAME"

if [ $? -eq 0 ]; then
  echo "✅ בסיס הנתונים שוחזר בהצלחה."
else
  echo "❌ שגיאה בשחזור בסיס הנתונים."
  exit 1
fi

# שחזור קבצי האתר אם קיימים
if [ -f "$FILES_BACKUP" ]; then
  echo "🔄 משחזר את קבצי האתר..."
  VOLUME_PATH=$(docker inspect "$JOOMLA_CONTAINER" \
    --format '{{ range .Mounts }}{{ if eq .Destination "/var/www/html" }}{{ .Name }}{{ end }}{{ end }}')

  if [ -n "$VOLUME_PATH" ]; then
    docker run --rm \
      -v "$VOLUME_PATH":/html \
      -v "$PWD/$LATEST_BACKUP":/backup \
      alpine sh -c "rm -rf /html/* && tar xzf /backup/joomla-files.tar.gz -C /html"

    echo "✅ קבצי האתר שוחזרו בהצלחה."
  else
    echo "⚠️ לא נמצא Volume פעיל לקונטיינר Joomla."
  fi
else
  echo "ℹ️ לא נמצא גיבוי קבצים. שוחזר רק בסיס הנתונים."
fi

echo "🎉 השחזור הסתיים."
