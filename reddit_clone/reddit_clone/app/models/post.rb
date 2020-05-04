# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  sub_id     :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Post < ApplicationRecord

    validates :title, presence: true
    
    has_many :post_subs,
    inverse_of: :post 

    has_many :subs,
    through: :post_subs,
    source: :sub

    belongs_to :author,
    class_name: :User,
    foreign_key: :user_id

    has_many :comments,
    class_name: :Comment,
    foreign_key: :post_id

    def comments_by_parent_id
        hash = Hash.new { |h, k| h[k] = [] }
        post.comments.each do |comment|
            hash[comment.parent_comment_id] << comment
        end
        hash
    end
end
