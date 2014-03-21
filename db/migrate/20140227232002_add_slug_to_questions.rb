class AddSlugToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :slug, :string
    add_column :answers, :slug, :string
  end
end
