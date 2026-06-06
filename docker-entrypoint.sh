#!/bin/sh
 
mkdir -p /var/www/public_html
mkdir -p /var/www/logs

if [ ! -f /var/www/public_html/index.php ]; then
cat > /var/www/public_html/index.php << 'EOF'
<?php
echo "Site is running.";
EOF
fi

chown -R www-data:www-data /var/www

exec apache2-foreground