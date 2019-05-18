class CreateNumberWords < ActiveRecord::Migration[5.2]
  def change
    create_table :number_words do |t|
      t.string :phone_number

      t.timestamps
    end
  end
end
