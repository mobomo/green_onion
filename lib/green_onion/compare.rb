require "oily_png"

module GreenOnion
	class Compare

		attr_accessor :percentage_changed, :total_px, :changed_px
		attr_reader :diffed_image

		# Pulled from Jeff Kreeftmeijer's post here: http://jeffkreeftmeijer.com/2011/comparing-images-and-creating-image-diffs/
		# Thanks Jeff!
		def diff_images(org, fresh)
			@images = [
				ChunkyPNG::Image.from_file(org),
				ChunkyPNG::Image.from_file(fresh)
			]

			@diff = []

			@images.first.height.times do |y|
				@images.first.row(y).each_with_index do |pixel, x|
					@diff << [x,y] unless pixel == @images.last[x,y]
				end
			end
		end

		def percentage_diff(org, fresh)
			diff_images(org, fresh)
			self.total_px = @images.first.pixels.length
			self.changed_px = @diff.length
			self.percentage_changed = (@diff.length.to_f / @images.first.pixels.length) * 100

			puts "pixels (total):     #{@total_px}"
			puts "pixels changed:     #{@changed_px}"
			puts "pixels changed (%): #{@percentage_changed}%"
		end

		def visual_diff(org, fresh)
			diff_images(org, fresh)
			x, y = @diff.map{ |xy| xy[0] }, @diff.map{ |xy| xy[1] }

			@diffed_image = org.insert(-5, '_diff')

			begin
				@images.last.rect(x.min, y.min, x.max, y.max, ChunkyPNG::Color.rgb(0,255,0))
			rescue NoMethodError
				puts "#{org} and #{fresh} skins are the same."
			end
			
			@images.last.save(@diffed_image)
		end

	end
end