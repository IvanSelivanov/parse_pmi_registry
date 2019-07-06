class CreatePmiCredentials < ActiveRecord::Migration[5.2]
  def change
    execute <<-SQL
      CREATE TYPE credential_type
      AS ENUM ('PMP', 'CAPM', 'PgMP', 'PMI-RMP', 'PMI-SP', 'PMI-ACP', 'PfMP', 'PMI-PBA');
    SQL

    create_table :pmi_credentials do |t|
      t.references :pmi_user, foreign_key: true
      t.column :credential, :credential_type
      t.date :earned
      t.string :status

      t.timestamps
    end
  end
end
