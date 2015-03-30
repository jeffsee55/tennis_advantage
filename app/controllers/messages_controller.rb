class MessagesController < ApplicationController
  CONTACT_EMAIL = "jeffsee.55@gmail.com"

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to :back, notice: "Thank you for reaching out, we'll be in touch shortly"
    else
      redirect_to :back, alert: "There was a problem, please email us at #{CONTACT_EMAIL}"
    end
  end

  private

    def message_params
      params.require(:message).permit(:name, :email, :body)
    end
end
