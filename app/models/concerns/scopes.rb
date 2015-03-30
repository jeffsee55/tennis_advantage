module Scopes
  extend ActiveSupport::Concern

  included do
    scope :past_week, -> { where(updated_at: (Time.now.midnight - 7.days)..Time.now.midnight) }
  end

end
