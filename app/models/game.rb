class Game < ActiveRecord::Base
  has_many :user_games
  has_many :users, :through => :user_games
  belongs_to :creator, foreign_key: :user_id, class_name: :User

  validates :name, uniqueness: true, presence: true
  validates :user_id, presence: true
end