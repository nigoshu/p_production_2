class Post < ApplicationRecord
    validates :content, {presence: true}
    #実験中 validates :user_id, {presence: true}
end
