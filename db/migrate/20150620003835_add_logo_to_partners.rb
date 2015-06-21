class AddLogoToPartners < ActiveRecord::Migration
  def change
  	add_column :partners, :logo, :string
  end
end
