class Dog
    def initialize(breed, name)
        # Instance variables
        @breed = breed
        @name = name
    end

    def name(name)
        @name = name
    end

    def name
        if @name == ""
            puts "My name is #{private_method}"
        else 
            puts "My name is #{@name}"
        end 
    end

    private 
    def private_method
        return "Rover"
    end

    public
    def speak 
        puts "Ruff Ruff!"
    end
end

dog = Dog.new("Border Collie", "Lucky")
dog.name
dog.speak

class StBernard < Dog
    def initialize(name)
        super("StBernard", name)
    end

    def speak
        puts "RUFF RUFF"
    end
end

class Pug < Dog 
    def initialize(name, tail)
        super("Pug", name)
        @tail = tail
    end

    def speak
        puts "ruff ruff"
    end
end

class Lab < Dog 
    def initialize(name)
        super("Lab", name)
    end
end

puts

bigDog = StBernard.new("Spike")
bigDog.name
bigDog.speak

puts

smallDog = Pug.new("Goliath", "Curly")
smallDog.name
smallDog.speak
#puts smallDog.tail

puts

mediumDog = Lab.new("Rover")
mediumDog.name
mediumDog.speak
