class Book < ApplicationRecord
  #いいね用アソシエーション
  has_many :favorites, dependent: :destroy
  #いいね数並べ替えアソシエーション
  has_many :favorited_users, through: :favorites, source: :user
  #コメント用アソシエーション
  has_many :book_comments, dependent: :destroy
  #閲覧数カウント
  has_many :view_counts, dependent: :destroy
  
  belongs_to :user, optional: true
  
  #閲覧数カウント機能用
  is_impressionable counter_cache: true
  
  validates :title, presence:true
  validates :body, presence:true, length:{maximum:200}
  
  #一致するレコードが存在しない＝「まだいいねしていない→createアクションへ」
  #一致するレコードが存在する　＝「すでにいいね済み→destroyアクションへ」
  def favorited?(user)
   favorites.where(user_id: user.id).exists?
  end
  
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end
end
