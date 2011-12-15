module Alchemy
	class PicturesSweeper < ActionController::Caching::Sweeper
		observe Alchemy::Picture

		def after_update(picture)
			expire_cache_for(picture)
		end

		def after_destroy(picture)
			expire_cache_for(picture)
		end

	private

		def expire_cache_for(picture)
			# Removing all variants of the picture with FileUtils.
			FileUtils.rm_rf("#{Rails.root}/public/pictures/show/#{picture.id}")
			FileUtils.rm_rf("#{Rails.root}/public/pictures/thumbnails/#{picture.id}")
			expire_page(zoom_picture_path(picture, :format => 'png'))
		end

	end
end