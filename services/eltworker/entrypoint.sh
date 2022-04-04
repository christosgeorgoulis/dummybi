
#!/bin/bash

# Start the run once job.
echo "Docker container has been started"

# Initial run
echo "Initial run of pipelines"
echo "Populating users"
python users_pipeline.py
echo "Populating posts"
python posts_pipeline.py
echo "Populating comments"
python comments_pipeline.py
echo "From now on, the above ran pipelines, are to be triggered once daily at midnight."

# Setup a cron schedule
echo "0 0 * * * /user_pipeline.sh >> /var/log/cron.log 2>&1
# This extra line makes it a valid cron" > scheduler.txt

echo "5 0 * * * /post_pipeline.sh >> /var/log/cron.log 2>&1
# This extra line makes it a valid cron" > scheduler.txt

echo "10 0 * * * /comment_pipeline.sh >> /var/log/cron.log 2>&1
# This extra line makes it a valid cron" > scheduler.txt

crontab scheduler.txt
cron -f