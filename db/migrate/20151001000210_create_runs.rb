class CreateRuns < ActiveRecord::Migration
  def change
    create_table :runs do |t|
      t.date :ran_on
      t.float :distance

      t.timestamps null: false
    end
  end
end
