module Cream
    def cream?
        true
    end 
end

class Cookie
    include Cream
end

cookie = Cookie.new
puts cookie.cream?