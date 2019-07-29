class Comment < ApplicationRecord
  belongs_to :users, foreign_key :user_id
end
