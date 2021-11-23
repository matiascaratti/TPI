require 'erb'
require 'date'
class GridsController < ApplicationController
    #before_action :authenticate_user!
    #load_and_authorize_resource
    def grid_generator
        @professionals = Professional.all 
    end

    def generate_grid
        hours = []
        (8..19).each do |hour|
            hours << "#{hour}:00"
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
        dic = {}
        if(!professionals.empty?)
            professionals.each do |pr|
                dic_day = {}
                days.each do |da|
                    dic_hour = {}
                    dic_day_aux = {}
                    appointments = Appointment.where(professional: pr.id).where(date: da)
                    if(!appointments.empty?)
                        appointments.each do |ap|
                            dic_hour_aux = {}
                            a_hour = (ap.date.hour).to_s + ":00"
                            dic_hour_aux[a_hour] = ap.patient_name + " " + ap.patient_surname
                            #date_aux = Date.strptime(a.date.to_s, "%Y-%m-%d").to_s
                            dic_hour.merge!(dic_hour_aux)
                            #dic_day.merge!(dic_hour)
                        end
                        dic_day_aux.merge!(dic_hour)
                    end
                    dic_day.store(da, dic_day_aux)
                end
                dic.store(pr.name, dic_day)
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
                                        <% if (!(dic[p.name]).nil?) %>
                                            <% if (!((dic[p.name])[di]).nil?) %>
                                                <% if (!(((dic[p.name])[di])[hour]).nil?) %>
                                                    <%= "#"+((dic[p.name])[di])[hour]+" - "+p.name%>
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
