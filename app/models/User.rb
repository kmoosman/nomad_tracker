require_relative 'concerns/slug'

class User < ActiveRecord::Base
    include Slug::InstanceMethods
    extend Slug::ClassMethods
    has_many :locations
    has_secure_password
    validates_uniqueness_of :username
  end
  