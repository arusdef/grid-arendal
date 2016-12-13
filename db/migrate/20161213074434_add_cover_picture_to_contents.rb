class AddCoverPictureToContents < ActiveRecord::Migration[5.0]
  def change
    add_column :contents, :cover_picture_file_name, :string
    add_column :contents, :cover_picture_content_type, :string
    add_column :contents, :cover_picture_file_size, :integer
    add_column :contents, :cover_picture_update_at, :datetime
  end
end
