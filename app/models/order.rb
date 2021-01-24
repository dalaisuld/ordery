class Order < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :product, optional: true
  enum status: { in_progress: 0, delivery: 1, cancel: 2, finish: 3 }


  def self.search_by(search)
    by_name(search['name'])
  end

  def self.by_name(name)
    if name.present?
      where('name LIKE ?', "%#{name}%")
    else
      all
    end
  end
end
