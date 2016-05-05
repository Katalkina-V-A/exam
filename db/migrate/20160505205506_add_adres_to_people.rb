class AddAdresToPeople < ActiveRecord::Migration
  def change
    add_column :people, :adres, :string
  end
end
