class Order < ActiveRecord::Base
  has_many :line_items
  has_many :events, class_name: "OrderEvent"

  monetize :sub_total
  monetize :tax
  monetize :shipping_rate
  monetize :total

  include Scopes

  attr_accessor :weight, :length, :width, :height

  STATES = %w[initialized pending purchased shipped delivered]
  OHIO_SALES_TAX_RATE = 0.0575
  COMPANY_ADDRESS = {
        name: "Company",
        street1: '164 Townsend Street',
        street2: 'Unit 1',
        city: 'San Francisco',
        state: 'CA',
        zip: '94107'
      }
  delegate :initialized?, :pending?, :purchased?, :shipped?, :delivered?, to: :current_state

  def current_state
    (events.last.try(:state) || STATES.first).inquiry
  end

  def prepare_order(order, stripe_token, line_items )
    self.stripe_customer_id = Stripe::Customer.create(
      email: order[:email],
      source: stripe_token
    ).id
    puts "Stripe created"
    self.attributes= line_items.dimensions_and_weight
    shipment = EasyPost::Shipment.create(
      to_address: self.full_address,
      from_address: COMPANY_ADDRESS,
      parcel: self.dimensions_and_weight
    )
    shipment.to_address.verify
    puts shipment.to_address
    self.shipment_id = shipment.id

    puts "EasyPost created"

    self.save
    puts "Order saved"

    events.create! state: "pending"
    puts "Order Event saved"
  end

  def purchase
    self.charge_id = Stripe::Charge.create(
      amount: self.total_cents,
      currency: "usd",
      customer: self.stripe_customer_id,
      metadata: {
        order_id: self.id,
        sub_total: self.sub_total,
        tax: self.tax,
        shipping_rate:self.shipping_rate
      }
    ).id
    self.save

    events.create! state: "purchased"
  end

  def ship
    shipment = EasyPost::Shipment.retrieve(shipment_id)
    shipment.buy(rate: shipment.lowest_rate)
    events.create! state: "shipped"
  end

  def deliver
    events.create! state: "delivered"
  end

  def customer
    Stripe::Customer.retrieve(self.stripe_customer_id) if self.customer_id
  end

  def shipment
    EasyPost::Shipment.retrieve(self.shipment_id) if self.shipment_id
  end

  def charge
    Stripe::Charge.retrieve(self.charge_id) if self.charge_id
  end

  def tax
    self.sub_total * OHIO_SALES_TAX_RATE
  end

  def shipping_rate
    self.shipment.lowest_rate.rate.to_money
  end

  def sub_total
    sum = 0
    line_items.collect do |item|
      sum += item.total
    end
    return sum
  end

  def total
    return self.sub_total + self.tax + self.shipping_rate
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
      zip: zip || "29617"
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

  def recalculate_shipping(order)
    self.weight = order[:weight]
    self.length = order[:length]
    self.width = order[:width]
    self.height = order[:height]
    self.shipment_id = EasyPost::Shipment.create(
      to_address: self.full_address,
      from_address: COMPANY_ADDRESS,
      parcel: {
        weight: order[:weight],
        length: order[:length],
        width: order[:width],
        height: order[:height]
      }
    ).id
    self.save
  end

  def color
    if current_state == "purchased"
      return "warning-bg"
    end
    if current_state == "shipped"
      return "success-bg"
    end
    if current_state == "delivered"
      return "success-bg"
    end
  end

  def send_email
    SiteMailer.new_order(self)
  end

  def icon
    if current_state == "purchased"
      return "fa-usd"
    end
    if current_state == "shipped"
      return "fa-truck"
    end
    if current_state == "delivered"
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
      details: self.events.last.created_at
    }
  end
end

