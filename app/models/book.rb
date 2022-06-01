class Book < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  belongs_to :user, optional: true

  validates :title, presence:true
  validates :body, presence:true, length:{maximum:200}
  
  #一致するレコードが存在しない＝「まだいいねしていない→createアクションへ」
  #一致するレコードが存在する　＝「すでにいいね済み→destroyアクションへ」
  def favorited?(user)
   favorites.where(user_id: user.id).exists?
  end
end
