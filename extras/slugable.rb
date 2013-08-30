module Slugable
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.extend ClassMethods
    base.class_eval do
      my_class_method
    end
  end


  module InstanceMethods

  end

  module ClassMethods
    def my_class_method
      puts 'This is a CLASS method'
    end
  end
end