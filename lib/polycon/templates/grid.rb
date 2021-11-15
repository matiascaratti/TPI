require 'erb'
module Polycon
    module Grid
        def self.grids_directory()
            return Polycon::Utils.polycon_directory() + "/planillas"
        end

        def self.ensure_grids_directory_exists()
            if(!Dir.exists?(self.grids_directory))
                Dir.mkdir(self.grids_directory)
            end
        end

        def self.hours()
            hours = []
            (8..19).each do |hour|
                hours << "#{hour}:00"
                hours << "#{hour}:30"
            end
            return hours
        end

        def self.filterByDay(day, professionals)
            hours = self.hours
            dic = {}
            professionals.each do |p|
                dic_aux = {}
                professional_directory = Polycon::Utils.polycon_directory + "/" + p
                appointments = Polycon::Models::Appointment.list(professional_directory, day)
                if(!appointments.nil?)
                    appointments.each do |a|
                        appointment_directory = professional_directory + "/" + a
                        dic_aux.merge!(Polycon::Models::Appointment.data(appointment_directory, a))
                    end
                    dic.store(p,dic_aux)
                end
            end
                
            template = ERB.new <<-END, nil, '-'
            <!DOCTYPE html>
            <html lang="es">
                <head>
                    <title> Turnos </title>
                    <meta charset="UTF-8">
                </head>
                <body>
                    <table style="width:30%" border=1>
                        <tr>
                            <th> Hora </th>

                            <th><%= day %></th>
                        </tr>
                        <%- hours.each do |hour| -%>
                            <tr>
                                <td><%= hour %></td>
                                <td>
                                <%- professionals.each do |p| -%>
                                    <%= (dic[p])[hour] %>
                                <%- end -%>
                                </td>
                            </tr>
                        <%- end -%>
                    </table>
                </body>
            </html>
            END
                
            self.ensure_grids_directory_exists()
            ruta = self.grids_directory() + "/" + day +".html"
            File.open(ruta, "w+") do |f|
                f.write(template.result binding)
            end
            puts "Planilla creada con exito en: #{ruta}"
        end
    end
end