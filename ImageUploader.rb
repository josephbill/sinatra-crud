
# Define the ImageUploader for CarrierWave
class ImageUploader < CarrierWave::Uploader::Base
  storage :file
  def store_dir
    'public/uploads/'
  end
  version :thumb do
    process resize_to_fit: [200, 200]
  end
end