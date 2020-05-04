# == Schema Information
#
# Table name: post_subs
#
#  id         :bigint           not null, primary key
#  sub_id     :integer          not null
#  post_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PostSub < ApplicationRecord
# https://medium.com/@pk60905/many-to-many-relationship-in-rails-cf86e12db8b0

    belongs_to :post

    belongs_to :sub
end
