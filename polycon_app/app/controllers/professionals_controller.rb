class ProfessionalsController < ApplicationController 
    before_action :authenticate_user!
    load_and_authorize_resource
    def index
        @professionals = Professional.all.order(:name).paginate(:page => params[:page], :per_page => 10)
    end
    
    def new
        @professional = Professional.new
    end

    def create
        @professional = Professional.new(professional_params)
        if @professional.save
            redirect_to professionals_path
        else
            render :new
        end
    end

    def edit
        @professional = Professional.find(params[:id])
    end

    def update
        @professional = Professional.find(params[:id])
        if @professional.update(professional_params)
            redirect_to professionals_path, :alert => "Modificación exitosa"
        else
            render :edit
        end
    end

    def show
        @professional = Professional.find(params[:id])
    end

    def destroy
        query = Appointment.where(professional: params[:id])
        if (query.empty?)
            @professional = Professional.find(params[:id])
            @professional.delete
            redirect_to professionals_path, :alert => "Se eliminó el profesional"
        else
            redirect_to professionals_path, :alert => "No se pudo eliminar el profesional ya que posee turnos agendados"
        end
    end

    private
        def professional_params
            params.require(:professional).permit(:name, :phone, :email, :specialty)
        end
end
