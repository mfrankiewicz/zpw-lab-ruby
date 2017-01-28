class Ticket < ApplicationRecord
    validates :name, :presence => true, :length => { :minimum => 6 }
    validates :email_address, :presence => true
    validates :address, :presence => true
    validates :price, :presence => true
    validates :seat_id_seq, :presence => true
    validates :age, :presence => true, numericality: { only_integer: true, greater_than: 0 }
    validates_format_of  :email_address, :with => /[\+A-Z0-9\._%-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}\z/i
    validates_format_of  :seat_id_seq, :with => /[A-Za-z][0-9]+\z/i, :message => "example format: E23"
    belongs_to :event, validate: true

    attr_accessor :ticket
    validate :event_exists
    validate :sold_out, unless: :event_exists
    validate :adult_restriction, unless: :event_exists
    validate :multiple_purchase, unless: :event_exists
    validate :purchase_available, unless: :event_exists
    validate :proper_price, unless: :event_exists

    def event_exists
        if self.event_id == nil || !Event.exists?(id: self.event_id)
            errors.add(:event_id, "does not exist")
        end
    end

    def sold_out
        if self.event_id == nil
            return
        end
        tickets = Ticket.where(event_id: self.event_id)
        event = Event.find(self.event_id)

        errors.add(:ticket, "sold out") if Integer(Integer(event.seat_count) - tickets.size) <= 0
    end

    def adult_restriction
        if self.event_id == nil || self.age == nil
            return
        end
        tickets = Ticket.where(event_id: self.event_id)
        event = Event.find(self.event_id)

        errors.add(:age, "adult restriction") if event.adult && self.age < 18
    end

    def multiple_purchase
        tickets = Ticket.where(name: self.name).where(event_id: self.event_id)
        errors.add(:ticket, "amount of tickets restricted to 5") if tickets.size > 5
    end

    def purchase_available
        if self.event_id == nil
            return
        end
        event = Event.find(self.event_id)
        errors.add(:ticket, "purchase unavailable") if event.event_date-1.months > Date.today || event.event_date < Date.today
    end

    def proper_price
        if self.event_id == nil || self.price == nil
            return
        end
        event = Event.find(self.event_id)
        if event.event_date == Date.today
            errors.add(:price, " in day of event is 20% higher than maximal price (" + String(Float(event.price_high * 1.2).round(2)) + " zł)") if Float(price) != Float(event.price_high * 1.2).round(2)
        else
            errors.add(:price, " must be between " + String(event.price_low) + " and " + String(event.price_high)) if (Float(price) < Float(event.price_low) || Float(price) > Float(event.price_high))
        end
    end
end
