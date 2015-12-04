FROM xaamin/php

MAINTAINER "Benjamín Martínez Mateos" <bmxamin@gmail.com>

# Install PHP-HHVM
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449 \
    && add-apt-repository "deb http://dl.hhvm.com/ubuntu $(lsb_release -sc) main" \
    && apt-get -y update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install hhvm \
    && /usr/bin/update-alternatives --install /usr/bin/php php /usr/bin/hhvm 60 \

    # Remove temp files
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Defines the default timezone used by the date functions
ENV DATE_TIMEZONE America/Mexico_City

# Maximum execution time of each script, in seconds (php.ini)

# The timeout for serving a single request after which the worker process will
# be killed. This option should be used when the 'max_execution_time' ini option
# does not stop script execution for some reason. A value of '0' means 'off'.
# Available units: s(econds)(default), m(inutes), h(ours), or d(ays)
# (www.conf)
ENV REQUEST_TIMEOUT 30

# Maximum amount of time each script may spend parsing request data. It's a good
# idea to limit this time on productions servers in order to eliminate unexpectedly
# long running scripts.
ENV MAX_INPUT_TIME 30

# Maximum amount of memory a script may consume (128MB)
ENV MEMORY_LIMIT 128M

# Maximum allowed size for uploaded files.
ENV POST_MAX_SIZE 30M

# Add bootstrap file
ADD start.bash /start.bash

# Add supervisor config file
ADD supervisord.conf /etc/supervisor/supervisord.conf

# Define mountable directories
VOLUME ["/data"]

# Port 9000 is how Nginx will communicate with PHP-FPM.
EXPOSE 9000

# Run startup script.
CMD ["/bin/bash", "/start.bash"]