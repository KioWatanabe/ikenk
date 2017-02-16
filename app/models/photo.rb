class Photo < ActiveRecord::Base
	 mount_uploader :image, ImageUploader
	 belongs_to :user
	 has_many :comments
	 
	 acts_as_taggable_on :labels # post.label_list が追加される
  	acts_as_taggable            # acts_as_taggable_on :tags のエイリアス
  	  Photo.order("created_at DESC")
end
