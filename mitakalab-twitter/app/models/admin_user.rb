class AdminUser < ActiveRecord::Base
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_admin_users, through: :relationships, source: :followed

  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :follower_admin_users, through: :reverse_relationships, source: :follower

  has_many :tweets
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  enum role: {admin: "admin", member: "member"}

  def following?(other_admin_user)
    relationships.find_by(followed_id: other_admin_user.id) != nil
  end
  def follow!(other_admin_user)
    relationships.create!(followed_id: other_admin_user.id)
  end
  def unfollow!(other_admin_user)
    relationships.find_by(followed_id: other_admin_user.id).destroy
  end
  def followedtweet
    _tweets = tweets
    followed_admin_users.each do |f|
      _tweets += f.tweets
    end
    if relationships.exists? then _tweets.sort! end
    return _tweets
  end
end
