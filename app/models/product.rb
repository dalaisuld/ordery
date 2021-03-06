class Product < ApplicationRecord
  belongs_to :category, optional: true
  has_many :order
  def self.search_by(search)
    by_category(search['category_id'])
      .by_user(search['user_id'])
      .by_name(search['name'])
  end

  def self.by_category(category)
    if category == "0" || !category.present?
      all
    else
      where(category_id: category)
    end
  end

  def self.by_user(user)
    if user.present?
      where(user_id: user)
    else
      all
    end
  end

  def self.by_name(name)
    if name.present?
      where('name LIKE ?', "%#{name}%")
    else
      all
    end
  end
end
