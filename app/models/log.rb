class Log < ApplicationRecord
  def self.search_by(search)
    # by_description(search['description'])
    by_description(search['description']).by_created_at(search['created_at'])
  end

  def self.by_description(description)
    if description.present?
      where('description LIKE ?', "%#{description}%").order("created_at asc")
    else
      all.order("created_at desc")
    end
  end

  def self.by_created_at(created_at)
    if created_at.present?
      where('created_at LIKE ?', "%#{created_at}%").order("created_at asc")
    else
      all.order("created_at asc")
    end
  end
end