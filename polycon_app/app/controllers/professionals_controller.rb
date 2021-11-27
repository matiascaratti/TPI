class ProfessionalsController < ApplicationController 
    load_and_authorize_resource
    def index
        @professionals = Professional.all.order(:name).paginate(:page => params[:page], :per_page => 10)
    end
    
    def new
        @professional = Professional.new
    end

    def create
        @professional = Professional.new(professional_params)
        error_msg = validation(professional_params)
        if error_msg.empty? and @professional.save
            redirect_to professionals_path, :alert => "Profesional creado con éxito"
        else
            redirect_to new_professional_path, :alert => error_msg
        end
    end

    def edit
        @professional = Professional.find(params[:id])
    end

    def update
        @professional = Professional.find(params[:id])
        error_msg = validation(professional_params)
        if error_msg.empty? and @professional.update(professional_params)
            redirect_to professionals_path, :alert => "Modificación exitosa"
        else
            redirect_to edit_professional_path(@professional), :alert => error_msg
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

        def validation(professional_params)
            error_msg = ""
            professional_aux = Professional.where(name: professional_params[:name])
            if !professional_aux.empty?
                error_msg = error_msg + "Ya existe un profesional con este nombre.\n"
            end
            return error_msg
        end
end
