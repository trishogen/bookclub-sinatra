class AddBookOfTheWeekToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :book_of_the_week, :string
  end
end
