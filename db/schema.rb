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

ActiveRecord::Schema.define(version: 20160718130507) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "actors", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "gender",     limit: 255
    t.text     "biography",  limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "attachments", force: :cascade do |t|
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.integer  "attachable_id",      limit: 4
    t.string   "attachable_type",    limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "attachments", ["attachable_type", "attachable_id"], name: "index_attachments_on_attachable_type_and_attachable_id", using: :btree

  create_table "casts", force: :cascade do |t|
    t.integer  "movie_id",   limit: 4
    t.integer  "actor_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "casts", ["actor_id"], name: "index_casts_on_actor_id", using: :btree
  add_index "casts", ["movie_id"], name: "index_casts_on_movie_id", using: :btree

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "movie_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "favorites", ["movie_id"], name: "index_favorites_on_movie_id", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "movies", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.string   "trailer",      limit: 255
    t.text     "description",  limit: 65535
    t.boolean  "approved"
    t.boolean  "featured"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "duration",     limit: 4
    t.string   "genre",        limit: 50
    t.date     "release_date"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "movie_id",   limit: 4
    t.integer  "score",      limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "ratings", ["movie_id"], name: "index_ratings_on_movie_id", using: :btree
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id", using: :btree

  create_table "reported_reviews", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "review_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "reported_reviews", ["review_id"], name: "index_reported_reviews_on_review_id", using: :btree
  add_index "reported_reviews", ["user_id"], name: "index_reported_reviews_on_user_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "movie_id",     limit: 4
    t.text     "comment",      limit: 65535
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "report_count", limit: 4,     default: 0
  end

  add_index "reviews", ["movie_id"], name: "index_reviews_on_movie_id", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.string   "full_name",              limit: 255
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "casts", "actors"
  add_foreign_key "casts", "movies"
  add_foreign_key "favorites", "movies"
  add_foreign_key "favorites", "users"
  add_foreign_key "ratings", "movies"
  add_foreign_key "ratings", "users"
  add_foreign_key "reported_reviews", "reviews"
  add_foreign_key "reported_reviews", "users"
  add_foreign_key "reviews", "movies"
  add_foreign_key "reviews", "users"
end
