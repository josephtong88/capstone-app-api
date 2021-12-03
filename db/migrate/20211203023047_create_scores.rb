class CreateScores < ActiveRecord::Migration[6.1]
  def change
    create_table :scores do |t|
      t.string :date
      t.string :home_team
      t.string :away_team
      t.integer :home_score
      t.integer :away_score
      t.integer :closing_spread_home
      t.integer :closing_spread_away
      t.string :home_team_cover
      t.string :away_team_cover
      t.string :home_team_id
      t.string :away_team_id
      t.string :season

      t.timestamps
    end
  end
end
