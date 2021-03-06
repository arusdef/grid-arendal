# frozen_string_literal: true
FactoryGirl.define do
  factory :publication do
    title 'My first publication'
    description "It's about life itself"
    is_published true
    is_featured true
    status "Completed"
  end
end
