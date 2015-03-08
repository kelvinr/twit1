class User < ActiveRecord::Base
  has_many :statuses
  has_many :mentions
  has_many :unread_mentions, -> (obj) {where('viewed_at is NULL')}, class_name: :Mention, foreign_key: :user_id

  has_many :following_users, class_name: :Relationship, foreign_key: :leader_id
  has_many :followed_users, class_name: :Relationship, foreign_key: :follower_id

  has_many :followers, through: :following_users, source: :follower
  has_many :following, through: :followed_users, source: :leader

  validates :username, presence: true
  validates :email , presence: true
  validates :password, presence: true, length: {minimum: 5}

  has_secure_password

  def mark_unread_mentions!
    unread_mentions.each do |mention|
      mention.mark_viewed!
    end
  end
end
