require_relative 'Gist_Attributes'
require_relative 'Gist_Request'

loop do
  puts "Ingrese el nombre de su archivo"
  filename = gets.chomp
  puts "Ingrese una descripción"
  description = gets.chomp
  puts "Quieres que sea público?"
  state= gets.chomp.capitalize

  if state == "Si" 
    state = true;
  elsif state == "No"
    state = false;
  else
    puts "Responda si o no"
    break
  end

  gist = GistAttributes.new(filename, description, state)
  gist.file()

  break if gist.gist_attr.response_status == "201"
  break if gist.gist_attr.try_again == "No"
end
