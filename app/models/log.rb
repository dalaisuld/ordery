class Log < ApplicationRecord
    def self.search_by(search)
        by_description(search['description'])
    end

    def self.by_description(description)
        if description.present?
            where('description LIKE ?', "%#{description}%").order("created_at desc")
          else
            all.order("created_at desc")
          end
    end
end
