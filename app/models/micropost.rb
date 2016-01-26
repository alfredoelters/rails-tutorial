include Twitter::Extractor

class Micropost < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size
  before_save :extract_tags

  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end

    # Extracts tags from content and insert them in the database
    # if they don't exist already
    def extract_tags
      extract_hashtags(content) do |tag|
        extracted_tag = Tag.find_or_create_by(name: tag.downcase)
        self.tags << extracted_tag unless tags.include? extracted_tag
      end
    end
end
