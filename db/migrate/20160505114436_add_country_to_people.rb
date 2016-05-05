class AddCountryToPeople < ActiveRecord::Migration
  def change
    add_reference :people, :country, index: true, foreign_key: true
  end
end
