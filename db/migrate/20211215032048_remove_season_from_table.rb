class RemoveSeasonFromTable < ActiveRecord::Migration[6.1]
  def change
    remove_column :scores, :season, :string
  end
end
