require 'pg'

class PagesController < ApplicationController

    # db_url = 'postgres://postgres:Test1234@1ca6-194-33-45-162.ngrok-free.app/rootlydemobot'
    # db_url = 'postgres://postgres:Test1234@localhost:5432/rootlydemobot'
    
    # puts "PostgreSQL database URL: #{db_url}"

    # db = PG.connect(db_url)
    # table_name = "incidents"
    # result = db.exec("SELECT to_regclass('#{table_name}')")

    # if result[0]["to_regclass"] == nil
    #     db.create_table :incidents do |t|
    #       t.string "title"
    #       t.string "description"
    #       t.string "severity"
    #       t.string "created_by"
    #       t.integer "resolved"
    #       t.string "resolved_by"
    #       t.datetime "resolved_at"
    #       t.string "channel_id"
    #     end
    # else
    #     result = db.exec("SELECT * FROM incidents")
    # end
      
    # # Print the result
    # result.each do |row|
    #     puts row['title']
    # end

    # # Close the database connection
    # db.close

    def index
        @incidents = Incident.all
    end

end
