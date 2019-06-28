class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: {maximum: 50}
  validates :password, presence: true, length: {minimum: 6}
  validate  :picture_size

  mount_uploader :picture, PictureUploader

  before_save { email.downcase! }
  has_secure_password

  # ====================自分がフォローしているユーザーとの関連 ===================================
  #フォローする側のUserから見て、フォローされる側のUserを(中間テーブルを介して)集める。なので親はfollowing_id(フォローする側)
  has_many :active_relationships, class_name: "Relationship", foreign_key: :follower_id
  # 中間テーブルを介して「follower」モデルのUser(フォローされた側)を集めることを「followings」と定義
  has_many :following, through: :active_relationships, source: :followed
  # ========================================================================================

    # ====================自分がフォローされるユーザーとの関連 ===================================
  #フォローされる側のUserから見て、フォローしてくる側のUserを(中間テーブルを介して)集める。なので親はfollower_id(フォローされる側)
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :followed_id
  # 中間テーブルを介して「following」モデルのUser(フォローする側)を集めることを「followers」と定義
  has_many :follower, through: :passive_relationships, source: :follower
  # =======================================================================================

  has_many :lessons
  has_many :categories, through: :lessons
  has_many :activities
  has_many :answers, through: :lessons

    # ユーザーをフォローする
    def follow(other_user)
      following << other_user
    end
  
    # ユーザーをフォロー解除する
    def unfollow(other_user)
      active_relationships.find_by(followed_id: other_user.id).destroy
    end
  
    # 現在のユーザーがフォローしてたらtrueを返す
    def following?(other_user)
      following.include?(other_user)
    end

    #フィードデータを取り込む
    def feed 
      following_ids = "SELECT followed_id FROM relationships
                      WHERE follower_id = :user_id"
      Activity.where("user_id IN (#{following_ids}) 
                      OR user_id = :user_id", user_id: id)
    end

    private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
