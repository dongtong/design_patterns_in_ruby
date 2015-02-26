class Hero
	attr_reader :damage, :abilities

	def initialize(occupation = nil)
		other_processing
		@damage, @abilities = set_damage, set_abilities
	end

	def attack
		"Attacked dealing #{damage} damage"
	end

	def other_processing
	end

	def set_damage
		10
	end

	def set_abilities
		[]
	end

	def greet
		greet = ["Hello"]
		greet << special_greet
		greet
	end

	def special_greet
		raise "Subclass need to implement special_greet method"
	end
end

class Warrior < Hero
	def set_damage
		15
	end

	def set_abilities
		[:strike]
	end

	def special_greet
		"I'm a warrior, and I will fight until dead."
	end
end

class Mage < Hero
	def set_damage
		7
	end

	def set_abilities
		[:magic_arrow]
	end
end

warrior = Warrior.new
puts warrior.attack
puts warrior.greet
mage = Mage.new
puts mage.attack
other = Hero.new
puts other.attack