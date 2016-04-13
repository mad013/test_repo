require_relative 'contact'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

 # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.
end


case ARGV[0]

when "menu"

        puts "Please choose from one of these options
        1. Create new contact
        2. List all contacts
        3. Display contact
        4. Search for contact"

when "list" #def all
    puts Contact.all
when "new" #def create
    puts "Enter first and last name."
    name = STDIN.gets.chomp
    puts "Enter email."
    email = STDIN.gets.chomp
    Contact.create(name,email)

when "show" #def find
    puts "Enter index number to display."
    id = STDIN.gets.chomp
    contact = Contact.find(id)
    puts contact.name
    puts contact.email

when "search" #def search
    puts "Enter name to search."
    name_search= STDIN.gets.chomp
    Contact.search(name_search)
when "update"
    puts "Enter ID of contact you would like to update:"
    update_id = STDIN.gets.chomp
    puts "Enter updated name:"
    update_name = STDIN.gets.chomp
    puts "Enter updated email:"
    update_email = STDIN.gets.chomp
    Contact.update(update_id, update_name, update_email)

else
    puts " that command doesn't exist"
end