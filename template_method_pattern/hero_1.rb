class Hero
	attr_reader :damage, :abilities

	def initialize(occupation = nil)
		 case occupation
		 when "warrior"
			 @damage, @abilities = 15, [:strike]
		 when "mage"
			@damage, @abilities = 7, [:magic_arrow]
		else
			@damage, @abilities = 10, []
		end
	end

	def attack
		"Attacked dealing #{damage} damage"
	end
end

warrior = Hero.new("warrior")
puts warrior.attack
mage = Hero.new("mage")
puts mage.attack
other = Hero.new
puts other.attack
