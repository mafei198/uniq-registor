uniq-registor
==========
  Redis based unique model id producer and unique name checking tools,
    which can used for multi independent database to avoid conflict of primary-key-value and uniquess-name by use the same redis database.

Desc
-------
  - This gem will add an before_create callback for all of your models.
  - Every new model before create will get an unique id for primary key, so if you don't have an primary key it will raise a error.
  - manual-primary-key: default name is model's class name add the "_id" suffix. eg: user_id

Installation
-----------
  ```
  gem install uniq-registor

  #for rails 3.x.x, add to Gemfile
  gem 'uniq-registor'
  ```
Usage
-----
  edit config/initializers/uniq_registor.rb
  ```
  require 'registor'
  #configure registor
  RegistorConf.redis = Redis.new :host => '127.0.0.1', :port => 6379

  #Optional
  RegistorConf.name_space = 'uniq_registor'
  ```
Example
-------
```
  class User < ActiveRecord::base
    #user_id:integer, username:string
    set_primary_key 'user_id'
  end

  #Auto produce the uniq primary id across multi databases.
  User.create!
  #<User user_id: 24, created_at: "2012-05-25 13:52:21", updated_at: "2012-05-25 13:52:21">

  name = 'andy'

  #regist the unique username, success return true, else return false
  User.regist_uniq_name('username', name)

  #deregist the uniqe username, success return true, else return false
  User.rem_uniq_name('username', name)

  #get model's current max auto increase id
  User.current_uniq_id_value

  #get model's current uniq username amount
  user.uniq_name_count('username')
```
