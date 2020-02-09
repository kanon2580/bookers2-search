class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # active_reletionshipsは、Relationshipの別名でFKはfollowing_id
  # user:relationshipで1:Nをまず結ぶ
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  # followsは、active_relationshipsを通してfollower(user)のデータを取ってくる
  # user(自分):user(フォロー)で1:Nを結ぶ
  has_many :follows, through: :active_relationships, source: :follower

  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  attachment :profile_image, destroy: false

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}

  def followed_by?(user)
    passive_relationships.where(following_id: user.id).exists?
  end
end
