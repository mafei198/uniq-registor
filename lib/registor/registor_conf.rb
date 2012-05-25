class RegistorConf
  class << self
    attr_accessor :redis

    def name_space
      @name_space ||= 'uniq_registor'
    end

    def name_space=(string)
      @name_space = string
    end
  end
end
