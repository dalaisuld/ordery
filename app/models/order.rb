class Order < ApplicationRecord
  belongs_to :products, optional: true
  enum status: { in_progress: 0, delivery: 1, cancel: 2, finish: 3 }
end
