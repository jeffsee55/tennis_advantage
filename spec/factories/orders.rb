FactoryGirl.define do
  factory :order do
    total 1.5
stripe_customer_id "MyString"
state "MyString"
city "MyString"
zip "MyString"
street1 "MyString"
street2 "MyString"
shipment_id "MyString"
name "MyString"
charge_id "MyString"
  end

end
