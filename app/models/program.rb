class Program < ActiveRecord::Base
  attachment :image_1
  include Scopes
  scope :by_category, -> { order('category DESC') }

  CATEGORIES = ["ANZ Hotshots", "Competitions", "Lessons"]

  def color
    if self.category == "Competitions"
      "primary-bg"
    elsif self.category == "Lessons"
      "success-bg"
    elsif self.name == "Red Ball"
      "danger-bg"
    elsif self.name == "Orange Ball"
      "orange-bg"
    elsif self.name == "Green Ball"
      "success-bg"
    end
  end

  def to_local_list_item
    {
      img: nil,
      color: self.color,
      icon: "fa-trophy",
      primary: self.name,
      link: Rails.application.routes.url_helpers.edit_admin_program_path(self),
      link_text: "Edit",
      secondary: self.description.html_safe,
      details: self.category
    }
  end

  def to_public_local_list_item
    {
      img: nil,
      color: self.color,
      icon: "fa-trophy",
      primary: self.name,
      link: Rails.application.routes.url_helpers.contact_path(subject: self.name),
      link_text: "Inquire",
      secondary: self.description.html_safe,
      details: self.category
    }
  end
end
