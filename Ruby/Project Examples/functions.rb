def something
    yield
end


saySomethingElse = -> {puts "This will also print"}

sayOneMoreThing = Proc.new { puts "Print again" }

something{ puts "This will print something." }
saySomethingElse.call
sayOneMoreThing.call
