class Status < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: :User
  belongs_to :parent_status, class_name: :Status, foreign_key: 'retweet_id'

  validates :creator, presence: true
  validates :body, presence: true, length: {minimum: 5}

  after_save :extract_mentions

  def extract_mentions
    mentions = self.body.scan(/@(\w+)/)

    unless mentions.empty?
      mentions.flatten.each do |name|
        user = User.find_by username: name
        Mention.create(user: user, status_id: self.id) if user
      end
    end
  end

end
