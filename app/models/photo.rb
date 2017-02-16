class Photo < ActiveRecord::Base
	 mount_uploader :image, ImageUploader
	 belongs_to :user
	 has_many :comments

	 is_impressionable
	 
	acts_as_taggable_on :labels # post.label_list が追加される
  	acts_as_taggable            # acts_as_taggable_on :tags のエイリアス
end
