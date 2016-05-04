[![Build Status](https://travis-ci.org/mrsutter/blog.svg?branch=master)](https://travis-ci.org/mrsutter/blog) [![Coverage Status](https://coveralls.io/repos/github/mrsutter/blog/badge.svg?branch=master)](https://coveralls.io/github/mrsutter/blog?branch=master) [![Code Climate](https://codeclimate.com/github/mrsutter/blog/badges/gpa.svg)](https://codeclimate.com/github/mrsutter/blog)

# Blog

## Heroku

Проект доступен по [ссылке](https://yakspavel-blog.herokuapp.com).

## ElasticSearch

Elasticsearch работает на [Amazon Web Service](https://aws.amazon.com/ru/elasticsearch-service/).

## Уведомления о регистрации

Уведомления о регистрации доставляются до [Mailgun](http://www.mailgun.com/) по HTTP.

## Капча

Сервис использует [Recaptcha](https://www.google.com/recaptcha/) от Google.

## Особенности локального развертывания

Необходимо завести файлик *config/application.yml* ([Figaro](https://github.com/laserlemon/figaro)), в котором нужно указать следующие значения:

  * *smtp_domain*
  * *smtp_user_name*
  * *smtp_password*
  * *smtp_api_url*
  * *recaptcha_public_key*
  * *recaptcha_private_key*