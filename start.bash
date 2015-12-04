#!/bin/bash

OVERRIDE="/data"
LOGS="logs"

# Create logs directory
if [[ ! -d "$OVERRIDE/$LOGS" ]]; then
	mkdir -p "$OVERRIDE/$LOGS"
fi


# Configure CLI
sed -i 's|date.timezone =.*|date.timezone = '${DATE_TIMEZONE}'|' /etc/php5/cli/php.ini

# Configure PHP Options
echo '' >> /etc/hhvm/php.ini
echo ';PHP custom options' >> /etc/hhvm/php.ini
echo 'date.timezone = '${DATE_TIMEZONE}'' >> /etc/hhvm/php.ini
echo 'max_execution_time = '${REQUEST_TIMEOUT}'' >> /etc/hhvm/php.ini
echo 'max_input_time = '${MAX_INPUT_TIME}'' >> /etc/hhvm/php.ini
echo 'memory_limit = '${MEMORY_LIMIT}'' >> /etc/hhvm/php.ini
echo 'upload_max_filesize = '${POST_MAX_SIZE}'' >> /etc/hhvm/php.ini
echo 'post_max_size = '${POST_MAX_SIZE}'' >> /etc/hhvm/php.ini
echo 'short_open_tag = On' >> /etc/hhvm/php.ini

# Configure PHP Server options
sed -i 's|hhvm.log.file =.*|hhvm.log.file = /data/logs/hhvm.error.log|' /etc/hhvm/server.ini
echo '' >> /etc/hhvm/server.ini
echo ';PHP custom options' >> /etc/hhvm/server.ini
echo 'hhvm.server.connection_timeout_seconds = '${REQUEST_TIMEOUT}'' >> /etc/hhvm/server.ini
echo 'hhvm.server.request_timeout_seconds = '${REQUEST_TIMEOUT}'' >> /etc/hhvm/server.ini

/usr/bin/supervisord -n