class Event < ApplicationRecord
    validates :artist, :presence => true, :length => { :minimum => 6 }
    validates :description, :presence => true
    validates :price_low, :presence => true, numericality: { greater_than: 0 }
    validates :price_high, :presence => true, numericality: { greater_than: 0 }
    validates :event_date, :presence => true, if: :proper_date
    validates :adult, :presence => true
    validates :seat_count, numericality: { only_integer: true, greater_than: 0 }
    has_many :tickets

    def proper_date

    end
end
