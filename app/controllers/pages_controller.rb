class PagesController < ApplicationController

    def index
        @incidents = Incident.all
    end
    
    def show
        @incident = Incident.find(params[:id])
    end
    
    def new
        @incident = Incident.new
    end
    
    def create
        @incident = Incident.new(incident_params)
    
        if @incident.save
        redirect_to @incident, notice: 'Incident was successfully created.'
        else
        render :new
        end
    end
    
    def edit
        @incident = Incident.find(params[:id])
    end
    
    def update
        @incident = Incident.find(params[:id])
    
        if @incident.update(incident_params)
        redirect_to @incident, notice: 'Incident was successfully updated.'
        else
        render :edit
        end
    end
    
    def destroy
        puts 'params: ' + params.to_s
        @incident = Incident.find(params[:id])
        @incident.destroy
    
        redirect_to incidents_url, notice: 'Incident was successfully destroyed.'
    end
    
    private
    
    def incident_params
        params.require(:incident).permit(:title, :description, :status)
    end
end
      