class Viewer
   @@count = 0

   def self.increment_counter
     @@count+= 1
   end

   def self.decrement_counter
     if @@count > 0
       @@count-= 1
     end
   end

   def self.count
     @@count
   end

end
