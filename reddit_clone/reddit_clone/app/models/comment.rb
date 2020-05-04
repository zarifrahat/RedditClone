# == Schema Information
#
# Table name: comments
#
#  id                :bigint           not null, primary key
#  content           :text             not null
#  user_id           :integer          not null
#  post_id           :integer          not null
#  parent_comment_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Comment < ApplicationRecord
    validates :user_id, :post_id, :content, presence: true

    belongs_to :post,
        class_name: :Post,
        foreign_key: :post_id

    belongs_to :author,
        class_name: :User, 
        foreign_key: :user_id

    belongs_to :parent_comment,
        class_name: :Comment,
        foreign_key: :parent_comment_id,
        optional: true

    has_many :child_comments,
        class_name: :Comment,
        foreign_key: :parent_comment_id,
        optional: true
end
