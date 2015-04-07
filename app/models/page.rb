class Page < ActiveRecord::Base
  include Scopes
  scope :alphabetical, -> { order('title ASC') }

  def to_local_list_item
    {
      img: nil,
      color: "success-bg",
      icon: "fa-file-text",
      primary: self.title,
      link: Rails.application.routes.url_helpers.edit_admin_page_path(self),
      link_text: "Edit",
      secondary: nil,
      details: self.updated_at
    }
  end
end
