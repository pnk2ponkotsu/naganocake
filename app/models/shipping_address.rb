class ShippingAddress < ApplicationRecord
    
    def address_display
        '〒' + postal_code + ' ' + address + ' ' + name
    end
end
