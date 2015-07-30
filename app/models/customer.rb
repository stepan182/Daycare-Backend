class Customer < ActiveRecord::Base
    belongs_to :customer_type
    has_many :user_types
    has_many :users
    belongs_to :franchise
    belongs_to :partner
    has_and_belongs_to_many :daycare_departments, join_table: :customers_daycare_departments
    has_and_belongs_to_many :privileges, join_table: :customers_privileges
    has_and_belongs_to_many :todos, join_table: :customers_todos
    has_and_belongs_to_many :titles, join_table: :customers_titiles
    
    
    validates :customer_name, presence: true
    #validates :username, presence: true, uniqueness: { case_sensitive: false }
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
    #validates :password, presence: true
    
    has_secure_password
    
    def self.import(file)
      spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        if !Customer.exists?(:username => row["username"])
          customer = Customer.new
          #customer.attributes = row.to_hash.slice(*row.to_hash.keys)
          customer.customer_name = row["customer name"]
          customer.username = row["username"]
          customer.password = row["password"]
          customer.email = row["email"]
          customer.country = row["country"]
          
          #Daycare customer
          if file.original_filename == "Daycare-Customers.xlsx"
            daycare_type = CustomerType.find_by(:type_name => "Daycare Customer")
            customer.customer_type_id = daycare_type.id
            customer.daycare_user_type = row["daycare user type"]
            daycare_department = DaycareDepartment.find_by(:department_name => row["daycare department"])
            if daycare_department.nil?
              daycare_department = DaycareDepartment.create(:department_name => row["daycare department"])
            end
            customer.daycare_department_ids = daycare_department.id
            
            daycare_type = nil
            daycare_department = nil
          
          #Daycare partner
          elsif file.original_filename == "Daycare-Partners.xlsx"
            partner_type = CustomerType.find_by(:type_name => row["customer type"])
            if partner_type.nil?
              partner_type = CustomerType.create(:type_name => row["customer type"])
            end
            customer.customer_type_id = partner_type.id
            
            partner_type = nil
          end
          
          customer.save!
        end
      end
      
    end
    
    def self.open_spreadsheet(file)
      case File.extname(file.original_filename)
      when ".csv" then Roo::Csv.new(file.path, packed: nil, file_warning: :ignore)
      when ".xls" then Roo::Excel.new(file.path, packed: nil, file_warning: :ignore)
      when ".xlsx" then Roo::Excelx.new(file.path, packed: nil, file_warning: :ignore)
      else raise "Unknown file type: #{file.original_filename}"
      end
    end

end
