# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_16_202642) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "breweries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6 #,null: false
    t.datetime "updated_at", precision: 6 #,null: false
    t.integer "yelp_id"
    t.string "city"
    t.string "state"
  end

end

#after submitting form data
# @brewery #outputs the form data 
# @brewery = YelpApi.search("Montclair Brewing Company", "New Jersey") #outputs yelp api data 
# @brewery.first = {"businesses"=>[{all the data}]}
# businesses = @brewery.first
# businesses.last = all the data array, after business key 
# array = businesses.last 
# array.first = accesses the hash inside the array that contains the information I want (name and location). Location has it's own hash with city and state nested inside
# array[0 => 2] TypeError Exception: no implicit conversion of Hash into Integer
# array[0][2] nil
# array[0][:2]SyntaxError Exception: (byebug):1: syntax error, unexpected integer literal
# array[0] is the hash. [2] is the index within the hash that has "name" => "Montclair Brewing Co"