class Hero
	attr_reader :damage, :abilities

	def initialize(occupation = nil)
		@damage, @abilities = 10, []
	end

	def attack
		"Attacked dealing #{damage} damage"
	end
end

class Warrior < Hero
	def initialize(occupation = nil)
		@damage, @abilities = 15, [:strike] 
	end
end

class Mage < Hero
	def initialize(occupation = nil)
		@damage, @abilities = 7, [:magic_arrow] 
	end
end

warrior = Warrior.new
puts warrior.attack
mage = Mage.new
puts mage.attack
other = Hero.new
puts other.attack