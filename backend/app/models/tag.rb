class Tag < ApplicationRecord
  PROGRAMME = "Programme"
  CATEGORIES = ["Activity Area", PROGRAMME, "Region", "Theme"]

  def self.for_content content_type
    query = <<-SQL
      SELECT tags.id, tags.name, COUNT(*) AS taggings_count
      FROM tags
      INNER JOIN taggings ON taggings.tag_id = tags.id
      INNER JOIN contents ON taggable_type = 'Content' AND
        taggable_id = contents.id AND contents.type = '#{content_type}'
      GROUP by tags.id, tags.name
      ORDER BY UPPER(tags.name)
    SQL
    Tag.find_by_sql(query)
  end

  def self.for_media_content
    query = <<-SQL
      SELECT tags.id, tags.name, COUNT(*) AS taggings_count
      FROM tags
      INNER JOIN taggings ON taggings.tag_id = tags.id
      INNER JOIN media_contents ON taggable_type = 'MediaContent' AND
        taggable_id = media_contents.id AND
        (media_contents.type <> 'Photo' OR (media_contents.type = 'Photo' AND media_contents.album_id IS NULL))
      GROUP by tags.id, tags.name
      ORDER BY UPPER(tags.name)
    SQL
    Tag.find_by_sql(query)
  end

  class << self
    def tags(search, limit)
      if search.present? and search != ''
        Tag
          .where("UPPER(name) like UPPER(?)", "%#{search}%")
          .order(:name)
      else
        Tag.order(:name).limit(limit)
      end
    end
  end
end
