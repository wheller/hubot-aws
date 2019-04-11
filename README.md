hubot-aws
==============

This repo contains the docker image and starter scripts for hubot based upon an Amazon linux docker image [docker](https://docker.io) image with s3 brain.

# Automated build

```
docker pull phirephly/hubot-aws
```

# Image details

1. Based on [amazonlinux](https://hub.docker.com/_/amazonlinux)
2. Defaults to Slack adapter but can be overridden with '--adapter otheradapter'
3. Supply HUBOT_SLACK_TOKEN environment variable (assuming Slack) and scripts volume
4. Uses package.json and package-lock.json in current directory to install hubot scripts

# Slack Usage

Add the Hubot Slack app to your Slack account to obtain a token.  [https://slack.com/apps/A0F7XDU93-hubot](Hubot Slack App)

# Start hubot with your [scripts](https://github.com/github/hubot/blob/master/docs/scripting.md)
```
sudo docker run -d --name "hubot" -e HUBOT_SLACK_TOKEN=MY_HUBOT_SLACK_TOKEN -v /local/path/to/hubot/scripts:/home/hubot/scripts phirephly/hubot-aws:latest
```

# Start hubot with alternate adapter (additional appropriate connection environemnt variables will probably be required)
```
sudo docker run -d --name "hubot" -v /local/path/to/hubot/scripts:/home/hubot/scripts phirephly/hubot-aws:latest --adapter my_other_adapeter
```

# Environment variables with defaults

```
HUBOT_SLACK_TOKEN - Your hubot slack token, required for slack
ENV HUBOT_S3_BRAIN_BUCKET - Required
ENV AWS_ACCESS_KEY_ID - Required
ENV AWS_SECRET_ACCESS_KEY - Required

ENV HUBOT_NAME - myhubot
ENV HUBOT_OWNER - unspecified
ENV HUBOT_DESCRIPTION - 'Hubot Docker'
ENV HUBOT_S3_BRAIN_FILE_PATH : 'hubot-docker-brain/'
ENV HUBOT_S3_BRAIN_SAVE_INTERVAL 6000

```

# Volumes
```
/etc/hubot/scripts
```
