class Customer < ActiveRecord::Base
    has_one :customer_type
    has_and_belongs_to_many :daycare_departments, join_table: :customers_daycare_departments
    
    validates :customer_name, presence: true
    validates :username, presence: true, uniqueness: { case_sensitive: false }
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
    validates :password, presence: true
    validates :customer_type_id, presence: true

    has_secure_password
    
    #def self.import(file)
    #  CSV.foreach(file.path, headers: true) do |row|
    #    Customer.create! row.to_hash
    #  end
    #end
    
    def self.import(file)
      spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        customer = Customer.new
        customer.attributes = row.to_hash.slice(*accessible_attributes)
        customer.save!
      end
      
    end
    
    def self.open_spreadsheet(file)
      case File.extname(file.original_filename)
      when ".csv" then Csv.new(file.path, nil, :ignore)
      when ".xls" then Excel.new(file.path, nil, :ignore)
      when ".xlsx" then Excelx.new(file.path, nil, :ignore)
      else raise "Unknown file type: #{file.original_filename}"
      end
    end

end
