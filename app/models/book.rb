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
