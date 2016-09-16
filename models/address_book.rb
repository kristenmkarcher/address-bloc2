#require_relative tells Ruby to load the library named entry.rb relative to address_book.rb's file path
require_relative 'entry'
require "csv"

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
#import_from_csv starts by reading the file using File.read
#CSV is used to parse the file. The result of CSV.parse is an object of type CSV::Table
#parsing analyzes a string of symbols and conforms to rules of grammar
  def import_from_csv(file_name)
    csv_text = File.read(file_name)
    csv = CSV.parse(csv_text, headers: true, skip_blanks: true)
#add_entry converts each row_hash to an Entry
    csv.each do |row|
      row_hash = row.to_hash
      add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
    end
  end

  def binary_search(name)
# the leftmost item in the array is a variable named lower, and the rightmost item in the array is a variable named upper
    lower = 0
    upper = entries.length - 1

# loop while the lower index is less than or equal to the upper index
    while lower <= upper
# finds the middle index by taking the sum of lower and upper and dividing by 2
    mid = (lower + upper) / 2
    mid_name = entries[mid].name

# name and mid_name are compared
      if name == mid_name
        return entries[mid]
      elsif name < mid_name
        upper = mid - 1
      elsif name > mid_name
        lower = mid + 1
      end
    end

# if no match is found, it returns nil
    return nil
   end
# this iterates over the entries until a match of the name is found
#if no match is found, it returns nil
   def iterative_search(name)
     entries.each do |entry|
       if name == entry.name
          return entry
       end
     end
     return nil
   end
end
