require 'erb'
require 'date'
class GridsController < ApplicationController
    def index 
         
        @grid = Grid.new(params[:grid]) do |scope|
            scope.page(params[:page])
        end
        
    end

    def grid_generator
        @professionals = Professional.all
    end

    def generate_grid
        hours = []
        (8..19).each do |hour|
            hours << "#{hour}:00"
            hours << "#{hour}:30"
        end
        date = Date.strptime(params[:date_filter], "%Y-%m-%d")
        days = [date]
        if (params[:day_week] == "2")
            (0..5).each do
                date = date + 1 
                days << date
            end
        end
        professionals = []
        if (params[:professional] != "0")
            professionals << Professional.find(params[:professional])
        else
            professionals = Professional.all
        end
        dic_prof_general = {}
        if(!professionals.empty?)
            professionals.each do |pr|
                dic_prof_aux = {}
                dic_day_general = {}
                days.each do |da|
                    dic_day_aux = {}
                    dic_hour_general = {}
                    hours.each do |ho|
                        dic_hour_aux = {}
                        date_aux = da.to_s + " " + ho
                        appointment = Appointment.where(professional: pr).where(date: date_aux)
                        if(!appointment.empty?)
                            dic_hour_aux[ho] = appointment.first.patient_name + " " + appointment.first.patient_surname
                            dic_hour_general.merge!(dic_hour_aux)
                        end
                    end
                    dic_day_aux.store(da.to_s, dic_hour_general)
                    dic_day_general.merge!(dic_day_aux)
                end
                dic_prof_aux.store(pr.name, dic_day_general)
                dic_prof_general.merge!(dic_prof_aux)
            end
        end





        template = ERB.new <<-END, nil, '-'
            <!DOCTYPE html>
            <html lang="es">
                <head>
                    <title> Turnos </title>
                    <meta charset="UTF-8">
                </head>
                <table style="width:30%" border=1>
                    <thead>
                        <tr>
                            <th> Hora </th>
                            <% days.each do |d| %>
                                <th><%= d %></th>
                            <% end %>
                        </tr>
                    </thead>
                    <tbody>
                        <%- hours.each do |hour| -%>
                            <tr>
                                <td><%= hour %></td>
                                <% days.each do |di| %>
                                    <td><% professionals.each do |p| %>
                                        <% if (!(dic_prof_general[p.name]).nil?) %>
                                            <% if (!((dic_prof_general[p.name])[di.to_s]).nil?) %>
                                                <% if (!(((dic_prof_general[p.name])[di.to_s])[hour]).nil?) %>
                                                    <%= "#"+((dic_prof_general[p.name])[di.to_s])[hour]+" - Dr./Dra. "+p.name%>
                                                <% end %>
                                            <% end %>
                                        <% end %>
                                    <% end %>
                                <% end %>    
                            </tr>
                        <%- end -%>
                    </table>
                </body>
            </html>
            END

            send_data (template.result binding), :filename => "grilla.html"
    end


end
