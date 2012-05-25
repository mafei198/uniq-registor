module RegistorCallbacks
  def self.included(base)
    base.extend         ClassMethods
    base.class_eval do
      before_create :set_primary_key_value
    end
    base.send :include, InstanceMethods
  end # self.included

  module ClassMethods
    def regist_uniq_id
      RegistorConf.redis.incr("#{RegistorConf.name_space}:#{self.name}:uniq_id")
    end

    def current_uniq_id_value
      RegistorConf.redis.get("#{RegistorConf.name_space}:#{self.name}:uniq_id")
    end

    def regist_uniq_name(field_name, name)
      RegistorConf.redis.sadd "#{RegistorConf.name_space}:#{self.name}:#{field_name}", name
    end

    def uniq_name_count(field_name)
      RegistorConf.redis.scard "#{RegistorConf.name_space}:#{self.name}:#{field_name}"
    end

    def rem_uniq_name(field_name, name)
      RegistorConf.redis.srem "#{RegistorConf.name_space}:#{self.name}:#{field_name}", name
    end

  end # ClassMethods

  module InstanceMethods
    private
    def set_primary_key_value
      self.send "#{self.primary_key}=", self.class.regist_uniq_id
    end
  end # InstanceMethods
end
