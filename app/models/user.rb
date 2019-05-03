class User < ActiveRecord::Base
  validates_presence_of :firstname, :lastname, :email, :password, on: :create
  validates :email, uniqueness: true
  has_secure_password

  enum role: [:guest, :normal ,:moderator, :admin]
  enum approval: [:declined, :waiting, :approved]

  has_many :user_games
  has_many :games, :through => :user_games
  has_many :created_games, foreign_key: :user_id, class_name: :Game


  def approved?
    approval == "approved"
  end

  def cleaned
    OpenStruct.new(
      :firstname => firstname,
      :lastname => lastname,
      :email => email,
      :role => role,
      :id => id
    )
  end

  def self.null_user
    OpenStruct.new(
      :firstname => false,
      :lastname => false,
      :email => false,
      :role => :guest,
      :id => -1
    )
  end
end