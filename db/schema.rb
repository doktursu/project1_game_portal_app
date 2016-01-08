# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160108220131) do

  create_table "ttt_games", force: :cascade do |t|
    t.integer  "player1_id"
    t.string   "player1_symbol"
    t.integer  "player2_id"
    t.string   "player2_symbol"
    t.integer  "current_player_id"
    t.string   "current_player_symbol"
    t.string   "players_symbols"
    t.string   "board",                 default: "---\n- \n- \n- \n- \n- \n- \n- \n- \n- \n"
    t.integer  "winner_id"
    t.boolean  "is_draw",               default: false
    t.string   "state"
    t.string   "message"
    t.datetime "created_at",                                                                  null: false
    t.datetime "updated_at",                                                                  null: false
  end

  create_table "ttt_moves", force: :cascade do |t|
    t.integer  "ttt_game_id"
    t.integer  "player_id"
    t.string   "square"
    t.string   "symbol"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "ttt_moves", ["ttt_game_id"], name: "index_ttt_moves_on_ttt_game_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
