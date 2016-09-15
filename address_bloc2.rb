require_relative 'controllers/menu_controller'

#creates a new MenuController when AddressBloc starts
menu = MenuController.new
#system "clear" clears the command line
system "clear"
puts "Welcome to AddressBloc!"
#main_menu displays the menu
menu.main_menu
