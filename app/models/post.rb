class Post < ApplicationRecord
    validates :content, {presence: true}
    validates :user_id, {presence: true}  #←投稿とユーザーを紐付けするためバリデート
    
    def user
        return User.find_by(id: self.user_id)
    end
    
end
