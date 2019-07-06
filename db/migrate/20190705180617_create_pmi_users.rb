class CreatePmiUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :pmi_users do |t|
      t.string :name
      t.string :city
      t.string :country

      t.timestamps
    end

    add_index :pmi_users, %i[name city country], unique: true
  end
end
