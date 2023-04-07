class PagesController < ApplicationController

    def index
        @incidents = Incident.all
    end

end
