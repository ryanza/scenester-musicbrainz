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

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "annotation", force: true do |t|
    t.integer  "editor",                      null: false
    t.text     "text"
    t.string   "changelog"
    t.datetime "created",   default: "now()"
  end

  create_table "application", force: true do |t|
    t.integer "owner",              null: false
    t.text    "name",               null: false
    t.text    "oauth_id",           null: false
    t.text    "oauth_secret",       null: false
    t.text    "oauth_redirect_uri"
  end

  add_index "application", ["oauth_id"], name: "application_idx_oauth_id", unique: true, using: :btree
  add_index "application", ["owner"], name: "application_idx_owner", using: :btree

  create_table "area", force: true do |t|
    t.uuid     "gid",                                            null: false
    t.string   "name",             limit: nil,                   null: false
    t.string   "sort_name",        limit: nil,                   null: false
    t.integer  "type"
    t.integer  "edits_pending",                default: 0,       null: false
    t.datetime "last_updated",                 default: "now()"
    t.integer  "begin_date_year",  limit: 2
    t.integer  "begin_date_month", limit: 2
    t.integer  "begin_date_day",   limit: 2
    t.integer  "end_date_year",    limit: 2
    t.integer  "end_date_month",   limit: 2
    t.integer  "end_date_day",     limit: 2
    t.boolean  "ended",                        default: false,   null: false
    t.string   "comment",                      default: "",      null: false
  end

  add_index "area", ["gid"], name: "area_idx_gid", unique: true, using: :btree
  add_index "area", ["name"], name: "area_idx_name", using: :btree
  add_index "area", ["sort_name"], name: "area_idx_sort_name", using: :btree

  create_table "area_alias", force: true do |t|
    t.integer  "area",                                             null: false
    t.string   "name",               limit: nil,                   null: false
    t.text     "locale"
    t.integer  "edits_pending",                  default: 0,       null: false
    t.datetime "last_updated",                   default: "now()"
    t.integer  "type"
    t.string   "sort_name",          limit: nil,                   null: false
    t.integer  "begin_date_year",    limit: 2
    t.integer  "begin_date_month",   limit: 2
    t.integer  "begin_date_day",     limit: 2
    t.integer  "end_date_year",      limit: 2
    t.integer  "end_date_month",     limit: 2
    t.integer  "end_date_day",       limit: 2
    t.boolean  "primary_for_locale",             default: false,   null: false
    t.boolean  "ended",                          default: false,   null: false
  end

  add_index "area_alias", ["area", "locale"], name: "area_alias_idx_primary", unique: true, where: "((primary_for_locale = true) AND (locale IS NOT NULL))", using: :btree
  add_index "area_alias", ["area"], name: "area_alias_idx_area", using: :btree

  create_table "area_alias_type", force: true do |t|
    t.text "name", null: false
  end

  create_table "area_annotation", id: false, force: true do |t|
    t.integer "area",       null: false
    t.integer "annotation", null: false
  end

  create_table "area_gid_redirect", id: false, force: true do |t|
    t.uuid     "gid",                       null: false
    t.integer  "new_id",                    null: false
    t.datetime "created", default: "now()"
  end

  create_table "area_type", force: true do |t|
    t.string "name", null: false
  end

  create_table "artist", force: true do |t|
    t.uuid     "gid",                                            null: false
    t.string   "name",             limit: nil,                   null: false
    t.string   "sort_name",        limit: nil,                   null: false
    t.integer  "begin_date_year",  limit: 2
    t.integer  "begin_date_month", limit: 2
    t.integer  "begin_date_day",   limit: 2
    t.integer  "end_date_year",    limit: 2
    t.integer  "end_date_month",   limit: 2
    t.integer  "end_date_day",     limit: 2
    t.integer  "type"
    t.integer  "area"
    t.integer  "gender"
    t.string   "comment",                      default: "",      null: false
    t.integer  "edits_pending",                default: 0,       null: false
    t.datetime "last_updated",                 default: "now()"
    t.boolean  "ended",                        default: false,   null: false
    t.integer  "begin_area"
    t.integer  "end_area"
  end

  add_index "artist", ["area"], name: "artist_idx_area", using: :btree
  add_index "artist", ["begin_area"], name: "artist_idx_begin_area", using: :btree
  add_index "artist", ["end_area"], name: "artist_idx_end_area", using: :btree
  add_index "artist", ["gid"], name: "artist_idx_gid", unique: true, using: :btree
  add_index "artist", ["name", "comment"], name: "artist_idx_uniq_name_comment", unique: true, where: "(comment IS NOT NULL)", using: :btree
  add_index "artist", ["name"], name: "artist_idx_name", using: :btree
  add_index "artist", ["name"], name: "artist_idx_null_comment", unique: true, where: "(comment IS NULL)", using: :btree
  add_index "artist", ["sort_name"], name: "artist_idx_sort_name", using: :btree

  create_table "artist_alias", force: true do |t|
    t.integer  "artist",                                           null: false
    t.string   "name",               limit: nil,                   null: false
    t.text     "locale"
    t.integer  "edits_pending",                  default: 0,       null: false
    t.datetime "last_updated",                   default: "now()"
    t.integer  "type"
    t.string   "sort_name",          limit: nil,                   null: false
    t.integer  "begin_date_year",    limit: 2
    t.integer  "begin_date_month",   limit: 2
    t.integer  "begin_date_day",     limit: 2
    t.integer  "end_date_year",      limit: 2
    t.integer  "end_date_month",     limit: 2
    t.integer  "end_date_day",       limit: 2
    t.boolean  "primary_for_locale",             default: false,   null: false
    t.boolean  "ended",                          default: false,   null: false
  end

  add_index "artist_alias", ["artist", "locale"], name: "artist_alias_idx_primary", unique: true, where: "((primary_for_locale = true) AND (locale IS NOT NULL))", using: :btree
  add_index "artist_alias", ["artist"], name: "artist_alias_idx_artist", using: :btree

  create_table "artist_alias_type", force: true do |t|
    t.text "name", null: false
  end

  create_table "artist_annotation", id: false, force: true do |t|
    t.integer "artist",     null: false
    t.integer "annotation", null: false
  end

  create_table "artist_credit", force: true do |t|
    t.string   "name",         limit: nil,                   null: false
    t.integer  "artist_count", limit: 2,                     null: false
    t.integer  "ref_count",                default: 0
    t.datetime "created",                  default: "now()"
  end

  create_table "artist_credit_name", id: false, force: true do |t|
    t.integer "artist_credit",                          null: false
    t.integer "position",      limit: 2,                null: false
    t.integer "artist",                                 null: false
    t.string  "name",          limit: nil,              null: false
    t.text    "join_phrase",               default: "", null: false
  end

  add_index "artist_credit_name", ["artist"], name: "artist_credit_name_idx_artist", using: :btree

  create_table "artist_deletion", id: false, force: true do |t|
    t.uuid     "gid",                                              null: false
    t.string   "last_known_name",    limit: nil,                   null: false
    t.text     "last_known_comment",                               null: false
    t.datetime "deleted_at",                     default: "now()", null: false
  end

  create_table "artist_gid_redirect", id: false, force: true do |t|
    t.uuid     "gid",                       null: false
    t.integer  "new_id",                    null: false
    t.datetime "created", default: "now()"
  end

  create_table "artist_ipi", id: false, force: true do |t|
    t.integer  "artist",                                     null: false
    t.string   "ipi",           limit: 11,                   null: false
    t.integer  "edits_pending",            default: 0,       null: false
    t.datetime "created",                  default: "now()"
  end

  create_table "artist_isni", id: false, force: true do |t|
    t.integer  "artist",                                     null: false
    t.string   "isni",          limit: 16,                   null: false
    t.integer  "edits_pending",            default: 0,       null: false
    t.datetime "created",                  default: "now()"
  end

  create_table "artist_meta", id: false, force: true do |t|
    t.integer "id",                     null: false
    t.integer "rating",       limit: 2
    t.integer "rating_count"
  end

  create_table "artist_rating_raw", id: false, force: true do |t|
    t.integer "artist",           null: false
    t.integer "editor",           null: false
    t.integer "rating", limit: 2, null: false
  end

  add_index "artist_rating_raw", ["artist"], name: "artist_rating_raw_idx_artist", using: :btree
  add_index "artist_rating_raw", ["editor"], name: "artist_rating_raw_idx_editor", using: :btree

  create_table "artist_tag", id: false, force: true do |t|
    t.integer  "artist",                         null: false
    t.integer  "tag",                            null: false
    t.integer  "count",                          null: false
    t.datetime "last_updated", default: "now()"
  end

  add_index "artist_tag", ["tag"], name: "artist_tag_idx_tag", using: :btree

  create_table "artist_tag_raw", id: false, force: true do |t|
    t.integer "artist", null: false
    t.integer "editor", null: false
    t.integer "tag",    null: false
  end

  add_index "artist_tag_raw", ["editor"], name: "artist_tag_raw_idx_editor", using: :btree
  add_index "artist_tag_raw", ["tag"], name: "artist_tag_raw_idx_tag", using: :btree

  create_table "artist_type", force: true do |t|
    t.string "name", null: false
  end

  create_table "autoeditor_election", force: true do |t|
    t.integer  "candidate",                      null: false
    t.integer  "proposer",                       null: false
    t.integer  "seconder_1"
    t.integer  "seconder_2"
    t.integer  "status",       default: 1,       null: false
    t.integer  "yes_votes",    default: 0,       null: false
    t.integer  "no_votes",     default: 0,       null: false
    t.datetime "propose_time", default: "now()", null: false
    t.datetime "open_time"
    t.datetime "close_time"
  end

  create_table "autoeditor_election_vote", force: true do |t|
    t.integer  "autoeditor_election",                   null: false
    t.integer  "voter",                                 null: false
    t.integer  "vote",                                  null: false
    t.datetime "vote_time",           default: "now()", null: false
  end

  create_table "cdtoc", force: true do |t|
    t.string   "discid",         limit: 28,                   null: false
    t.string   "freedb_id",      limit: 8,                    null: false
    t.integer  "track_count",                                 null: false
    t.integer  "leadout_offset",                              null: false
    t.integer  "track_offset",                                null: false, array: true
    t.boolean  "degraded",                  default: false,   null: false
    t.datetime "created",                   default: "now()"
  end

  add_index "cdtoc", ["discid"], name: "cdtoc_idx_discid", unique: true, using: :btree
  add_index "cdtoc", ["freedb_id"], name: "cdtoc_idx_freedb_id", using: :btree

  create_table "cdtoc_raw", force: true do |t|
    t.integer "release",                   null: false
    t.string  "discid",         limit: 28, null: false
    t.integer "track_count",               null: false
    t.integer "leadout_offset",            null: false
    t.integer "track_offset",              null: false, array: true
  end

  add_index "cdtoc_raw", ["discid"], name: "cdtoc_raw_discid", using: :btree
  add_index "cdtoc_raw", ["track_count", "leadout_offset", "track_offset"], name: "cdtoc_raw_toc", unique: true, using: :btree
  add_index "cdtoc_raw", ["track_offset"], name: "cdtoc_raw_track_offset", using: :btree

  create_table "country_area", id: false, force: true do |t|
    t.integer "area", null: false
  end

  create_table "edit", force: true do |t|
    t.integer  "editor",                                  null: false
    t.integer  "type",        limit: 2,                   null: false
    t.integer  "status",      limit: 2,                   null: false
    t.text     "data",                                    null: false
    t.integer  "yes_votes",             default: 0,       null: false
    t.integer  "no_votes",              default: 0,       null: false
    t.integer  "autoedit",    limit: 2, default: 0,       null: false
    t.datetime "open_time",             default: "now()"
    t.datetime "close_time"
    t.datetime "expire_time",                             null: false
    t.integer  "language"
    t.integer  "quality",     limit: 2, default: 1,       null: false
  end

  add_index "edit", ["editor", "id"], name: "edit_idx_editor_id_desc", order: {"id"=>:desc}, using: :btree
  add_index "edit", ["editor"], name: "edit_idx_editor", using: :btree
  add_index "edit", ["open_time"], name: "edit_idx_open_edits_open_time", where: "(status = 1)", using: :btree
  add_index "edit", ["open_time"], name: "edit_idx_open_time", using: :btree
  add_index "edit", ["status"], name: "edit_idx_status", where: "(status <> 2)", using: :btree
  add_index "edit", ["type"], name: "edit_idx_type", using: :btree

  create_table "edit_area", id: false, force: true do |t|
    t.integer "edit", null: false
    t.integer "area", null: false
  end

  add_index "edit_area", ["area"], name: "edit_area_idx", using: :btree

  create_table "edit_artist", id: false, force: true do |t|
    t.integer "edit",             null: false
    t.integer "artist",           null: false
    t.integer "status", limit: 2, null: false
  end

  add_index "edit_artist", ["artist"], name: "edit_artist_idx", using: :btree
  add_index "edit_artist", ["status"], name: "edit_artist_idx_status", using: :btree

  create_table "edit_label", id: false, force: true do |t|
    t.integer "edit",             null: false
    t.integer "label",            null: false
    t.integer "status", limit: 2, null: false
  end

  add_index "edit_label", ["label"], name: "edit_label_idx", using: :btree
  add_index "edit_label", ["status"], name: "edit_label_idx_status", using: :btree

  create_table "edit_note", force: true do |t|
    t.integer  "editor",                      null: false
    t.integer  "edit",                        null: false
    t.text     "text",                        null: false
    t.datetime "post_time", default: "now()"
  end

  add_index "edit_note", ["edit"], name: "edit_note_idx_edit", using: :btree

  create_table "edit_place", id: false, force: true do |t|
    t.integer "edit",  null: false
    t.integer "place", null: false
  end

  add_index "edit_place", ["place"], name: "edit_place_idx", using: :btree

  create_table "edit_recording", id: false, force: true do |t|
    t.integer "edit",      null: false
    t.integer "recording", null: false
  end

  add_index "edit_recording", ["recording"], name: "edit_recording_idx", using: :btree

  create_table "edit_release", id: false, force: true do |t|
    t.integer "edit",    null: false
    t.integer "release", null: false
  end

  add_index "edit_release", ["release"], name: "edit_release_idx", using: :btree

  create_table "edit_release_group", id: false, force: true do |t|
    t.integer "edit",          null: false
    t.integer "release_group", null: false
  end

  add_index "edit_release_group", ["release_group"], name: "edit_release_group_idx", using: :btree

  create_table "edit_url", id: false, force: true do |t|
    t.integer "edit", null: false
    t.integer "url",  null: false
  end

  add_index "edit_url", ["url"], name: "edit_url_idx", using: :btree

  create_table "edit_work", id: false, force: true do |t|
    t.integer "edit", null: false
    t.integer "work", null: false
  end

  add_index "edit_work", ["work"], name: "edit_work_idx", using: :btree

  create_table "editor", force: true do |t|
    t.string   "name",                limit: 64,                    null: false
    t.integer  "privs",                           default: 0
    t.string   "email",               limit: 64
    t.string   "website"
    t.text     "bio"
    t.datetime "member_since",                    default: "now()"
    t.datetime "email_confirm_date"
    t.datetime "last_login_date",                 default: "now()"
    t.integer  "edits_accepted",                  default: 0
    t.integer  "edits_rejected",                  default: 0
    t.integer  "auto_edits_accepted",             default: 0
    t.integer  "edits_failed",                    default: 0
    t.datetime "last_updated",                    default: "now()"
    t.date     "birth_date"
    t.integer  "gender"
    t.integer  "area"
    t.string   "password",            limit: 128,                   null: false
    t.string   "ha1",                 limit: 32,                    null: false
    t.boolean  "deleted",                         default: false,   null: false
  end

  create_table "editor_collection", force: true do |t|
    t.uuid    "gid",                                     null: false
    t.integer "editor",                                  null: false
    t.string  "name",        limit: nil,                 null: false
    t.boolean "public",                  default: false, null: false
    t.text    "description",             default: "",    null: false
  end

  add_index "editor_collection", ["editor"], name: "editor_collection_idx_editor", using: :btree
  add_index "editor_collection", ["gid"], name: "editor_collection_idx_gid", unique: true, using: :btree
  add_index "editor_collection", ["name"], name: "editor_collection_idx_name", using: :btree

  create_table "editor_collection_release", id: false, force: true do |t|
    t.integer "collection", null: false
    t.integer "release",    null: false
  end

# Could not dump table "editor_language" because of following StandardError
#   Unknown type 'fluency' for column 'fluency'

  create_table "editor_oauth_token", force: true do |t|
    t.integer  "editor",                               null: false
    t.integer  "application",                          null: false
    t.text     "authorization_code"
    t.text     "refresh_token"
    t.text     "access_token"
    t.text     "mac_key"
    t.integer  "mac_time_diff"
    t.datetime "expire_time",                          null: false
    t.integer  "scope",              default: 0,       null: false
    t.datetime "granted",            default: "now()", null: false
  end

  add_index "editor_oauth_token", ["access_token"], name: "editor_oauth_token_idx_access_token", unique: true, using: :btree
  add_index "editor_oauth_token", ["editor"], name: "editor_oauth_token_idx_editor", using: :btree
  add_index "editor_oauth_token", ["refresh_token"], name: "editor_oauth_token_idx_refresh_token", unique: true, using: :btree

  create_table "editor_preference", force: true do |t|
    t.integer "editor",             null: false
    t.string  "name",   limit: 50,  null: false
    t.string  "value",  limit: 100, null: false
  end

  add_index "editor_preference", ["editor", "name"], name: "editor_preference_idx_editor_name", unique: true, using: :btree

  create_table "editor_subscribe_artist", force: true do |t|
    t.integer "editor",         null: false
    t.integer "artist",         null: false
    t.integer "last_edit_sent", null: false
  end

  add_index "editor_subscribe_artist", ["artist"], name: "editor_subscribe_artist_idx_artist", using: :btree
  add_index "editor_subscribe_artist", ["editor", "artist"], name: "editor_subscribe_artist_idx_uniq", using: :btree

  create_table "editor_subscribe_artist_deleted", id: false, force: true do |t|
    t.integer "editor",     null: false
    t.uuid    "gid",        null: false
    t.integer "deleted_by", null: false
  end

  create_table "editor_subscribe_collection", force: true do |t|
    t.integer "editor",                        null: false
    t.integer "collection",                    null: false
    t.integer "last_edit_sent",                null: false
    t.boolean "available",      default: true, null: false
    t.string  "last_seen_name"
  end

  add_index "editor_subscribe_collection", ["collection"], name: "editor_subscribe_collection_idx_collection", using: :btree
  add_index "editor_subscribe_collection", ["editor", "collection"], name: "editor_subscribe_collection_idx_uniq", unique: true, using: :btree

  create_table "editor_subscribe_editor", force: true do |t|
    t.integer "editor",            null: false
    t.integer "subscribed_editor", null: false
    t.integer "last_edit_sent",    null: false
  end

  add_index "editor_subscribe_editor", ["editor", "subscribed_editor"], name: "editor_subscribe_editor_idx_uniq", using: :btree

  create_table "editor_subscribe_label", force: true do |t|
    t.integer "editor",         null: false
    t.integer "label",          null: false
    t.integer "last_edit_sent", null: false
  end

  add_index "editor_subscribe_label", ["editor", "label"], name: "editor_subscribe_label_idx_uniq", using: :btree
  add_index "editor_subscribe_label", ["label"], name: "editor_subscribe_label_idx_label", using: :btree

  create_table "editor_subscribe_label_deleted", id: false, force: true do |t|
    t.integer "editor",     null: false
    t.uuid    "gid",        null: false
    t.integer "deleted_by", null: false
  end

  create_table "editor_watch_artist", id: false, force: true do |t|
    t.integer "artist", null: false
    t.integer "editor", null: false
  end

  create_table "editor_watch_preferences", id: false, force: true do |t|
    t.integer  "editor",                                                null: false
    t.boolean  "notify_via_email",                   default: true,     null: false
    t.string   "notification_timeframe", limit: nil, default: "7 days", null: false
    t.datetime "last_checked",                       default: "now()",  null: false
  end

  create_table "editor_watch_release_group_type", id: false, force: true do |t|
    t.integer "editor",             null: false
    t.integer "release_group_type", null: false
  end

  create_table "editor_watch_release_status", id: false, force: true do |t|
    t.integer "editor",         null: false
    t.integer "release_status", null: false
  end

  create_table "gender", force: true do |t|
    t.string "name", null: false
  end

  create_table "iso_3166_1", id: false, force: true do |t|
    t.integer "area",           null: false
    t.string  "code", limit: 2, null: false
  end

  add_index "iso_3166_1", ["area"], name: "iso_3166_1_idx_area", using: :btree

  create_table "iso_3166_2", id: false, force: true do |t|
    t.integer "area",            null: false
    t.string  "code", limit: 10, null: false
  end

  add_index "iso_3166_2", ["area"], name: "iso_3166_2_idx_area", using: :btree

  create_table "iso_3166_3", id: false, force: true do |t|
    t.integer "area",           null: false
    t.string  "code", limit: 4, null: false
  end

  add_index "iso_3166_3", ["area"], name: "iso_3166_3_idx_area", using: :btree

  create_table "isrc", force: true do |t|
    t.integer  "recording",                                  null: false
    t.string   "isrc",          limit: 12,                   null: false
    t.integer  "source",        limit: 2
    t.integer  "edits_pending",            default: 0,       null: false
    t.datetime "created",                  default: "now()"
  end

  add_index "isrc", ["isrc", "recording"], name: "isrc_idx_isrc_recording", unique: true, using: :btree
  add_index "isrc", ["isrc"], name: "isrc_idx_isrc", using: :btree
  add_index "isrc", ["recording"], name: "isrc_idx_recording", using: :btree

  create_table "iswc", force: true do |t|
    t.integer  "work",                                       null: false
    t.string   "iswc",          limit: 15
    t.integer  "source",        limit: 2
    t.integer  "edits_pending",            default: 0,       null: false
    t.datetime "created",                  default: "now()", null: false
  end

  add_index "iswc", ["iswc", "work"], name: "iswc_idx_iswc", unique: true, using: :btree
  add_index "iswc", ["work"], name: "iswc_idx_work", using: :btree

  create_table "l_area_area", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_area_area", ["entity0", "entity1", "link"], name: "l_area_area_idx_uniq", unique: true, using: :btree
  add_index "l_area_area", ["entity1"], name: "l_area_area_idx_entity1", using: :btree

  create_table "l_area_artist", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_area_artist", ["entity0", "entity1", "link"], name: "l_area_artist_idx_uniq", unique: true, using: :btree
  add_index "l_area_artist", ["entity1"], name: "l_area_artist_idx_entity1", using: :btree

  create_table "l_area_label", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_area_label", ["entity0", "entity1", "link"], name: "l_area_label_idx_uniq", unique: true, using: :btree
  add_index "l_area_label", ["entity1"], name: "l_area_label_idx_entity1", using: :btree

  create_table "l_area_place", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_area_place", ["entity0", "entity1", "link"], name: "l_area_place_idx_uniq", unique: true, using: :btree
  add_index "l_area_place", ["entity1"], name: "l_area_place_idx_entity1", using: :btree

  create_table "l_area_recording", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_area_recording", ["entity0", "entity1", "link"], name: "l_area_recording_idx_uniq", unique: true, using: :btree
  add_index "l_area_recording", ["entity1"], name: "l_area_recording_idx_entity1", using: :btree

  create_table "l_area_release", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_area_release", ["entity0", "entity1", "link"], name: "l_area_release_idx_uniq", unique: true, using: :btree
  add_index "l_area_release", ["entity1"], name: "l_area_release_idx_entity1", using: :btree

  create_table "l_area_release_group", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_area_release_group", ["entity0", "entity1", "link"], name: "l_area_release_group_idx_uniq", unique: true, using: :btree
  add_index "l_area_release_group", ["entity1"], name: "l_area_release_group_idx_entity1", using: :btree

  create_table "l_area_url", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_area_url", ["entity0", "entity1", "link"], name: "l_area_url_idx_uniq", unique: true, using: :btree
  add_index "l_area_url", ["entity1"], name: "l_area_url_idx_entity1", using: :btree

  create_table "l_area_work", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_area_work", ["entity0", "entity1", "link"], name: "l_area_work_idx_uniq", unique: true, using: :btree
  add_index "l_area_work", ["entity1"], name: "l_area_work_idx_entity1", using: :btree

  create_table "l_artist_artist", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_artist_artist", ["entity0", "entity1", "link"], name: "l_artist_artist_idx_uniq", unique: true, using: :btree
  add_index "l_artist_artist", ["entity1"], name: "l_artist_artist_idx_entity1", using: :btree

  create_table "l_artist_label", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_artist_label", ["entity0", "entity1", "link"], name: "l_artist_label_idx_uniq", unique: true, using: :btree
  add_index "l_artist_label", ["entity1"], name: "l_artist_label_idx_entity1", using: :btree

  create_table "l_artist_place", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_artist_place", ["entity0", "entity1", "link"], name: "l_artist_place_idx_uniq", unique: true, using: :btree
  add_index "l_artist_place", ["entity1"], name: "l_artist_place_idx_entity1", using: :btree

  create_table "l_artist_recording", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_artist_recording", ["entity0", "entity1", "link"], name: "l_artist_recording_idx_uniq", unique: true, using: :btree
  add_index "l_artist_recording", ["entity1"], name: "l_artist_recording_idx_entity1", using: :btree

  create_table "l_artist_release", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_artist_release", ["entity0", "entity1", "link"], name: "l_artist_release_idx_uniq", unique: true, using: :btree
  add_index "l_artist_release", ["entity1"], name: "l_artist_release_idx_entity1", using: :btree

  create_table "l_artist_release_group", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_artist_release_group", ["entity0", "entity1", "link"], name: "l_artist_release_group_idx_uniq", unique: true, using: :btree
  add_index "l_artist_release_group", ["entity1"], name: "l_artist_release_group_idx_entity1", using: :btree

  create_table "l_artist_url", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_artist_url", ["entity0", "entity1", "link"], name: "l_artist_url_idx_uniq", unique: true, using: :btree
  add_index "l_artist_url", ["entity1"], name: "l_artist_url_idx_entity1", using: :btree

  create_table "l_artist_work", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_artist_work", ["entity0", "entity1", "link"], name: "l_artist_work_idx_uniq", unique: true, using: :btree
  add_index "l_artist_work", ["entity1"], name: "l_artist_work_idx_entity1", using: :btree

  create_table "l_label_label", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_label_label", ["entity0", "entity1", "link"], name: "l_label_label_idx_uniq", unique: true, using: :btree
  add_index "l_label_label", ["entity1"], name: "l_label_label_idx_entity1", using: :btree

  create_table "l_label_place", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_label_place", ["entity0", "entity1", "link"], name: "l_label_place_idx_uniq", unique: true, using: :btree
  add_index "l_label_place", ["entity1"], name: "l_label_place_idx_entity1", using: :btree

  create_table "l_label_recording", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_label_recording", ["entity0", "entity1", "link"], name: "l_label_recording_idx_uniq", unique: true, using: :btree
  add_index "l_label_recording", ["entity1"], name: "l_label_recording_idx_entity1", using: :btree

  create_table "l_label_release", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_label_release", ["entity0", "entity1", "link"], name: "l_label_release_idx_uniq", unique: true, using: :btree
  add_index "l_label_release", ["entity1"], name: "l_label_release_idx_entity1", using: :btree

  create_table "l_label_release_group", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_label_release_group", ["entity0", "entity1", "link"], name: "l_label_release_group_idx_uniq", unique: true, using: :btree
  add_index "l_label_release_group", ["entity1"], name: "l_label_release_group_idx_entity1", using: :btree

  create_table "l_label_url", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_label_url", ["entity0", "entity1", "link"], name: "l_label_url_idx_uniq", unique: true, using: :btree
  add_index "l_label_url", ["entity1"], name: "l_label_url_idx_entity1", using: :btree

  create_table "l_label_work", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_label_work", ["entity0", "entity1", "link"], name: "l_label_work_idx_uniq", unique: true, using: :btree
  add_index "l_label_work", ["entity1"], name: "l_label_work_idx_entity1", using: :btree

  create_table "l_place_place", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_place_place", ["entity0", "entity1", "link"], name: "l_place_place_idx_uniq", unique: true, using: :btree
  add_index "l_place_place", ["entity1"], name: "l_place_place_idx_entity1", using: :btree

  create_table "l_place_recording", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_place_recording", ["entity0", "entity1", "link"], name: "l_place_recording_idx_uniq", unique: true, using: :btree
  add_index "l_place_recording", ["entity1"], name: "l_place_recording_idx_entity1", using: :btree

  create_table "l_place_release", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_place_release", ["entity0", "entity1", "link"], name: "l_place_release_idx_uniq", unique: true, using: :btree
  add_index "l_place_release", ["entity1"], name: "l_place_release_idx_entity1", using: :btree

  create_table "l_place_release_group", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_place_release_group", ["entity0", "entity1", "link"], name: "l_place_release_group_idx_uniq", unique: true, using: :btree
  add_index "l_place_release_group", ["entity1"], name: "l_place_release_group_idx_entity1", using: :btree

  create_table "l_place_url", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_place_url", ["entity0", "entity1", "link"], name: "l_place_url_idx_uniq", unique: true, using: :btree
  add_index "l_place_url", ["entity1"], name: "l_place_url_idx_entity1", using: :btree

  create_table "l_place_work", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_place_work", ["entity0", "entity1", "link"], name: "l_place_work_idx_uniq", unique: true, using: :btree
  add_index "l_place_work", ["entity1"], name: "l_place_work_idx_entity1", using: :btree

  create_table "l_recording_recording", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_recording_recording", ["entity0", "entity1", "link"], name: "l_recording_recording_idx_uniq", unique: true, using: :btree
  add_index "l_recording_recording", ["entity1"], name: "l_recording_recording_idx_entity1", using: :btree

  create_table "l_recording_release", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_recording_release", ["entity0", "entity1", "link"], name: "l_recording_release_idx_uniq", unique: true, using: :btree
  add_index "l_recording_release", ["entity1"], name: "l_recording_release_idx_entity1", using: :btree

  create_table "l_recording_release_group", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_recording_release_group", ["entity0", "entity1", "link"], name: "l_recording_release_group_idx_uniq", unique: true, using: :btree
  add_index "l_recording_release_group", ["entity1"], name: "l_recording_release_group_idx_entity1", using: :btree

  create_table "l_recording_url", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_recording_url", ["entity0", "entity1", "link"], name: "l_recording_url_idx_uniq", unique: true, using: :btree
  add_index "l_recording_url", ["entity1"], name: "l_recording_url_idx_entity1", using: :btree

  create_table "l_recording_work", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_recording_work", ["entity0", "entity1", "link"], name: "l_recording_work_idx_uniq", unique: true, using: :btree
  add_index "l_recording_work", ["entity1"], name: "l_recording_work_idx_entity1", using: :btree

  create_table "l_release_group_release_group", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_release_group_release_group", ["entity0", "entity1", "link"], name: "l_release_group_release_group_idx_uniq", unique: true, using: :btree
  add_index "l_release_group_release_group", ["entity1"], name: "l_release_group_release_group_idx_entity1", using: :btree

  create_table "l_release_group_url", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_release_group_url", ["entity0", "entity1", "link"], name: "l_release_group_url_idx_uniq", unique: true, using: :btree
  add_index "l_release_group_url", ["entity1"], name: "l_release_group_url_idx_entity1", using: :btree

  create_table "l_release_group_work", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_release_group_work", ["entity0", "entity1", "link"], name: "l_release_group_work_idx_uniq", unique: true, using: :btree
  add_index "l_release_group_work", ["entity1"], name: "l_release_group_work_idx_entity1", using: :btree

  create_table "l_release_release", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_release_release", ["entity0", "entity1", "link"], name: "l_release_release_idx_uniq", unique: true, using: :btree
  add_index "l_release_release", ["entity1"], name: "l_release_release_idx_entity1", using: :btree

  create_table "l_release_release_group", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_release_release_group", ["entity0", "entity1", "link"], name: "l_release_release_group_idx_uniq", unique: true, using: :btree
  add_index "l_release_release_group", ["entity1"], name: "l_release_release_group_idx_entity1", using: :btree

  create_table "l_release_url", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_release_url", ["entity0", "entity1", "link"], name: "l_release_url_idx_uniq", unique: true, using: :btree
  add_index "l_release_url", ["entity1"], name: "l_release_url_idx_entity1", using: :btree

  create_table "l_release_work", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_release_work", ["entity0", "entity1", "link"], name: "l_release_work_idx_uniq", unique: true, using: :btree
  add_index "l_release_work", ["entity1"], name: "l_release_work_idx_entity1", using: :btree

  create_table "l_url_url", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_url_url", ["entity0", "entity1", "link"], name: "l_url_url_idx_uniq", unique: true, using: :btree
  add_index "l_url_url", ["entity1"], name: "l_url_url_idx_entity1", using: :btree

  create_table "l_url_work", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_url_work", ["entity0", "entity1", "link"], name: "l_url_work_idx_uniq", unique: true, using: :btree
  add_index "l_url_work", ["entity1"], name: "l_url_work_idx_entity1", using: :btree

  create_table "l_work_work", force: true do |t|
    t.integer  "link",                            null: false
    t.integer  "entity0",                         null: false
    t.integer  "entity1",                         null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "l_work_work", ["entity0", "entity1", "link"], name: "l_work_work_idx_uniq", unique: true, using: :btree
  add_index "l_work_work", ["entity1"], name: "l_work_work_idx_entity1", using: :btree

  create_table "label", force: true do |t|
    t.uuid     "gid",                                            null: false
    t.string   "name",             limit: nil,                   null: false
    t.string   "sort_name",        limit: nil,                   null: false
    t.integer  "begin_date_year",  limit: 2
    t.integer  "begin_date_month", limit: 2
    t.integer  "begin_date_day",   limit: 2
    t.integer  "end_date_year",    limit: 2
    t.integer  "end_date_month",   limit: 2
    t.integer  "end_date_day",     limit: 2
    t.integer  "label_code"
    t.integer  "type"
    t.integer  "area"
    t.string   "comment",                      default: "",      null: false
    t.integer  "edits_pending",                default: 0,       null: false
    t.datetime "last_updated",                 default: "now()"
    t.boolean  "ended",                        default: false,   null: false
  end

  add_index "label", ["area"], name: "label_idx_area", using: :btree
  add_index "label", ["gid"], name: "label_idx_gid", unique: true, using: :btree
  add_index "label", ["name", "comment"], name: "label_idx_uniq_name_comment", unique: true, where: "(comment IS NOT NULL)", using: :btree
  add_index "label", ["name"], name: "label_idx_name", using: :btree
  add_index "label", ["name"], name: "label_idx_null_comment", unique: true, where: "(comment IS NULL)", using: :btree
  add_index "label", ["sort_name"], name: "label_idx_sort_name", using: :btree

  create_table "label_alias", force: true do |t|
    t.integer  "label",                                            null: false
    t.string   "name",               limit: nil,                   null: false
    t.text     "locale"
    t.integer  "edits_pending",                  default: 0,       null: false
    t.datetime "last_updated",                   default: "now()"
    t.integer  "type"
    t.string   "sort_name",          limit: nil,                   null: false
    t.integer  "begin_date_year",    limit: 2
    t.integer  "begin_date_month",   limit: 2
    t.integer  "begin_date_day",     limit: 2
    t.integer  "end_date_year",      limit: 2
    t.integer  "end_date_month",     limit: 2
    t.integer  "end_date_day",       limit: 2
    t.boolean  "primary_for_locale",             default: false,   null: false
    t.boolean  "ended",                          default: false,   null: false
  end

  add_index "label_alias", ["label", "locale"], name: "label_alias_idx_primary", unique: true, where: "((primary_for_locale = true) AND (locale IS NOT NULL))", using: :btree
  add_index "label_alias", ["label"], name: "label_alias_idx_label", using: :btree

  create_table "label_alias_type", force: true do |t|
    t.text "name", null: false
  end

  create_table "label_annotation", id: false, force: true do |t|
    t.integer "label",      null: false
    t.integer "annotation", null: false
  end

  create_table "label_deletion", id: false, force: true do |t|
    t.uuid     "gid",                                              null: false
    t.string   "last_known_name",    limit: nil,                   null: false
    t.text     "last_known_comment",                               null: false
    t.datetime "deleted_at",                     default: "now()", null: false
  end

  create_table "label_gid_redirect", id: false, force: true do |t|
    t.uuid     "gid",                       null: false
    t.integer  "new_id",                    null: false
    t.datetime "created", default: "now()"
  end

  create_table "label_ipi", id: false, force: true do |t|
    t.integer  "label",                                      null: false
    t.string   "ipi",           limit: 11,                   null: false
    t.integer  "edits_pending",            default: 0,       null: false
    t.datetime "created",                  default: "now()"
  end

  create_table "label_isni", id: false, force: true do |t|
    t.integer  "label",                                      null: false
    t.string   "isni",          limit: 16,                   null: false
    t.integer  "edits_pending",            default: 0,       null: false
    t.datetime "created",                  default: "now()"
  end

  create_table "label_meta", id: false, force: true do |t|
    t.integer "id",                     null: false
    t.integer "rating",       limit: 2
    t.integer "rating_count"
  end

  create_table "label_rating_raw", id: false, force: true do |t|
    t.integer "label",            null: false
    t.integer "editor",           null: false
    t.integer "rating", limit: 2, null: false
  end

  add_index "label_rating_raw", ["editor"], name: "label_rating_raw_idx_editor", using: :btree
  add_index "label_rating_raw", ["label"], name: "label_rating_raw_idx_label", using: :btree

  create_table "label_tag", id: false, force: true do |t|
    t.integer  "label",                          null: false
    t.integer  "tag",                            null: false
    t.integer  "count",                          null: false
    t.datetime "last_updated", default: "now()"
  end

  add_index "label_tag", ["tag"], name: "label_tag_idx_tag", using: :btree

  create_table "label_tag_raw", id: false, force: true do |t|
    t.integer "label",  null: false
    t.integer "editor", null: false
    t.integer "tag",    null: false
  end

  add_index "label_tag_raw", ["editor"], name: "label_tag_raw_idx_editor", using: :btree
  add_index "label_tag_raw", ["tag"], name: "label_tag_raw_idx_tag", using: :btree

  create_table "label_type", force: true do |t|
    t.string "name", null: false
  end

  create_table "language", force: true do |t|
    t.string  "iso_code_2t", limit: 3
    t.string  "iso_code_2b", limit: 3
    t.string  "iso_code_1",  limit: 2
    t.string  "name",        limit: 100,             null: false
    t.integer "frequency",               default: 0, null: false
    t.string  "iso_code_3",  limit: 3
  end

  add_index "language", ["iso_code_1"], name: "language_idx_iso_code_1", unique: true, using: :btree
  add_index "language", ["iso_code_2b"], name: "language_idx_iso_code_2b", unique: true, using: :btree
  add_index "language", ["iso_code_2t"], name: "language_idx_iso_code_2t", unique: true, using: :btree
  add_index "language", ["iso_code_3"], name: "language_idx_iso_code_3", unique: true, using: :btree

  create_table "link", force: true do |t|
    t.integer  "link_type",                                    null: false
    t.integer  "begin_date_year",  limit: 2
    t.integer  "begin_date_month", limit: 2
    t.integer  "begin_date_day",   limit: 2
    t.integer  "end_date_year",    limit: 2
    t.integer  "end_date_month",   limit: 2
    t.integer  "end_date_day",     limit: 2
    t.integer  "attribute_count",            default: 0,       null: false
    t.datetime "created",                    default: "now()"
    t.boolean  "ended",                      default: false,   null: false
  end

  add_index "link", ["link_type", "attribute_count"], name: "link_idx_type_attr", using: :btree

  create_table "link_attribute", id: false, force: true do |t|
    t.integer  "link",                             null: false
    t.integer  "attribute_type",                   null: false
    t.datetime "created",        default: "now()"
  end

  create_table "link_attribute_credit", id: false, force: true do |t|
    t.integer "link",           null: false
    t.integer "attribute_type", null: false
    t.text    "credited_as",    null: false
  end

  create_table "link_attribute_type", force: true do |t|
    t.integer  "parent"
    t.integer  "root",                           null: false
    t.integer  "child_order",  default: 0,       null: false
    t.uuid     "gid",                            null: false
    t.string   "name",                           null: false
    t.text     "description"
    t.datetime "last_updated", default: "now()"
  end

  add_index "link_attribute_type", ["gid"], name: "link_attribute_type_idx_gid", unique: true, using: :btree

  create_table "link_creditable_attribute_type", id: false, force: true do |t|
    t.integer "attribute_type", null: false
  end

  create_table "link_type", force: true do |t|
    t.integer  "parent"
    t.integer  "child_order",                    default: 0,       null: false
    t.uuid     "gid",                                              null: false
    t.string   "entity_type0",        limit: 50,                   null: false
    t.string   "entity_type1",        limit: 50,                   null: false
    t.string   "name",                                             null: false
    t.text     "description"
    t.string   "link_phrase",                                      null: false
    t.string   "reverse_link_phrase",                              null: false
    t.string   "long_link_phrase",                                 null: false
    t.integer  "priority",                       default: 0,       null: false
    t.datetime "last_updated",                   default: "now()"
    t.boolean  "is_deprecated",                  default: false,   null: false
  end

  add_index "link_type", ["gid"], name: "link_type_idx_gid", unique: true, using: :btree

  create_table "link_type_attribute_type", id: false, force: true do |t|
    t.integer  "link_type",                                  null: false
    t.integer  "attribute_type",                             null: false
    t.integer  "min",            limit: 2
    t.integer  "max",            limit: 2
    t.datetime "last_updated",             default: "now()"
  end

  create_table "medium", force: true do |t|
    t.integer  "release",                         null: false
    t.integer  "position",                        null: false
    t.integer  "format"
    t.string   "name"
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
    t.integer  "track_count",   default: 0,       null: false
  end

  add_index "medium", ["release"], name: "medium_idx_release", using: :btree
  add_index "medium", ["track_count"], name: "medium_idx_track_count", using: :btree

  create_table "medium_cdtoc", force: true do |t|
    t.integer  "medium",                          null: false
    t.integer  "cdtoc",                           null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "medium_cdtoc", ["cdtoc"], name: "medium_cdtoc_idx_cdtoc", using: :btree
  add_index "medium_cdtoc", ["medium", "cdtoc"], name: "medium_cdtoc_idx_uniq", unique: true, using: :btree
  add_index "medium_cdtoc", ["medium"], name: "medium_cdtoc_idx_medium", using: :btree

  create_table "medium_format", force: true do |t|
    t.string  "name",        limit: 100,                 null: false
    t.integer "parent"
    t.integer "child_order",             default: 0,     null: false
    t.integer "year",        limit: 2
    t.boolean "has_discids",             default: false, null: false
  end

  create_table "medium_index", id: false, force: true do |t|
    t.integer "medium", null: false
    t.text    "toc"
  end

  create_table "place", force: true do |t|
    t.uuid     "gid",                                            null: false
    t.string   "name",             limit: nil,                   null: false
    t.integer  "type"
    t.string   "address",          limit: nil, default: "",      null: false
    t.integer  "area"
    t.string   "coordinates",      limit: nil
    t.string   "comment",                      default: "",      null: false
    t.integer  "edits_pending",                default: 0,       null: false
    t.datetime "last_updated",                 default: "now()"
    t.integer  "begin_date_year",  limit: 2
    t.integer  "begin_date_month", limit: 2
    t.integer  "begin_date_day",   limit: 2
    t.integer  "end_date_year",    limit: 2
    t.integer  "end_date_month",   limit: 2
    t.integer  "end_date_day",     limit: 2
    t.boolean  "ended",                        default: false,   null: false
  end

  add_index "place", ["area"], name: "place_idx_area", using: :btree
  add_index "place", ["gid"], name: "place_idx_gid", unique: true, using: :btree
  add_index "place", ["name"], name: "place_idx_name", using: :btree

  create_table "place_alias", force: true do |t|
    t.integer  "place",                                            null: false
    t.string   "name",               limit: nil,                   null: false
    t.text     "locale"
    t.integer  "edits_pending",                  default: 0,       null: false
    t.datetime "last_updated",                   default: "now()"
    t.integer  "type"
    t.string   "sort_name",          limit: nil,                   null: false
    t.integer  "begin_date_year",    limit: 2
    t.integer  "begin_date_month",   limit: 2
    t.integer  "begin_date_day",     limit: 2
    t.integer  "end_date_year",      limit: 2
    t.integer  "end_date_month",     limit: 2
    t.integer  "end_date_day",       limit: 2
    t.boolean  "primary_for_locale",             default: false,   null: false
    t.boolean  "ended",                          default: false,   null: false
  end

  add_index "place_alias", ["place", "locale"], name: "place_alias_idx_primary", unique: true, where: "((primary_for_locale = true) AND (locale IS NOT NULL))", using: :btree
  add_index "place_alias", ["place"], name: "place_alias_idx_place", using: :btree

  create_table "place_alias_type", force: true do |t|
    t.text "name", null: false
  end

  create_table "place_annotation", id: false, force: true do |t|
    t.integer "place",      null: false
    t.integer "annotation", null: false
  end

  create_table "place_gid_redirect", id: false, force: true do |t|
    t.uuid     "gid",                       null: false
    t.integer  "new_id",                    null: false
    t.datetime "created", default: "now()"
  end

  create_table "place_tag", id: false, force: true do |t|
    t.integer  "place",                          null: false
    t.integer  "tag",                            null: false
    t.integer  "count",                          null: false
    t.datetime "last_updated", default: "now()"
  end

  add_index "place_tag", ["tag"], name: "place_tag_idx_tag", using: :btree

  create_table "place_tag_raw", id: false, force: true do |t|
    t.integer "place",  null: false
    t.integer "editor", null: false
    t.integer "tag",    null: false
  end

  add_index "place_tag_raw", ["editor"], name: "place_tag_raw_idx_editor", using: :btree
  add_index "place_tag_raw", ["tag"], name: "place_tag_raw_idx_tag", using: :btree

  create_table "place_type", force: true do |t|
    t.string "name", null: false
  end

  create_table "recording", force: true do |t|
    t.uuid     "gid",                                         null: false
    t.string   "name",          limit: nil,                   null: false
    t.integer  "artist_credit",                               null: false
    t.integer  "length"
    t.string   "comment",                   default: "",      null: false
    t.integer  "edits_pending",             default: 0,       null: false
    t.datetime "last_updated",              default: "now()"
    t.boolean  "video",                     default: false,   null: false
  end

  add_index "recording", ["artist_credit"], name: "recording_idx_artist_credit", using: :btree
  add_index "recording", ["gid"], name: "recording_idx_gid", unique: true, using: :btree
  add_index "recording", ["name"], name: "recording_idx_name", using: :btree

  create_table "recording_annotation", id: false, force: true do |t|
    t.integer "recording",  null: false
    t.integer "annotation", null: false
  end

  create_table "recording_gid_redirect", id: false, force: true do |t|
    t.uuid     "gid",                       null: false
    t.integer  "new_id",                    null: false
    t.datetime "created", default: "now()"
  end

  create_table "recording_meta", id: false, force: true do |t|
    t.integer "id",                     null: false
    t.integer "rating",       limit: 2
    t.integer "rating_count"
  end

  create_table "recording_rating_raw", id: false, force: true do |t|
    t.integer "recording",           null: false
    t.integer "editor",              null: false
    t.integer "rating",    limit: 2, null: false
  end

  add_index "recording_rating_raw", ["editor"], name: "recording_rating_raw_idx_editor", using: :btree

  create_table "recording_tag", id: false, force: true do |t|
    t.integer  "recording",                      null: false
    t.integer  "tag",                            null: false
    t.integer  "count",                          null: false
    t.datetime "last_updated", default: "now()"
  end

  add_index "recording_tag", ["tag"], name: "recording_tag_idx_tag", using: :btree

  create_table "recording_tag_raw", id: false, force: true do |t|
    t.integer "recording", null: false
    t.integer "editor",    null: false
    t.integer "tag",       null: false
  end

  add_index "recording_tag_raw", ["editor"], name: "recording_tag_raw_idx_editor", using: :btree
  add_index "recording_tag_raw", ["recording"], name: "recording_tag_raw_idx_track", using: :btree
  add_index "recording_tag_raw", ["tag"], name: "recording_tag_raw_idx_tag", using: :btree

  create_table "release", force: true do |t|
    t.uuid     "gid",                                         null: false
    t.string   "name",          limit: nil,                   null: false
    t.integer  "artist_credit",                               null: false
    t.integer  "release_group",                               null: false
    t.integer  "status"
    t.integer  "packaging"
    t.integer  "language"
    t.integer  "script"
    t.string   "barcode"
    t.string   "comment",                   default: "",      null: false
    t.integer  "edits_pending",             default: 0,       null: false
    t.integer  "quality",       limit: 2,   default: -1,      null: false
    t.datetime "last_updated",              default: "now()"
  end

  add_index "release", ["artist_credit"], name: "release_idx_artist_credit", using: :btree
  add_index "release", ["gid"], name: "release_idx_gid", unique: true, using: :btree
  add_index "release", ["name"], name: "release_idx_name", using: :btree
  add_index "release", ["release_group"], name: "release_idx_release_group", using: :btree

  create_table "release_annotation", id: false, force: true do |t|
    t.integer "release",    null: false
    t.integer "annotation", null: false
  end

  create_table "release_country", id: false, force: true do |t|
    t.integer "release",              null: false
    t.integer "country",              null: false
    t.integer "date_year",  limit: 2
    t.integer "date_month", limit: 2
    t.integer "date_day",   limit: 2
  end

  add_index "release_country", ["country"], name: "release_country_idx_country", using: :btree

  create_table "release_coverart", id: false, force: true do |t|
    t.integer  "id",            null: false
    t.datetime "last_updated"
    t.string   "cover_art_url"
  end

  create_table "release_gid_redirect", id: false, force: true do |t|
    t.uuid     "gid",                       null: false
    t.integer  "new_id",                    null: false
    t.datetime "created", default: "now()"
  end

  create_table "release_group", force: true do |t|
    t.uuid     "gid",                                         null: false
    t.string   "name",          limit: nil,                   null: false
    t.integer  "artist_credit",                               null: false
    t.integer  "type"
    t.string   "comment",                   default: "",      null: false
    t.integer  "edits_pending",             default: 0,       null: false
    t.datetime "last_updated",              default: "now()"
  end

  add_index "release_group", ["artist_credit"], name: "release_group_idx_artist_credit", using: :btree
  add_index "release_group", ["gid"], name: "release_group_idx_gid", unique: true, using: :btree
  add_index "release_group", ["name"], name: "release_group_idx_name", using: :btree

  create_table "release_group_annotation", id: false, force: true do |t|
    t.integer "release_group", null: false
    t.integer "annotation",    null: false
  end

  create_table "release_group_gid_redirect", id: false, force: true do |t|
    t.uuid     "gid",                       null: false
    t.integer  "new_id",                    null: false
    t.datetime "created", default: "now()"
  end

  create_table "release_group_meta", id: false, force: true do |t|
    t.integer "id",                                             null: false
    t.integer "release_count",                      default: 0, null: false
    t.integer "first_release_date_year",  limit: 2
    t.integer "first_release_date_month", limit: 2
    t.integer "first_release_date_day",   limit: 2
    t.integer "rating",                   limit: 2
    t.integer "rating_count"
  end

  create_table "release_group_primary_type", force: true do |t|
    t.string "name", null: false
  end

  create_table "release_group_rating_raw", id: false, force: true do |t|
    t.integer "release_group",           null: false
    t.integer "editor",                  null: false
    t.integer "rating",        limit: 2, null: false
  end

  add_index "release_group_rating_raw", ["editor"], name: "release_group_rating_raw_idx_editor", using: :btree
  add_index "release_group_rating_raw", ["release_group"], name: "release_group_rating_raw_idx_release_group", using: :btree

  create_table "release_group_secondary_type", force: true do |t|
    t.text "name", null: false
  end

  create_table "release_group_secondary_type_join", id: false, force: true do |t|
    t.integer  "release_group",                    null: false
    t.integer  "secondary_type",                   null: false
    t.datetime "created",        default: "now()", null: false
  end

  create_table "release_group_tag", id: false, force: true do |t|
    t.integer  "release_group",                   null: false
    t.integer  "tag",                             null: false
    t.integer  "count",                           null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "release_group_tag", ["tag"], name: "release_group_tag_idx_tag", using: :btree

  create_table "release_group_tag_raw", id: false, force: true do |t|
    t.integer "release_group", null: false
    t.integer "editor",        null: false
    t.integer "tag",           null: false
  end

  add_index "release_group_tag_raw", ["editor"], name: "release_group_tag_raw_idx_editor", using: :btree
  add_index "release_group_tag_raw", ["tag"], name: "release_group_tag_raw_idx_tag", using: :btree

  create_table "release_label", force: true do |t|
    t.integer  "release",                          null: false
    t.integer  "label"
    t.string   "catalog_number"
    t.datetime "last_updated",   default: "now()"
  end

  add_index "release_label", ["label"], name: "release_label_idx_label", using: :btree
  add_index "release_label", ["release"], name: "release_label_idx_release", using: :btree

# Could not dump table "release_meta" because of following StandardError
#   Unknown type 'cover_art_presence' for column 'cover_art_presence'

  create_table "release_packaging", force: true do |t|
    t.string "name", null: false
  end

  create_table "release_raw", force: true do |t|
    t.string   "title",                           null: false
    t.string   "artist"
    t.datetime "added",         default: "now()"
    t.datetime "last_modified", default: "now()"
    t.integer  "lookup_count",  default: 0
    t.integer  "modify_count",  default: 0
    t.integer  "source",        default: 0
    t.string   "barcode"
    t.string   "comment",       default: "",      null: false
  end

  add_index "release_raw", ["last_modified"], name: "release_raw_idx_last_modified", using: :btree
  add_index "release_raw", ["lookup_count"], name: "release_raw_idx_lookup_count", using: :btree
  add_index "release_raw", ["modify_count"], name: "release_raw_idx_modify_count", using: :btree

  create_table "release_status", force: true do |t|
    t.string "name", null: false
  end

  create_table "release_tag", id: false, force: true do |t|
    t.integer  "release",                        null: false
    t.integer  "tag",                            null: false
    t.integer  "count",                          null: false
    t.datetime "last_updated", default: "now()"
  end

  add_index "release_tag", ["tag"], name: "release_tag_idx_tag", using: :btree

  create_table "release_tag_raw", id: false, force: true do |t|
    t.integer "release", null: false
    t.integer "editor",  null: false
    t.integer "tag",     null: false
  end

  add_index "release_tag_raw", ["editor"], name: "release_tag_raw_idx_editor", using: :btree
  add_index "release_tag_raw", ["tag"], name: "release_tag_raw_idx_tag", using: :btree

  create_table "release_unknown_country", id: false, force: true do |t|
    t.integer "release",              null: false
    t.integer "date_year",  limit: 2
    t.integer "date_month", limit: 2
    t.integer "date_day",   limit: 2
  end

  create_table "replication_control", force: true do |t|
    t.integer  "current_schema_sequence",      null: false
    t.integer  "current_replication_sequence"
    t.datetime "last_replication_date"
  end

  create_table "script", force: true do |t|
    t.string  "iso_code",   limit: 4,               null: false
    t.string  "iso_number", limit: 3,               null: false
    t.string  "name",       limit: 100,             null: false
    t.integer "frequency",              default: 0, null: false
  end

  add_index "script", ["iso_code"], name: "script_idx_iso_code", unique: true, using: :btree

  create_table "script_language", force: true do |t|
    t.integer "script",                null: false
    t.integer "language",              null: false
    t.integer "frequency", default: 0, null: false
  end

  create_table "tag", force: true do |t|
    t.string  "name",                  null: false
    t.integer "ref_count", default: 0, null: false
  end

  add_index "tag", ["name"], name: "tag_idx_name", unique: true, using: :btree

  create_table "tag_relation", id: false, force: true do |t|
    t.integer  "tag1",                           null: false
    t.integer  "tag2",                           null: false
    t.integer  "weight",                         null: false
    t.datetime "last_updated", default: "now()"
  end

  create_table "track", force: true do |t|
    t.uuid     "gid",                                         null: false
    t.integer  "recording",                                   null: false
    t.integer  "medium",                                      null: false
    t.integer  "position",                                    null: false
    t.text     "number",                                      null: false
    t.string   "name",          limit: nil,                   null: false
    t.integer  "artist_credit",                               null: false
    t.integer  "length"
    t.integer  "edits_pending",             default: 0,       null: false
    t.datetime "last_updated",              default: "now()"
  end

  add_index "track", ["artist_credit"], name: "track_idx_artist_credit", using: :btree
  add_index "track", ["gid"], name: "track_idx_gid", unique: true, using: :btree
  add_index "track", ["medium", "position"], name: "track_idx_medium", using: :btree
  add_index "track", ["name"], name: "track_idx_name", using: :btree
  add_index "track", ["recording"], name: "track_idx_recording", using: :btree

  create_table "track_gid_redirect", id: false, force: true do |t|
    t.uuid     "gid",                       null: false
    t.integer  "new_id",                    null: false
    t.datetime "created", default: "now()"
  end

  create_table "track_raw", force: true do |t|
    t.integer "release",  null: false
    t.string  "title",    null: false
    t.string  "artist"
    t.integer "sequence", null: false
  end

  add_index "track_raw", ["release"], name: "track_raw_idx_release", using: :btree

  create_table "url", force: true do |t|
    t.uuid     "gid",                             null: false
    t.text     "url",                             null: false
    t.integer  "edits_pending", default: 0,       null: false
    t.datetime "last_updated",  default: "now()"
  end

  add_index "url", ["gid"], name: "url_idx_gid", unique: true, using: :btree
  add_index "url", ["url"], name: "url_idx_url", unique: true, using: :btree

  create_table "url_gid_redirect", id: false, force: true do |t|
    t.uuid     "gid",                       null: false
    t.integer  "new_id",                    null: false
    t.datetime "created", default: "now()"
  end

  create_table "vote", force: true do |t|
    t.integer  "editor",                                 null: false
    t.integer  "edit",                                   null: false
    t.integer  "vote",       limit: 2,                   null: false
    t.datetime "vote_time",            default: "now()"
    t.boolean  "superseded",           default: false,   null: false
  end

  add_index "vote", ["edit"], name: "vote_idx_edit", using: :btree
  add_index "vote", ["editor"], name: "vote_idx_editor", using: :btree
  add_index "vote", ["vote_time"], name: "edit_idx_vote_time", using: :btree

  create_table "work", force: true do |t|
    t.uuid     "gid",                                         null: false
    t.string   "name",          limit: nil,                   null: false
    t.integer  "type"
    t.string   "comment",                   default: "",      null: false
    t.integer  "edits_pending",             default: 0,       null: false
    t.datetime "last_updated",              default: "now()"
    t.integer  "language"
  end

  add_index "work", ["gid"], name: "work_idx_gid", unique: true, using: :btree
  add_index "work", ["name"], name: "work_idx_name", using: :btree

  create_table "work_alias", force: true do |t|
    t.integer  "work",                                             null: false
    t.string   "name",               limit: nil,                   null: false
    t.text     "locale"
    t.integer  "edits_pending",                  default: 0,       null: false
    t.datetime "last_updated",                   default: "now()"
    t.integer  "type"
    t.string   "sort_name",          limit: nil,                   null: false
    t.integer  "begin_date_year",    limit: 2
    t.integer  "begin_date_month",   limit: 2
    t.integer  "begin_date_day",     limit: 2
    t.integer  "end_date_year",      limit: 2
    t.integer  "end_date_month",     limit: 2
    t.integer  "end_date_day",       limit: 2
    t.boolean  "primary_for_locale",             default: false,   null: false
    t.boolean  "ended",                          default: false,   null: false
  end

  add_index "work_alias", ["work", "locale"], name: "work_alias_idx_primary", unique: true, where: "((primary_for_locale = true) AND (locale IS NOT NULL))", using: :btree
  add_index "work_alias", ["work"], name: "work_alias_idx_work", using: :btree

  create_table "work_alias_type", force: true do |t|
    t.text "name", null: false
  end

  create_table "work_annotation", id: false, force: true do |t|
    t.integer "work",       null: false
    t.integer "annotation", null: false
  end

  create_table "work_attribute", force: true do |t|
    t.integer "work",                              null: false
    t.integer "work_attribute_type",               null: false
    t.integer "work_attribute_type_allowed_value"
    t.text    "work_attribute_text"
  end

  add_index "work_attribute", ["work"], name: "work_attribute_idx_work", using: :btree

  create_table "work_attribute_type", force: true do |t|
    t.string  "name",                   null: false
    t.string  "comment",   default: "", null: false
    t.boolean "free_text",              null: false
  end

  create_table "work_attribute_type_allowed_value", force: true do |t|
    t.integer "work_attribute_type", null: false
    t.text    "value"
  end

  add_index "work_attribute_type_allowed_value", ["work_attribute_type"], name: "work_attribute_type_allowed_value_idx_name", using: :btree

  create_table "work_gid_redirect", id: false, force: true do |t|
    t.uuid     "gid",                       null: false
    t.integer  "new_id",                    null: false
    t.datetime "created", default: "now()"
  end

  create_table "work_meta", id: false, force: true do |t|
    t.integer "id",                     null: false
    t.integer "rating",       limit: 2
    t.integer "rating_count"
  end

  create_table "work_rating_raw", id: false, force: true do |t|
    t.integer "work",             null: false
    t.integer "editor",           null: false
    t.integer "rating", limit: 2, null: false
  end

  create_table "work_tag", id: false, force: true do |t|
    t.integer  "work",                           null: false
    t.integer  "tag",                            null: false
    t.integer  "count",                          null: false
    t.datetime "last_updated", default: "now()"
  end

  add_index "work_tag", ["tag"], name: "work_tag_idx_tag", using: :btree

  create_table "work_tag_raw", id: false, force: true do |t|
    t.integer "work",   null: false
    t.integer "editor", null: false
    t.integer "tag",    null: false
  end

  add_index "work_tag_raw", ["tag"], name: "work_tag_raw_idx_tag", using: :btree

  create_table "work_type", force: true do |t|
    t.string "name", null: false
  end

end
