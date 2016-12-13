# == Schema Information
#
# Table name: content_types
#
#  id          :integer          not null, primary key
#  for_content :string           not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ContentType < ApplicationRecord
  has_many :contents

  BOTH = "Activity and Publication"
  ACTIVITY = "Activity"
  PUBLICATION = "Publication"
  FOR_CONTENT = [BOTH, ACTIVITY, PUBLICATION]

  scope :by_publication, -> { where(for_content: ContentType::PUBLICATION).or(ContentType.where(for_content: ContentType::BOTH)) }
  scope :by_activity, -> { where(for_content: ContentType::ACTIVITY).or(ContentType.where(for_content: ContentType::BOTH)) }

  validates :title, presence: true
  validates :for_content, presence: true
  validates :for_content,
    inclusion: { in: FOR_CONTENT, message: "%{value} is not a valid value" }
end