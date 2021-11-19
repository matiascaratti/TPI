class ProfessionalsController < ApplicationController 

    def index
        @professionals = Professional.all.order(:name)
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
            redirect_to professionals_path
        else
            render :edit
        end
    end

    def show
        @professional = Professional.find(params[:id])
    end

    def destroy
        #Falta eliminar todos los appointments de ese profesional
        @professional = Professional.find(params[:id])
        @professional.delete
        redirect_to professionals_path
    end

    private
        def professional_params
            params.require(:professional).permit(:name)
        end
end
