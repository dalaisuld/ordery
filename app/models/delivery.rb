class Delivery < ApplicationRecord
    def self.filter_day(filter_day)
        if filter_day.present?
            where('delivery_date LIKE ?', "%#{filter_day}%")
        else
            all
        end
    end
end
