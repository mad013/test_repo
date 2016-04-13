require 'csv'
require 'pry'
require 'pg'

class Contact

  attr_accessor :name, :email, :id
 
  def initialize(name, email, id=0)
   @name = name
   @email = email
   @id = id
   # TODO: Assign parameter values to instance variables.
  end

  def save
    if @id == 0 #contact does not exist
      self.class.connection.exec_params("INSERT INTO contacts (name, email) VALUES ($1, $2);", [self.name, self.email])
    else #contact does already exist
      self.class.connection.exec_params("UPDATE contacts SET name = $1, email = $2 WHERE id = $3::int;", [self.name, self.email, self.id]) 
    end 
  end 

  class << self
   
  def connection
    puts 'Connecting to the database...'
    PG.connect(
      host: 'localhost',
      dbname: 'postgres',
      user: 'development',
      password: 'development'
      )
  end 

  def all
    puts 'Finding contacts...'
    connection.exec('SELECT * FROM contacts;') do |results|
      results.each do |contact|
        puts contact.inspect
      end
    end
  end 

    #CSV.foreach("contacts.csv") do |contact|
      #puts "#{contact[0]} === #{contact[1]}"
    #end
  

  
  def create(name, email)
    contact = self.new(name, email)
    contact.save
  end 
    #contact= Contact.new(name,email)
    #CSV.open("contacts.csv","a+") do |csv| 
      #csv << [contact.name,contact.email]

      #puts "New contact was created successfully: Name: #{contact.name}, Email:#{contact.email}"
      #end
  

  def find(id)
   #contacts = CSV.read("contacts.csv") 
   #puts contacts[(id.to_i) -1]
   connection.exec("SELECT * FROM contacts WHERE id = #{id}") do |results|
      results.each do |contact|
        return Contact.new(contact["name"], contact["email"], contact["id"])
      end
    end
  end 
 
  def search(term)
   #contacts = CSV.read("contacts.csv")
   #puts contacts[term.to_i] 
   connection.exec("SELECT * FROM contacts WHERE name LIKE '%#{term}%'") do |results|
      results.each do |contact|
        puts contact.inspect
      end
    end
  end

  def update(id, new_name, new_email)
    the_contact = Contact.find(id)
    the_contact.name = new_name
    the_contact.email = new_email
    the_contact.save
  end 

end
end