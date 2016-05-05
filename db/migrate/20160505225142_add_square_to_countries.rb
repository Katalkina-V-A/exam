class AddSquareToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :square, :integer, default: 0
  end
end
