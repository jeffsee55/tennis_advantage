class Message < ActiveRecord::Base
  include ActionView::Helpers
  include Scopes

  def truncated_body
    truncate( self.body, length: 60 )
  end

  def to_local_list_item
    {
      img: nil,
      color: "warning-bg",
      icon: "fa-envelope",
      primary: "From #{self.name}",
      link: Rails.application.routes.url_helpers.admin_message_path(self),
      link_text: "View Message",
      secondary: self.truncated_body,
      details: self.email,
    }
  end
end
