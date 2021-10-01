class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { minimum: 2, maximum: 20}, uniqueness: { case_sensitive: false }
  validates :introduction, length: { maximum: 50 }

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # フォローの動き
  # フォローを取得。Relationshiopモデルのfollower_idにuser_idを格納
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id",dependent: :destroy
  # following_userという変数にfollowerを通じて、相手のfollowedを確認して取得
  has_many :following_user, through: :follower, source: :followed

  # フォローワーの動き
  # フォローを取得。Relationshiopモデルのfollowed_idにuser_idを格納
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id",dependent: :destroy
  # follower_userという変数にfollowedを通じて、相手のfollowerを確認して取得
  has_many :follower_user, through: :followed, source: :follower
  
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  
  def following?(user)
    follower_user.include?(user)
  end
  

  attachment :profile_image

end
