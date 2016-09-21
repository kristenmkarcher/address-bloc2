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
#gets the name the user wants to search for and stores it in name
    print "Search by name: "
    name = gets.chomp
#search is called on address_book which will return a match or nil
    match = address_book.binary_search(name)
    system "clear"
#checks if search returned a match
    if match
      puts match.to_s
      search_submenu(match)
    else
      puts "No match found for #{name}"
    end
  end

  def read_csv
#prompts the user to enter a name of a CSV file to import
    print "Enter CSV file to import: "
    file_name = gets.chomp

#checks if the file name is empty. if it is then the user is returned back to the main menu by calling main_menu
    if file_name.empty?
      system "clear"
      puts "No CSV file read"
      main_menu
    end

#the specified file is imported with import_from_csv on address book
#the screen is cleared and the number of entries that were read from the file are printed
#begin will protect the program from crashing if an exception is thrown
    begin
      entry_count = address_book.import_from_csv(file_name).count
      system "clear"
      puts "#{entry_count} new entries added from #{file_name}"
    rescue
      puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
      read_csv
    end
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
#when a user is viewing the submenu and they press d, delete_entry is called
#after the entry is deleted, control will return to view_all_entries and the next entry will be displayed
      delete_entry(entry)
    when "e"
#edit_entry is called when a user presses e. a submenu is displayed with entry_submenu for the entry under edit
      edit_entry(entry)
      entry_submenu(entry)
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

  def delete_entry(entry)
    address_book.entries.delete(entry)
    puts "#{entry.name} has been deleted"
  end

  def demolish_entries
    address_book.entries.each do |entry|
      address_book.entries.delete(entry)
      puts "#{entry.name} has been deleted"
    end
  end

  def edit_entry(entry)
# gets.chomp gathers user input and assigns it to an appropriately named variable
    print "Updated name: "
    name = gets.chomp
    print "Updated phone number: "
    phone_number = gets.chomp
    print "Updated email: "
    email = gets.chomp
#!attribute.empty? sets attributes on entry only if a valid attribute was read form user input
    entry.name = name if !name.empty?
    entry.phone_number = phone_number if !phone_number.empty?
    entry.email = email if !email.empty?
    system "clear"
#entry is printed out with the updated attributes
    puts "Updated entry:"
    puts entry
  end

  def search_submenu(entry)
# prints out submenu for entry
    puts "\nd - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"
    puts "k - delete all entries"
#the user input is saved to selection
    selection = gets.chomp

# case statement is used to take a specific action based on user input
    case selection
    when "d"
      system "clear"
      delete_entry(entry)
      main_menu
    when "e"
      edit_entry(entry)
      system "clear"
      main_menu
    when "m"
      system "clear"
      main_menu
    when "k"
      system "clear"
      demolish_entries
      main_menu
    else
      system "clear"
      puts "#{selection} is not a valid input"
      puts entry.to_s
      search_submenu(entry)
    end
  end
end
