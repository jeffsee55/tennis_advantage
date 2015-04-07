class Coach < ActiveRecord::Base
  attachment :image_1

  default_scope -> { order("created_at ASC") }

  def to_local_list_item
    {
      img: self,
      color: "success-bg",
      icon: "fa-file-text",
      primary: self.name,
      link: Rails.application.routes.url_helpers.edit_admin_coach_path(self),
      link_text: "Edit",
      secondary: nil,
      details: self.updated_at
    }
  end
end
