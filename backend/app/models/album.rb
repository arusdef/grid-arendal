# == Schema Information
#
# Table name: media_contents
#
#  id                  :integer          not null, primary key
#  external_id         :string
#  external_url        :string
#  type                :string
#  author              :string
#  licence             :string
#  publication_date    :date
#  description         :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  title               :string
#  album_id            :integer
#  external_updated_at :datetime
#  is_featured         :boolean
#  eps_id              :integer
#  pdf_id              :integer
#
# Indexes
#
#  index_media_contents_on_album_id                              (album_id)
#  index_media_contents_on_to_tsvector_title_description_author  ((((setweight(to_tsvector('simple'::regconfig, COALESCE((title)::text, ''::text)), 'A'::"char") || setweight(to_tsvector('simple'::regconfig, COALESCE(description, ''::text)), 'B'::"char")) || setweight(to_tsvector('simple'::regconfig, COALESCE((author)::text, ''::text)), 'B'::"char"))))
#
# Foreign Keys
#
#  fk_rails_03d0073c72  (pdf_id => media_attachments.id)
#  fk_rails_b2d6cb67fb  (eps_id => media_attachments.id)
#  fk_rails_cb9ba8e413  (album_id => media_contents.id)
#

class Album < MediaContent
  include FlickrSync
  has_many :photos, dependent: :destroy, foreign_key: :album_id
  alias_attribute :items, :photos

  class << self
    def albums(params, limit)
      query_where = get_filter_condition(params, 'title')

      if query_where.present?
        Album
          .where(query_where, "%#{params[:search]}%")
          .order(publication_date: :desc)
      else
        Album.order(publication_date: :desc).limit(limit)
      end
    end
  end
end
