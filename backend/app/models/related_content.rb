# frozen_string_literal: true
class RelatedContent < ApplicationRecord
  belongs_to :activity
  belongs_to :publication
end
