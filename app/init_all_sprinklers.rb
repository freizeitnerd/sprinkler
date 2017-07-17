def init_all_sprinklers(gpio_numbers, names=[])
  sprinklers = []
  for i in 0..gpio_numbers.size-1
    name = names[i] || "Sprinkler #{i+1}"
    puts "Initiate Sprinkler '#{name}' at GPIO#{gpio_numbers[i]}"
    sprinkler = Sprinkler.new(gpio_numbers[i], name)
    sprinkler.close
    sprinklers.push(sprinkler)
  end
  sprinklers
end
