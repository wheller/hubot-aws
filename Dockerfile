
FROM amazonlinux
MAINTAINER Bill Heller

ENV HUBOT_SLACK_TOKEN please-specify-via-docker-run-env-variable
ENV HUBOT_NAME myhubot
ENV HUBOT_OWNER unspecified
ENV HUBOT_DESCRIPTION 'Hubot Docker'
ENV HUBOT_S3_BRAIN_BUCKET myhubotbucket
ENV HUBOT_S3_BRAIN_FILE_PATH 'hubot-docker-brain/'
ENV HUBOT_S3_BRAIN_SAVE_INTERVAL 6000
ENV AWS_ACCESS_KEY_ID 'for s3 brain'
ENV AWS_SECRET_ACCESS_KEY 'for s3 brain'

RUN yum -y update
RUN yum -y install expect redis-tools gcc-c++ make mlocate

RUN updatedb
RUN locate useradd

RUN /usr/sbin/useradd -d /home/hubot -m -s /bin/bash -U hubot

ADD nodejs_yum_repo.sh /home/hubot
ADD package.json /home/hubot
ADD package-lock.json /home/hubot
ADD hubot-scripts.json /home/hubot
ADD external-scripts.json /home/hubot

RUN chown -R hubot /home/hubot
RUN chmod +x /home/hubot/nodejs_yum_repo.sh
RUN /home/hubot/nodejs_yum_repo.sh

VOLUME ["/home/hubot/scripts"]

RUN yum -y install nodejs

RUN npm install -g coffeescript
RUN npm install -g yo generator-hubot

USER hubot
WORKDIR /home/hubot

RUN yo hubot --owner="${HUBOT_OWNER}" --name="${HUBOT_NAME}" --description="${HUBOT_DESCRIPTION}" --defaults
RUN npm ci

ENTRYPOINT ["/bin/bash", "-c", "bin/hubot $@", "--"]
CMD ["--adapter slack"]
