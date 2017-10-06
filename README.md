# Help me!

[![Code Climate](http://img.shields.io/codeclimate/github/netguru/help.svg)](https://codeclimate.com/github/netguru/help)
[![Code Climate](http://img.shields.io/codeclimate/coverage/github/netguru/help.svg)](https://codeclimate.com/github/netguru/help)
[![Dependencies](http://img.shields.io/gemnasium/netguru/help.svg)](https://gemnasium.com/netguru/help)
[![Circle CI](https://circleci-badges.herokuapp.com/netguru/help/0b87a42d881a82d69dca72d9c0f4cc680f795f62)](https://circleci.com/gh/netguru/help)

This application is a simple, easy to run support system for your team. It's ment to be used internally, to encourage your team members to help each other.

The flow is quite simple:

* we sign in users with google apps
* every user selects the topics, he feels he can help with
* user seeking for help picks the topic from the list and application will randomly assign somebody to help him (from the list of users that marked the topic as their skill)

TL;DR: you select what you can help with or application selects somebody to help you

![main page](https://netguruco-production.s3.amazonaws.com/uploads/1401957129-1400162300-help_main_page.jpg)

## Deploying
This is just a simple rails app, can be easly deployed to heroku under < 5 time mark :)
Once you have your heroku.com account set up, do this:

* Clone the application locally:

  `git clone git://github.com/netguru/help.git help-app && cd help-app`

* create an empty app on heroku, with postgres - replace 'crazysheeps' with your own app name:

  `heroku apps:create crazysheeps --addons heroku-postgresql`

* push the app to heroku, let them do their thing:

  `git push heroku`

* load the database schema

  `heroku run rake db:schema:load`

## Configuration

### Setup database

create user and a role, then copy sample `database.yml` file.

```shell
createuser --superuser --createrole help
cp config/database.yml.sample config/database.yml
```

Once it's deployed it needs few configuration variables to run properly.
Here is the config file for reference: [https://github.com/netguru/help/blob/master/config/config.yml#L18](https://github.com/netguru/help/blob/master/config/config.yml#L18)

* Secret key base - used for encrypting cookies

  `heroku config:set SECRET_KEY_BASE=randomstringwithminimum30characters`

* App domain - the domain the application is aviable under. Like so:

  `heroku config:set APP_DOMAIN=crazysheeps.herokuapp.com`

* Google apps - we assume you use google ouath for authentication.
Go to your [google console](https://cloud.google.com/console/project) to generate oauth client and secret for the project.
In google console set `your_help_app_domain.com/auth/google_oauth2/callback`

* You can use plain google account but we recommend using google apps, to scope login to emails from your organization.
Set values like so:

  ```shell
  heroku config:set GAPPS_ID=google_apps_client_id
  heroku config:set GAPPS_SECRET=google_apps_client_secret
  heroku config:set GAPPS_DOMAIN=google_apps_primary_domain
  ```

* Postmark - if you want the application to send out email notifications on support request you can configure it to use postmark free account. Heroku makes it easy - read more here and follow the instructions: [https://addons.heroku.com/postmark#10k](https://addons.heroku.com/postmark#10k)

  ```shell
  heroku addons:add postmark
  heroku config:set POSTMARK_API_KEY=the_api_token_from_postmark_account
  ```

  Once you do have your postmark account connected with heroku, you can configure a from address with them (or set it to postmark default).
  More here: [http://support.postmarkapp.com/customer/portal/articles/64741-how-can-i-send-on-behalf-of-my-users-](http://support.postmarkapp.com/customer/portal/articles/64741-how-can-i-send-on-behalf-of-my-users-)

  `heroku config:set POSTMARK_FROM=the_address_you_selected@example.com`

* You can also set a cc address for all support emails to scope the conversations under google group, or add notifications with [Zappier](https://zapier.com/zapbook/email/) - we used this to display support activity on hipchat: [https://zapier.com/zapbook/email/hipchat/](https://zapier.com/zapbook/email/hipchat/)

  `heroku config:set DEFAULT_CC=default_cc_address@example.com`

## Setting help subjects

For now we did not yet develop any admin panel for the application. You will have to use heroku console to create your support categories. This is how we set them:

```ruby
> heroku run rails console

irb(main):001:0> Topic.create(title: 'test category', description: 'test description')
=> #<Topic id: 3, title: "test category", description: "test description">
irb(main):002:0> Topic.create(title: 'anoter help subject', description: 'another topic description')
=> #<Topic id: 4, title: "anoter help subject", description: "another topic description">

```
Title have to be present and have minimum 3 characters.
Description have to be present also and have minimum 6 characters.

## Archiving users

In order to archive user, please use the following `rake` task:

```shell
heroku run bin/rake users:archive[foo@example.com] --app=appname
```

If you don't have access ask someone who has. (senior / team leader)

## Read more

Read more about the app & story behind at [Open Source App To Support Your Culture](https://netguru.co/blog/posts/open-source-app-to-support-your-culture).

Here a bit about the [app's redesign & enhancing user experience](https://netguru.co/blog/posts/redesign-this-is-what-we-did-to-make-our-open-source-app-work-and-look-slick).

Copyright (c) 2014 [Netguru](https://netguru.co). See LICENSE for further details.
# climates
# climates
