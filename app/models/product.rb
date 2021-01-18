class Product < ApplicationRecord
  def self.search_by(search)
    by_category(search['category_id'])
      .by_user(search['user_id'])
      .by_name(search['name'])
  end

  def self.by_category(category)
    if category.present?
      where(category_id: category)
    else
      all
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
      where(name: name)
    else
      all
    end
  end
end
