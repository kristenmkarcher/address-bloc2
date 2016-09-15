#include AddressBook using require_relative
require_relative '../models/address_book'

class MenuController
  attr_reader :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
#displays the menu options to the command line
#puts prints out the string from standard output
    puts "Main Menu - #{address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - Create an entry"
    puts "3 - Search for an entry"
    puts "4 - Import entries from a CSV"
    puts "5 - Exit"
    print "Enter your selection: "
#retrieves user input from the command line using gets. gets reads the next line from standard input
    selection = gets.to_i
#case operator determines the proper response to the users input
    case selection
    when 1
      system "clear"
      view_all_entries
      main_menu
    when 2
      system "clear"
      create_entry
      main_menu
    when 3
      system "clear"
      search_entries
      main_menu
    when 4
      system "clear"
      read_csv
      main_menu
    when 5
      puts "Good-bye!"
#terminates the program. 0 signals the program is exiting without error
      exit(0)
#else is used to catch invalid user input and prompt the user to retry
    else
      system "clear"
      puts "Sorry, that is not a valid input"
      main_menu
    end
  end

  def view_all_entries
#each iterates through all entries in AddressBook
    address_book.entries.each do |entry|
      system "clear"
      puts entry.to_s
#entry_submenu displays a submenu for each entry
      entry_submenu(entry)
    end

    system "clear"
    puts "End of entries"
  end

  def create_entry
    system "clear"
    puts "New AddressBloc Entry"
#clears the screen before displaying the create entry prompts
    print "Name: "
    name = gets.chomp
    print = "Phone number: "
    phone = gets.chomp
    print = "Email: "
    email = gets.chomp

#print prompts the user for each Entry attributes
#print works like puts, expect it doesn't add a newline
#new entries are added to address_book using add_entry to ensure the new entry is added in the proper order
    address_book.add_entry(name, phone, email)

    system "clear"
    puts "New entry created"
  end

  def search_entries
  end

  def read_csv
  end

  def entry_submenu(entry)
#submenu options are displayed
    puts "n - next entry"
    puts "d - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"

#chomp removes any whitespace from the string gets returns
    selection = gets.chomp

    case selection
#control will be returned to view_all_entries
    when "n"
#user is shown deleting and editing
    when "d"
    when "e"
#returns user to the main menu
    when "m"
      system "clear"
      main_menu
    else
      system "clear"
      puts "#{selection} is not a valid input"
      entry_submenu(entry)
    end
  end
end
