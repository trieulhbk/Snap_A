require 'open-uri'
class Photo < ActiveRecord::Base
  attr_accessible :box_id, :description, :name, :source, :image, :image_url, :image_remote_url
  attr_accessor :image_url


  validates :name, presence: true
  validates :box_id, presence: true
  validates :source, presence: true

  before_validation :save_source_via_pc, :unless => :image_url_provided?
  before_validation :download_remote_image, :if => :image_url_provided?


  validates_presence_of :image_remote_url, :if => :image_url_provided?, :message => 'is invalid or inaccessible'

  has_attached_file :image, :styles => { :small => "150x150>" },
                    :url  => "/assets/photos/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/photos/:id/:style/:basename.:extension"

  validates_attachment_presence :image, :if => :upload_from_pc?
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']

  has_many :user_photo_actions, foreign_key: "photo_id", 
  dependent: :destroy

  has_many :attaching_users, through: :user_photo_actions, source: :user

  belongs_to :box, dependent:   :destroy

  private

  def upload_from_pc?
    self.image_remote_url.nil?
  end

  def save_source_via_pc
    self.source||=self.image.path
  end

  def image_url_provided?
    !self.image_url.blank?
  end

  def download_remote_image
    self.image_remote_url = image_url
    self.source= self.image_remote_url
  end

  def do_download_remote_image
    io = open(URI.parse(image_url))

    def io.original_filename; base_uri.path.split('/').last; end
    io.original_filename.blank? ? nil : io
  rescue
  end
  
end
