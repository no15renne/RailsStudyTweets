class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "AdminUser"
  belongs_to :followed, class_name: "AdminUser"
end
