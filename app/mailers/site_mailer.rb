class SiteMailer < ActionMailer::Base
  default from: "info@tennisadvantage.com.au"

  def mandrill_client
    @mandrill_client ||= Mandrill::API.new(ENV["MANDRILL_API_KEY"])
  end

  def new_message(message)
    template_name = "tennis-new-message"
    template_content = []
    message = {
      to: [
        {email: "jeffsee.55@gmail.com"},
      ],
      subject: "New Message from #{ message.name }",
      global_merge_vars: [
        { name: "NAME", content: message.name },
        { name: "EMAIL", content: message.email },
        { name: "BODY", content: "#{message.subject}: #{message.body}" },
        { name: "MESSAGE_URL", content: admin_message_url(message.id) }
      ],
    }

    mandrill_client.messages.send_template template_name, template_content, message
  end

  def new_order(order)
    template_name = "tennis-advantage-new-order"
    template_content = []
    message = {
      to: [
        {email: "jeffsee.55@gmail.com"},
      ],
      subject: "New Order",
      global_merge_vars: [
        { name: "IMAGE", content: "https://s3-ap-southeast-2.amazonaws.com/tennis-advantage-assets/store/gregsons-tennis-banner-logo.png"},
        { name: "ORDER_NO", content: "Order no. ##{ order.id }"},
        { name: "DELIVERY_METHOD", content: order.delivery_method.upcase },
        { name: "ORDER_ITEMS", content: order.line_items.map { |item| "#{item.product.name}, Qty #{item.qty} (#{item.product.price})" }.join("<br>") },
        { name: "ORDER_SHIPPING", content: order.shipping_rate },
        { name: "ORDER_TOTAL", content: order.total },
        { name: "ORDER_LINK", content: admin_order_url(order) }
      ],
    }

    mandrill_client.messages.send_template template_name, template_content, message
  end

  def order_confirmation(order)
    template_name = "tennis-advantage-order-confirmation"
    template_content = []
    message = {
      to: [
        {email: "jeffsee.55@gmail.com"},
      ],
      subject: "Order Confirmation: Tennis Advantage",
      global_merge_vars: [
        { name: "IMAGE", content: "https://s3-ap-southeast-2.amazonaws.com/tennis-advantage-assets/store/gregsons-tennis-banner-logo.png"},
        { name: "ORDER_NO", content: "Order no. ##{ order.id }"},
        { name: "DELIVERY_METHOD", content: order.delivery_method.upcase },
        { name: "DELIVERY_INFO", content: order.delivery_info },
        { name: "ORDER_ITEMS", content: order.line_items.map { |item| "#{item.product.name}, Qty #{item.qty} (#{item.product.price})" }.join("<br>") },
        { name: "ORDER_SHIPPING", content: order.shipping_rate },
        { name: "ORDER_TOTAL", content: order.total }
      ],
    }

    mandrill_client.messages.send_template template_name, template_content, message
  end
  #def post_notification(post)
    #template_name = "new-post"
    #template_content = []
    #message = {
      #to: Subscriber.all.map { |s| { email: "#{s.email}" } },
      #subject: "Realistic Organizer:#{ post.title }",
      #global_merge_vars: [
        #{ name: "TITLE", content: post.title },
        #{ name: "LOGO_IMAGE_URL", content: "https://s3-us-west-2.amazonaws.com/real-org-images/store/#{ Theme.last.logo_image.id }" },
        #{ name: "IMAGE_URL", content: "https://s3-us-west-2.amazonaws.com/real-org-images/store/#{ post.image.id }" },
        #{ name: "POST_URL", content: post_url(post) },
        #{ name: "EXCERPT", content: post.body }
      #],
      #merge_vars:
        #Subscriber.all.map do |subscriber|
          #{
            #rcpt: subscriber.email,
            #vars: [
             #{ name: "UNSUBSCRIBE_URL", content: unsubscribe_url(subscriber.access_token) }
            #]
          #}
        #end
    #}

    #mandrill_client.messages.send_template template_name, template_content, message
  #end
end
