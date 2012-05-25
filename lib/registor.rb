ROOT = File.expand_path(File.dirname(__FILE__))
require File.join(ROOT, 'registor', 'registor_callbacks')
require File.join(ROOT, 'registor', 'registor_conf')

ActiveRecord::Base.class_eval do
  include RegistorCallbacks
end
