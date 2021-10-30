module Polycon
    module Models
        class Appointment

            def self.create(professional_directory, name, surname, phone, file, notes)
                Utils.ensure_polycon_root_exists()
                if (Dir.exists?(professional_directory))
                    if(!File.exists?(file))
                        File.open(file, "w+") {|f| f.write "#{surname}\n#{name}\n#{phone}\n#{notes}"}
                        puts "Turno agendado con éxito"
                    else warn "No se pudo agendar el turno, debido a que ya existe un turno para esa fecha con ese profesional"
                    end
                else warn "No se pudo agendar el turno, debido a que el profesional no existe en el sistema"
                end
            end


            def self.show(professional_directory, file)
                Utils.ensure_polycon_root_exists()
                if(Dir.exists?(professional_directory))
                    if(File.exists?(file))
                      File.foreach(file) { |line| puts line }
                    else puts "No existe el turno ingresado"
                    end
                else puts "No existe el profesional ingresado"
                end
            end


            def self.cancel(professional_directory, file)
                Utils.ensure_polycon_root_exists()
                if(Dir.exists?(professional_directory))
                    if(File.exists?(file))
                      File.delete(file)
                      puts "Turno cancelado con éxito"
                    else warn "No se pudo cancelar el turno ya que no existe"
                    end
                else warn "El profesional no existe en el sistema"
                end
            end


            def self.cancellAll(professional_directory, professional)
                Utils.ensure_polycon_root_exists()
                if(Dir.exists?(professional_directory))
                    FileUtils.rm_rf("#{professional_directory}/.", secure: true)
                    puts "Cancelación exitosa de todos los turnos del profesional #{professional}"
                else
                    warn "No se pudo cancelar los turnos del profesional #{professional} ya que dicho profesional no existe en el sistema"
                end
            end


            def self.list(professional_directory, date)
                array = []
                Utils.ensure_polycon_root_exists()
                if(Dir.exists?(professional_directory))
                    if(!date.nil?)
                      Dir.foreach(professional_directory) {|f| array << "#{f}" if f.include? date}
                    else
                      array = Dir.entries(professional_directory)
                      array.delete(".")
                      array.delete("..")
                    end
                else puts "El profesional ingresado no existe en el sistema"
                end
                return array
            end


            def self.reschedule(old_file, new_file)
                Utils.ensure_polycon_root_exists()
                if(File.exists?(old_file))
                    if(!File.exists?(new_file))
                      File.rename old_file, new_file
                      puts "Turno reagendado con éxito"
                    else warn "No se pudo reagendar el turno porque ya existe uno en esa fecha y hora"
                    end
                else
                    warn "No se pudo reagendar el turno ya que no existe en el sistema"
                end
            end

            def self.data(file_directory, file_name)
                dic = {}
                name = file_name.delete ".paf"
                date = name.gsub("_","-")
                date = date.scan(/\w+/)
                hour = date[3] + ":" + date[4]
                patient_name = IO.readlines(file_directory)[1].delete "\n"
                patient_surname = IO.readlines(file_directory)[0].delete "\n"
                patient = patient_name + " " + patient_surname
                dic[hour] = patient 
                return dic
            end    
        end
    end
end