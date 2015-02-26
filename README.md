# Implement common design patterns with ruby

##Template method pattern

###What's the template method pattern?
> Define the skeleton of an algorithm in an operation, deferring some steps to subclasses. Template method lets subclasses redefine certain steps of an algorithm without changing the algorithm's structure.


Template method pattern is based on inheritance techology, it's a kind of class behavioral pattern.

We call those steps as basic method. Template method has one or more basic methods. If some basic methods are simple and not mutable, we could put them into super class, and mutable basic methods into subclasses, then we could implement different behavioral in special subclass.

Let's see the follow class implementation:

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
    

So, if we are going to add other occupations, then we have to duplicate the when statement. Firstly, we could use inheritance to refactor the above implement:

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
    
If we have other occupation, we could define a new occupation class. but if super class Hero initialize method has other processing, then subclasses have to implement it, such as other_processing method.

    def initialize(occupation = nil)
      other_processing 
	  @damage, @abilities = 10, []
	end

Here we could make initialize as template method, and we focus on mutable place(damage, abilities)

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
    end

    class Warrior < Hero
	  def set_damage
		15
	  end

	  def set_abilities
		[:strike]
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
    mage = Mage.new
    puts mage.attack
    other = Hero.new
    puts other.attack
    
The set_damage and set_abilities methods are basic method, and Hero's initialize method is template method. It defines intilization sequence(firstly, invokes other_processing, sencondly invokes set_damage, and lastly invokes set_abilities).
We could add another template method(greet)

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
    
If subclasses do not implement special_greet method, the program will raise runtime error. Finally, let's look at the UML demostration:

![template_method](images/1.png)


