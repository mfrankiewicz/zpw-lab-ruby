class Event < ApplicationRecord
    validates :artist, :presence => true
    validates :description, :presence => true
    validates :price_low, :presence => true, numericality: { greater_than: 0 }
    validates :price_high, :presence => true, numericality: { greater_than: 0 }, if: :proper_price
    validates :event_date, :presence => true, if: :proper_date
    validates :seat_count, numericality: { only_integer: true, greater_than: 0 }
    has_many :tickets

    def proper_date
        if self.event_date == nil
            return
        end
        errors.add(:event_date, "from past") if self.event_date < Date.today
    end

    def proper_price
        if self.price_low == nil || self.price_high == nil
            return
        end
        errors.add(:price_high, "must be higher than price low") if Float(price_low) > Float(price_high)
    end
end
