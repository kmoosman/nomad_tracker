require_relative 'concerns/slug'

class User < ActiveRecord::Base
    include Slug::InstanceMethods
    extend Slug::ClassMethods
    has_many :destinations
    has_secure_password
  end
  