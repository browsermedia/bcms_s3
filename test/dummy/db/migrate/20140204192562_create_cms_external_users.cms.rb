# This migration comes from cms (originally 20131218222005)
class CreateCmsExternalUsers < ActiveRecord::Migration
  def change
    change_table :cms_users do |t|
      t.column :type, :string, default: 'Cms::User'
      t.column :source, :string
      t.text :external_data
    end

  end
end
