class Order < ActiveRecord::Base
  has_many :line_items
  has_many :events, class_name: "OrderEvent"

  register_currency :aud
  monetize :sub_total, :with_model_currency => :aud
  monetize :shipping_rate, :with_model_currency => :aud
  monetize :total, :with_model_currency => :aud

  include Scopes
  default_scope -> { order('created_at DESC') }

  attr_accessor :weight, :length, :width, :height

  SHIPPING_RATE = 10.to_money
  STATES = %w[initialized pending purchased shipped completed]
  COMPANY_ADDRESS = {
        name: "Gregson's Tennis Advantage",
        street1: '11 Parkwood Pl',
        city: 'Sydney',
        state: 'NSW',
        zip: '2151',
        country: 'Australia'
      }
  delegate :initialized?, :pending?, :purchased?, :shipped?, :completed?, to: :current_state

  def current_state
    (events.last.try(:state) || STATES.first).inquiry
  end

  def prepare_order(order, stripe_token, line_items )
    self.stripe_customer_id = Stripe::Customer.create(
      email: order[:email],
      source: stripe_token
    ).id
    self.attributes= line_items.dimensions_and_weight
    #unless self.hand_deliver?
      #shipment = EasyPost::Shipment.create(
        #to_address: self.full_address,
        #from_address: COMPANY_ADDRESS,
        #parcel: self.dimensions_and_weight
      #)
      #self.shipment_id = shipment.id
    #end
    self.save
    events.create! state: "pending"
  end

  def purchase
    self.charge_id = Stripe::Charge.create(
      amount: self.total_cents,
      currency: "aud",
      customer: self.stripe_customer_id,
      metadata: {
        order_id: self.id,
        sub_total: self.sub_total,
        shipping_rate:self.shipping_rate
      }
    ).id
    self.save
    SiteMailer.new_order(self)
    SiteMailer.order_confirmation(self)

    if self.hand_deliver?
      events.create! state: "completed"
    else
      events.create! state: "purchased"
    end
  end

  def ship
    events.create! state: "shipped"
  end

  def deliver
    events.create! state: "completed"
  end

  def customer
    Stripe::Customer.retrieve(self.stripe_customer_id) if self.stripe_customer_id
  end

  def card
    if charge_id
      charge.source
    else
      customer.sources.first
    end
  end

  #def shipment
    #EasyPost::Shipment.retrieve(self.shipment_id) if self.shipment_id
  #end

  def charge
    Stripe::Charge.retrieve(self.charge_id) if self.charge_id
  end

  def shipping_rate
    if hand_deliver?
      return 0
    else
      SHIPPING_RATE
    end
  end

  def sub_total
    sum = 0
    line_items.collect do |item|
      sum += item.total
    end
    return sum
  end

  def total
    return self.sub_total + self.shipping_rate
  end

  def total_cents
    ( total.to_f * 100 ).to_i
  end

  def full_address
    {
      name: name || "Other User",
      street1: street1 || "421 Duncan Chapel Rd",
      street2: street2 || "136",
      city: city || "Greenville",
      state: state || "SC",
      zip: zip || "29617",
      counry: country || "US"
    }
  end

  def dimensions_and_weight
    {
      weight: self.weight,
      height: self.height,
      length: self.length,
      width: self.width
    }
  end

  #def recalculate_shipping(order)
    #self.weight = order[:weight]
    #self.length = order[:length]
    #self.width = order[:width]
    #self.height = order[:height]
    #self.shipment_id = EasyPost::Shipment.create(
      #to_address: self.full_address,
      #from_address: COMPANY_ADDRESS,
      #parcel: {
        #weight: order[:weight],
        #length: order[:length],
        #width: order[:width],
        #height: order[:height]
      #}
    #).id
    #self.save
  #end

  def color
    if current_state == "purchased"
      return "warning-bg"
    end
    if current_state == "shipped"
      return "success-bg"
    end
    if current_state == "completed"
      return "success-bg"
    end
  end

  def send_email
    SiteMailer.new_order(self)
  end

  def delivery_method
    if self.hand_deliver?
      "Delivery method: Hand Deliver"
    else
      "Delivery method: Shipment"
    end
  end

  def delivery_info
    if hand_deliver?
      "We will be in touch shortly with arrangements for hand delivery."
    else
      "You should receive your shipment in 7 to 10 business days. If you have not received it after 10 days, please contact us at sg370@bigpond.com.au"
    end
  end

  def icon
    if current_state == "purchased"
      return "fa-usd"
    end
    if current_state == "shipped"
      return "fa-truck"
    end
    if current_state == "completed"
      return "fa-check"
    end
  end

  def to_local_list_item
    {
      img: nil,
      color: self.color,
      icon: self.icon,
      primary: "Order ##{ self.id}",
      link: Rails.application.routes.url_helpers.admin_order_path(self),
      link_text: "View Order",
      secondary: self.current_state.capitalize,
      details: self.delivery_method
    }
  end

  def to_public_local_list_item
    {
      img: nil,
      color: self.color,
      icon: 'fa-check',
      primary: "Order ##{ self.id}",
      link: "javascript:void(0)",
      link_text: "$#{self.total}",
      secondary: "Status: #{self.current_state.capitalize}",
      details: self.delivery_method
    }
  end
end

