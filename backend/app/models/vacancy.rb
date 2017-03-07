# frozen_string_literal: true
class Vacancy < ApplicationRecord
  include Publishable

  belongs_to :user
  has_many :vacancy_activities, dependent: :destroy
  has_many :activities, through: :vacancy_activities, source: :activity

  validates :title, presence: true

  class << self
    def vacancies(params, limit)
      query_where = get_filter_condition(params, 'title')

      if query_where.present?
        Vacancy
          .where(query_where, "%#{params[:search]}%")
          .order(:title)
      else
        Vacancy.order(:title).limit(limit)
      end
    end
  end
end
