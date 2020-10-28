crontab -r

(crontab -l 2>/dev/null; echo "SHELL=/bin/bash") | crontab -
(crontab -l 2>/dev/null; echo "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin") | crontab -
(crontab -l 2>/dev/null; echo "0 0 * * * bash /scripts/db-scripts.sh exportAndUpload") | crontab -

crontab -l

service cron start

exit 0