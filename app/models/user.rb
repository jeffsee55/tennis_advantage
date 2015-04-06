class User < ActiveRecord::Base
  include Clearance::User

  attachment :image_1

  def to_local_list_item
    {
      img: self,
      color: "success-bg",
      icon: "fa-file-text",
      primary: self.name,
      link: Rails.application.routes.url_helpers.edit_admin_user_path(self),
      link_text: "Edit",
      secondary: nil,
      details: self.updated_at
    }
  end
end
