class AddBudgetToFilms < ActiveRecord::Migration
  def change
    add_column :films, :budget, :integer
  end
end
