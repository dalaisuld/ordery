class Order < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :product, optional: true
  enum status: { in_progress: 0, delivery: 1, cancel: 2, finish: 3 }
end
