class Hero
	attr_reader :damage, :health, :skills
	attr_accessor :printer

	def initialize(printer)
		@damage = 10
		@health = 5
		@printer = printer
		@skills = [:stealth, :driving, :intimidation]
	end

	def print_state
		if block_given?
			yield(damage, health, skills)
		else
			#Strategy pattern
      printer.print(damage, health, skills) #delegate to printer
    end
	end
end

class HTMLPrinter
	# Template method patter
	def print(damage, health, skills)
		html = header
		html += content(damage, health, skills) 
		html += footer
	end

	def header
		"<html>"
	end

	def footer
		"</html>"
	end

	def content(damage, health, skills)
		raise "You must implement content method"
	end
end

class BattleState < HTMLPrinter
	def content(damage, health, skills)
		"Damage: #{damage}\n Health: #{health}\n"
	end
end

class SkillsState < HTMLPrinter
	def content(damage, health, skills)
		skills.inject(""){|result, skill| result + skill.to_s.capitalize + "\n"}
	end
end

hero = Hero.new(BattleState.new)
puts hero.print_state

# hero1 = Hero.new(BattleState.new)
# puts hero1.print_state

# hero2 = Hero.new(SkillsState.new)
# puts hero2.print_state

# hero3 = Hero.new(BattleState.new)
# result = hero3.print_state do |damage, health, skills|
# 	"Damage: #{damage}\nNumber of skills:#{skills.size}"
# end
# puts result