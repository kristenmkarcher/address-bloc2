#require_relative tells Ruby to load the library named entry.rb relative to address_book.rb's file path
require_relative 'entry'

class AddressBook
  attr_reader :entries

  def initialize
    @entries = []
  end

  def add_entry(name, phone_number, email)
#to store the insertion index, a variable is created
    index = 0
    entries.each do |entry|
#compares the name with the name of the current entry.
#if name lexicographically proceeds entry.name, we've found the index to insert at.
      if name < entry.name
        break
      end

  def remove_entry(name, phone_number, email)
#loops through each entry in the array and allows the use of the index location number for each entry
    entries.each_with_index do |entry, i|
#if the name parameter is equal to the name value inside of the single entry(entry.name)
      if name == entry.name
#the value at the index location is deleted in the entries array
        entries.delete_at(i)
      end
    end
 end
      index += 1
    end
#new entry is inserted into entries using the calculated index
    entries.insert(index, Entry.new(name, phone_number, email))
  end
end
