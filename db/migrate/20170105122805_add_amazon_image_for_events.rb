class AddAmazonImageForEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :s_background_image_file_name, :string
    add_column :events, :s_background_image_content_type, :string
    add_column :events, :s_background_image_file_size, :integer
    add_column :events, :s_background_image_updated_at, :datetime
  end
end
