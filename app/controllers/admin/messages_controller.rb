class Admin::MessagesController < AdminController
  def index
    @messages = Message.all.page params[:page]
  end

  def show
    @message = Message.find(params[:id])
  end

  def destroy
    @message = Message.find(params[:id])
    @message.delete
    redirect_to admin_messages_path, alert: "Message was successfully deleted."
  end
end
