require 'date'
class AppointmentsController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource
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
            render :new, :alert => "No se pudo agendar el turno debido a que ya existe un turno en la fecha y hora ingresada para este profesional"
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
            redirect_to  professional_appointments_path(@professional), :alert => "Modificación exitosa"
        else
            redirect_to [@professional, @appointment], :alert => "No se pudo agendar el turno debido a que ya existe un turno en la fecha y hora ingresada para este profesional"
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
        redirect_to professional_appointments_path(@professional), :alert => "Se canceló el turno"
    end

    def cancel_all
        @appointments = Appointment.where(professional: params[:professional_id]).delete_all
        redirect_to professionals_path, :alert => "Se cancelaron todos los turnos"
    end

    def filter_index
        next_day = Date.strptime(params[:date_filter], "%Y-%m-%d") + 1
        @appointments = Appointment.where(date: (params[:date_filter]..next_day.to_s)).where(professional_id: params[:professional_id]).order(:date)
        @professional = Professional.find(params[:professional_id])
    end

    private
        def appointment_params
            params.require(:appointment).permit(:date, :patient_name, :patient_surname, :patient_phone, :notes, :professional_id)
        end
end
