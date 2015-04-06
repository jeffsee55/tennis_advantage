class SlideImage < ActiveRecord::Base
  attachment :image

  def self.random_slide
    random_index = rand(0..(self.ids.length - 1))
    find(self.ids[random_index])
  end
end
