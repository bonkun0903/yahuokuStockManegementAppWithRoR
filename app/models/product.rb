class Product < ApplicationRecord
  # enum 
  enum shipping_fee_defrayer: [:successful_bidder, :listing_person ]
  enum payment_timing: [:charge_advance_payment, :charge_deferred_payment]
  enum fee: [:t1]
  enum product_status: [:product_status0, :product_status1, :product_status2, :product_status3, :product_status4, :product_status5]
  enum delivery_method: [:fukuyama, :sagawa, :seino]
  enum inventory_status: [:pending, :listing, :successful_bid, :shipped]

  # 自動値下げ率
  AUTOMATIC_PRICE_CUT_VALUES = [0,1,2,3,4,5,10,15,20,25,30]

  # validation
  validates :category, numericality: { only_integer: true }, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :start_price, numericality: { only_integer: true }, presence: true
  validates :count, numericality: { only_integer: true, in: 1..99 }, presence: true
  validates :period, numericality: { only_integer: true, in: 2..7 }, presence: true
  validates :end_time, numericality: { only_integer: true, in: 0..23 }, presence: true
  validates :from_prefecture, numericality: { only_integer: true, in: 1..47 }, presence: true
  validates :shipping_fee_defrayer, numericality: { only_integer: true }, presence: true, inclusion: { in: Product.shipping_fee_defrayers.keys }
  validates :payment_timing, numericality: { only_integer: true }, presence: true, inclusion: { in: Product.payment_timings.keys }
  validates :fee, numericality: { only_integer: true }, presence: true, inclusion: { in: Product.fees.keys }
  validates :product_status, numericality: { only_integer: true }, presence: true, inclusion: { in: Product.product_statuses.keys }
  validates :returnable, inclusion: [true, false]
  # validates :image, presence: true
  validates :automatic_extension, inclusion: [true, false]
  validates :buyout_price, numericality: { only_integer: true }
  validates :automatic_relist, numericality: { only_integer: true, in: 0..3 }
  validates :automatic_price_cut, numericality: { only_integer: true }, inclusion: { in: AUTOMATIC_PRICE_CUT_VALUES }
  validates :delivery_method, numericality: { only_integer: true }, presence: true, inclusion: { in: Product.delivery_methods.keys }
  validates :inventory_status, numericality: { only_integer: true }, inclusion: { in: Product.inventory_statuses.keys }
end