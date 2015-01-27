#!/bin/bash

test -d /data/ || { echo "No data volume found. Skipping."; exit; }

# Grab wp-content if it's found (plugins etc)
if [ ! -d /data/wp-content/ ]; then
  echo "Moving wp-content to blank volume.."
  cp -aR /app/wp-content/ /data/
fi

echo "Linking wp-content.."
rm -rf /app/wp-content
ln -sf /data/wp-content /app/wp-content

# Grab custom config file if it's there
if [ -f /data/wp-config-production.php ]; then
  echo "Using wp-config-production.php.."
  rm -f /app/wp-config.php
  ln -sf /data/wp-config-production.php /app/wp-config.php
fi

# Grab .htaccess if it's there
if [ -f /data/.htaccess ]; then
  echo "Using .htaccess.."
  ln -sf /data/.htaccess /app/.htaccess
fi

# Execute init.sh if it's found
if [ -x /data/init.sh ]; then
  echo "Executing custom init.sh.."
  /data/init.sh
fi

