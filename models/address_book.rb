#require_relative tells Ruby to load the library named entry.rb relative to address_book.rb's file path
require_relative 'entry'

class AddressBook
  attr_reader :entries

  def initialize
    @entries = []
  end

  def add_entry(name, phone_number, email)
#to store the inserion index, a variable is created
    index = 0
    entries.each do |entry|
#compares the name with the name of the current entry.
#if name lexicographically proceeds entry.name, we've found the index to insert at.
      if name < entry.name
        break
      end
      index += 1
    end
#new entry is inserted into entries using the calculated index
    entries.insert(index, Entry.new(name, phone_number, email))
  end
end
