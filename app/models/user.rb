# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  admin                  :boolean          default(FALSE)
#  uid                    :string           default(""), not null
#  provider               :string           default(""), not null
#  image_url              :string
#  avatar                 :string
#  username               :string
#  secret                 :integer          default(0)
#

class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  has_many :pictures
  # コメントモデルのアソシエーションを設定
  has_many :comments, dependent: :destroy

  # likesモデルのアソシエーション
  has_many :likes, dependent: :destroy
  has_many :like_notes, through: :likes, source: :picture

  # relationshipsとユーザーのアソシエーション
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: 'Relationship', dependent: :destroy

  has_many :followed_users, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships, source: :follower

  # requestテーブルとユーザーのアソシエーションを設定
  has_many :requests, foreign_key: "sender_id", dependent: :destroy
  has_many :reverse_requests, foreign_key: "recipient_id", class_name: 'Request', dependent: :destroy

  has_many :receive_users, through: :requests, source: :sender
  has_many :send_users, through: :reverse_requests, source: :recipient

  scope :or, -> (email, name, username) do
    where("(users.email = ? OR users.name = ? OR users.username = ?)", email, name, username)
  end

  def self.find_for_twitter_oauth(auth, signed_in_resource = nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first

    unless user
      user = User.new(
          username: auth.info.nickname,
          name:     auth.info.nickname,
          image_url: auth.info.image,
          provider: auth.provider,
          uid:      auth.uid,
          email:    auth.info.email ||= "#{auth.uid}-#{auth.provider}@example.com",
          password: Devise.friendly_token[0, 20],
      )
      user.skip_confirmation!
      user.save
    end
    user
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first

    unless user
      user = User.new(
          username:     auth.extra.raw_info.name,
          name:     auth.extra.raw_info.name,
          provider: auth.provider,
          uid:      auth.uid,
          email:    auth.info.email ||= "#{auth.uid}-#{auth.provider}@example.com",
          image_url:   auth.info.image,
          password: Devise.friendly_token[0, 20]
      )
      user.skip_confirmation!
      user.save(validate: false)
    end
    user
  end

  def self.create_unique_string
    SecureRandom.uuid
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  # フォローしているかどうかを判別
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  # フォローされているユーザーかを判別
  def followed?(other_user)
    reverse_relationships.find_by(follower_id: other_user.id)
  end

  # フォローをやめる
  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  def send_request!(to_user)
    requests.create!(recipient_id: to_user.id)
  end

  # リクエストを送ったかユーザーか判別
  def sending?(to_user)
    requests.find_by(recipient_id: to_user.id)
  end

  # リクエストを受け取ったユーザーか判別
  def received?(to_user)
    reverse_requests.find_by(sender_id: to_user.id)
  end

  def unsend(to_user)
    requests.find_by(recipient_id: to_user.id).destroy
  end

end
