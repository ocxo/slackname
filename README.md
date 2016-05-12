#slackname

It's like a last name but with :sparkles:

## Why?

🙃

## How?

Get a Slack token or use your [test Slack token](https://api.slack.com/docs/oauth-test-tokens).

Get your Slack User ID:

`curl -s 'https://slack.com/api/auth.test?token=your_token_here' | jq .user_id`

Create an `.env` file and replace with your own Slack token, user ID, and your last name. For example:

```
SLACK_TOKEN=xoxp-xxxxxxxxxx-xxxxxxxxxx-xxxxxxxxxxx-xxxxxxxxxx
SLACK_USER=U12345678
SLACK_LAST_NAME_PREFIX=Ochonicki
```

Run `ruby slackname.rb`

You should end up with a Slack name that looks like:

![](slackname.png)

😎

## Moar

Manually running this just not your style? Need a new emoji every hour? Got it.

Run it on a cron.

Add this to your `~/.bashrc` so cron doesn't 😧 about your use of emoji chars:

```
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
```

Add this to your crontab with `crontab -e` to run it hourly, 9-5, M-F:

```
SHELL=/bin/bash
BASH_ENV="~/.bashrc"
0 9-17 * * 1-5 cd /path/to/slackname && /path/to/bundle exec ruby slackname.rb > /dev/null
```
