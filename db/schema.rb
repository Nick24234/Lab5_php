

ActiveRecord::Schema[7.0].define(version: 2025_12_09_021004) do
  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transfers", force: :cascade do |t|
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "pending"
    t.integer "sender_id", null: false
    t.integer "receiver_id", null: false
    t.index ["receiver_id"], name: "index_transfers_on_receiver_id"
    t.index ["sender_id"], name: "index_transfers_on_sender_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "nickname"
    t.decimal "balance", precision: 10, scale: 2, default: "1000.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "full_name"
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
  end

  add_foreign_key "transfers", "users", column: "receiver_id"
  add_foreign_key "transfers", "users", column: "sender_id"
end
