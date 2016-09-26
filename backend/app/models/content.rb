# == Schema Information
#
# Table name: contents
#
#  id            :integer          not null, primary key
#  type          :string
#  title         :string
#  description   :text
#  is_published  :boolean
#  position      :integer
#  story_map_url :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Content < ApplicationRecord
  include Publishable
  validates :title, presence: true
end
