class UpdateDateDataType < ActiveRecord::Migration[6.1]
  def change
    change_column :scores, :date, "date USING CAST(date AS date)"
  end
end
