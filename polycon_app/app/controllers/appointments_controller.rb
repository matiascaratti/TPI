class AppointmentsController < ApplicationController

    def index
        @appointments = Appointment.where(professional: params[:professional_id]).order(:date)
        @professional = Professional.find(params[:professional_id])
    end

    def new
        @appointment = Appointment.new
        @professional = Professional.find(params[:professional_id])
    end

    def create
        @appointment = Appointment.new(appointment_params)
        @professional = Professional.find(@appointment.professional_id)
        if @appointment.save
            redirect_to professional_appointments_path(@professional), notice: params[:date]
        else
            render :new
        end
    end

    def show
        @appointment = Appointment.find(params[:id])
        @professional = Professional.find(@appointment.professional_id)
    end

    def edit
        @appointment = Appointment.find(params[:id])
        @professional = Professional.find(params[:professional_id])
    end

    def update
        @appointment = Appointment.find(params[:id])
        @professional = Professional.find(@appointment.professional_id)
        if @appointment.update(appointment_params)
            redirect_to  professional_appointments_path(@professional)
        else
            render :edit
        end
    end

    def reschedule
        @appointment = Appointment.find(params[:id])
        @professional = Professional.find(@appointment.professional_id)
    end

    def destroy
        @appointment = Appointment.find(params[:id])
        @professional = Professional.find(@appointment.professional_id)
        @appointment.delete
        redirect_to professional_appointments_path(@professional)
    end

    def cancel_all
        Appointment.where(professional: params[:professional_id]).delete_all
        redirect_to professionals_path
    end

    #def filter_by_day
    #    @appointments = Appointment.where(professional: params[:professional_id] and "date > params[:date_filter]").order(:date)
    #    @professional = Professional.find(params[:professional_id])


    private
        def appointment_params
            params.require(:appointment).permit(:date, :patient_name, :patient_surname, :patient_phone, :notes, :professional_id)
        end
end
