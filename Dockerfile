FROM python
MAINTAINER Christos Georgoulis

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y cron

ADD services/eltworker/user_pipeline.sh /user_pipeline.sh
ADD services/eltworker/post_pipeline.sh /post_pipeline.sh
ADD services/eltworker/comment_pipeline.sh /comment_pipeline.sh
ADD services/eltworker/entrypoint.sh /entrypoint.sh
 
RUN chmod +x /user_pipeline.sh /post_pipeline.sh /comment_pipeline.sh /entrypoint.sh

COPY pipelines/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY pipelines .

ENTRYPOINT /entrypoint.sh