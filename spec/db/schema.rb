ActiveRecord::Schema.define(:version => 0) do

  create_table :users, :force => true do |t|
    t.column :name, :string
  end

  create_table :posts, :force => true do |t|
    t.column :body, :text
    t.column :title, :string
  end

  create_table :comments, :force => true do |t|
    t.column :body, :text
    t.column :post_id, :integer
  end
  
  create_table :activities, :force => true do |t|
      t.integer  :trackable_id
      t.string   :trackable_type
      t.integer  :actor_id
      t.string   :actor_type
      t.integer  :recipient_id
      t.string   :recipient_type
      t.string   :key
      t.text     :parameters
      t.datetime :created_at
  end
    
end
