class SiteMailer < ActionMailer::Base
  default from: "info@selfiebranch.com"

  def mandrill_client
    @mandrill_client ||= Mandrill::API.new(ENV["MANDRILL_API_KEY"])
  end

  def new_message(message)
    template_name = "new-message"
    template_content = []
    message = {
      to: [
        {email: "jeffsee.55@gmail.com"},
      ],
      subject: "New Message from #{ message.name }",
      global_merge_vars: [
        { name: "NAME", content: message.name },
        { name: "EMAIL", content: message.email },
        { name: "BODY", content: message.body },
        { name: "MESSAGE_URL", content: admin_message_url(message.id) }
      ],
    }

    mandrill_client.messages.send_template template_name, template_content, message
  end

  def new_order(order)
    template_name = "new-order"
    template_content = []
    message = {
      to: [
        {email: "jeffsee.55@gmail.com"},
      ],
      subject: "New Order",
      global_merge_vars: [
        { name: "NAME", content: order.name },
        { name: "EMAIL", content: order.email },
        { name: "BODY", content: order.summary },
        { name: "ORDER_URL", content: admin_order_url(order.id) }
      ],
    }

    mandrill_client.messages.send_template template_name, template_content, message
  end

  def post_notification(post)
    template_name = "new-post"
    template_content = []
    message = {
      to: Subscriber.all.map { |s| { email: "#{s.email}" } },
      subject: "Realistic Organizer:#{ post.title }",
      global_merge_vars: [
        { name: "TITLE", content: post.title },
        { name: "LOGO_IMAGE_URL", content: "https://s3-us-west-2.amazonaws.com/real-org-images/store/#{ Theme.last.logo_image.id }" },
        { name: "IMAGE_URL", content: "https://s3-us-west-2.amazonaws.com/real-org-images/store/#{ post.image.id }" },
        { name: "POST_URL", content: post_url(post) },
        { name: "EXCERPT", content: post.body }
      ],
      merge_vars:
        Subscriber.all.map do |subscriber|
          {
            rcpt: subscriber.email,
            vars: [
             { name: "UNSUBSCRIBE_URL", content: unsubscribe_url(subscriber.access_token) }
            ]
          }
        end
    }

    mandrill_client.messages.send_template template_name, template_content, message
  end
end
