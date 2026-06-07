#!/bin/sh

mkdir -p /var/www/html
mkdir -p /var/www/logs

if [ ! -f /var/www/html/index.php ]; then
cat > /var/www/html/index.php << 'EOF'
<?php
echo "Site is running.";
EOF
fi

chown -R www-data:www-data /var/www

exec apache2-foreground