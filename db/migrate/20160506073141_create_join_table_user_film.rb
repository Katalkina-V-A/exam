class CreateJoinTableUserFilm < ActiveRecord::Migration
  def change
    create_join_table :users, :films do |t|
      t.index [:user_id, :film_id]
      t.index [:film_id, :user_id]
    end
  end
end
