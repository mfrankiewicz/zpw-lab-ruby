class User < ApplicationRecord
    validates :email, :presence => true
    validates :password, :presence => true
    validates_format_of  :email, :with => /[\+A-Z0-9\._%-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}\z/i
    attr_accessor :login
    validate :do_login

    def do_login
        if self.email == nil || self.password == nil
            return
        end
        user = User.
            where(:email => self.email).
            where(:password => self.password)

        if user.size == 0
            errors.add(:login, "failed")
        end
    end

end
