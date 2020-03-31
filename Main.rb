require_relative 'Gist_Attributes'
require_relative 'Gist_Request'

loop do
  puts "Ingrese el nombre de su archivo"
  filename = gets.chomp
  puts "Ingrese una descripción"
  description = gets.chomp
  puts "Quieres que tu repositorio sea público? Si/No, por defecto el repositorio será público"
  state= gets.chomp.capitalize
  state = state != "No"
  gist = GistAttributes.new(filename, description, state)
  gist.check_existence()

  break if gist.gist_attr.response_status == HTTP_STATUS_CREATED
  break if gist.gist_attr.try_again == "No"
end
