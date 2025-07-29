#!/bin/bash

# הגדרות
MYSQL_CONTAINER="mysql-container"
JOOMLA_CONTAINER="joomla-container"
DB_NAME="joomladb"
DB_USER="joomlauser"
DB_PASS="joomlapass"
DATE=$(date +%F_%H-%M)
BACKUP_DIR="./backup_$DATE"
SQL_BACKUP="$BACKUP_DIR/joomla-db.sql.gz"
FILES_BACKUP="$BACKUP_DIR/joomla-files.tar.gz"

# יצירת תיקיית גיבוי
mkdir -p "$BACKUP_DIR"

echo "🔄 מגבה את בסיס הנתונים..."
docker exec "$MYSQL_CONTAINER" sh -c \
  "exec mysqldump -u$DB_USER -p$DB_PASS $DB_NAME" \
  | gzip > "$SQL_BACKUP"

if [ $? -eq 0 ]; then
  echo "✅ גיבוי בסיס נתונים נשמר ב: $SQL_BACKUP"
else
  echo "❌ שגיאה בגיבוי בסיס הנתונים!"
  exit 1
fi

echo "🔍 בודק אם קיים Volume לקונטיינר Joomla..."
VOLUME_PATH=$(docker inspect "$JOOMLA_CONTAINER" \
  --format '{{ range .Mounts }}{{ if eq .Destination "/var/www/html" }}{{ .Name }}{{ end }}{{ end }}')

if [ -n "$VOLUME_PATH" ]; then
  echo "💾 נמצא Volume בשם: $VOLUME_PATH"
  echo "📦 מגבה את הקבצים מתוך ה־Volume..."

  docker run --rm \
    -v "$VOLUME_PATH":/html \
    -v "$PWD/$BACKUP_DIR":/backup \
    alpine tar czf /backup/joomla-files.tar.gz -C /html .

  if [ $? -eq 0 ]; then
    echo "✅ גיבוי קבצי האתר נשמר ב: $FILES_BACKUP"
  else
    echo "❌ שגיאה בגיבוי קבצי האתר!"
  fi
else
  echo "⚠️ לא נמצא Volume לקבצי האתר (/var/www/html). מדלג על גיבוי קבצים."
fi

echo "🎉 סיום גיבוי. כל הקבצים בתיקייה: $BACKUP_DIR"
