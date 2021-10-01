module Polycon
  module Commands
    module Appointments
      class Create < Dry::CLI::Command
        desc 'Create an appointment'

        argument :date, required: true, desc: 'Full date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'
        option :name, required: true, desc: "Patient's name"
        option :surname, required: true, desc: "Patient's surname"
        option :phone, required: true, desc: "Patient's phone number"
        option :notes, required: false, desc: "Additional notes for appointment"

        example [
          '"2021-09-16 13:00" --professional="Alma Estevez" --name=Carlos --surname=Carlosi --phone=2213334567'
        ]

        def call(date:, professional:, name:, surname:, phone:, notes: nil)
          fecha_hora = date.scan(/\w+/)
          directorio = Dir.pwd 
          array_aux = directorio.scan(/\w+/)
          str_aux = "/" + array_aux[0] + "/" + array_aux[1]
          directorio = str_aux + "/.polycon"
          directorio_profesional = directorio + "/" + professional
          archivo = directorio_profesional + "/" + fecha_hora[0] + "-" + fecha_hora[1] + "-" + fecha_hora[2] + "_" + fecha_hora[3] + "-" + fecha_hora[4] + ".paf"
          if(Dir.exists?(directorio))
            if(Dir.exists?(directorio_profesional))
              if(!File.exists?(archivo))
                File.open(archivo, "w+") {|f| f.write "#{surname}\n#{name}\n#{phone}\n#{notes}"}
              else puts "No se pudo agendar el turno, debido a que ya existe un turno para esa fecha con ese profesional"
              end
            else puts "No se pudo agendar el turno, debido a que el profesional no existe en el sistema"
            end
          else puts "No existen datos"
          end  
          #warn "TODO: Implementar creación de un turno con fecha '#{date}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class Show < Dry::CLI::Command
        desc 'Show details for an appointment'

        argument :date, required: true, desc: 'Full date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'

        example [
          '"2021-09-16 13:00" --professional="Alma Estevez" # Shows information for the appointment with Alma Estevez on the specified date and time'
        ]

        def call(date:, professional:)
          directorio = Dir.pwd 
          array_aux = directorio.scan(/\w+/)
          str_aux = "/" + array_aux[0] + "/" + array_aux[1]
          directorio = str_aux + "/.polycon"
          directorio_profesional = directorio + "/" + professional
          fecha_hora = date.scan(/\w+/)
          archivo = directorio_profesional + "/" + fecha_hora[0] + "-" + fecha_hora[1] + "-" + fecha_hora[2] + "_" + fecha_hora[3] + "-" + fecha_hora[4] + ".paf"
          if(Dir.exists?(directorio))
            if(Dir.exists?(directorio_profesional))
              if(File.exists?(archivo))
                File.foreach(archivo) { |line| puts line }
              else puts "No existe el turno ingresado"
              end
            else puts "No existe el profesional ingresado"
            end
          else puts "No se encontraron datos"
          end
          #warn "TODO: Implementar detalles de un turno con fecha '#{date}' y profesional '#{professional}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class Cancel < Dry::CLI::Command
        desc 'Cancel an appointment'

        argument :date, required: true, desc: 'Full date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'

        example [
          '"2021-09-16 13:00" --professional="Alma Estevez" # Cancels the appointment with Alma Estevez on the specified date and time'
        ]

        def call(date:, professional:)
          directorio = Dir.pwd 
          array_aux = directorio.scan(/\w+/)
          str_aux = "/" + array_aux[0] + "/" + array_aux[1]
          directorio = str_aux + "/.polycon"
          directorio_profesional = directorio + "/" + professional
          fecha_hora = date.scan(/\w+/)
          archivo = directorio_profesional + "/" + fecha_hora[0] + "-" + fecha_hora[1] + "-" + fecha_hora[2] + "_" + fecha_hora[3] + "-" + fecha_hora[4] + ".paf"
          if(Dir.exists?(directorio))
            if(Dir.exists?(directorio_profesional))
              if(File.exists?(archivo))
                File.delete(archivo)
                puts "Turno cancelado con éxito"
              else puts "No se pudo cancelar el turno ya que no existe"
              end
            else puts "El profesional no existe en el sistema"
            end
          else puts "No se encontraron datos"
          end
          #warn "TODO: Implementar borrado de un turno con fecha '#{date}' y profesional '#{professional}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class CancelAll < Dry::CLI::Command
        desc 'Cancel all appointments for a professional'

        argument :professional, required: true, desc: 'Full name of the professional'

        example [
          '"Alma Estevez" # Cancels all appointments for professional Alma Estevez',
        ]

        def call(professional:)
          directorio = Dir.pwd 
          array_aux = directorio.scan(/\w+/)
          str_aux = "/" + array_aux[0] + "/" + array_aux[1]
          directorio = str_aux + "/.polycon"
          directorio_profesional = directorio + "/" + professional
          if(Dir.exists?(directorio))
            if(Dir.exists?(directorio_profesional))
              FileUtils.rm_rf("#{directorio_profesional}/.", secure: true)
              puts "Cancelación exitosa de todos los turnos del profesional #{professional}"
            else
              puts "No se pudo cancelar los turnos del profesional #{professional} ya que dicho profesional no existe en el sistema"
            end
          else
            puts "No se encontraron datos"
          end
          #warn "TODO: Implementar borrado de todos los turnos de la o el profesional '#{professional}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class List < Dry::CLI::Command
        desc 'List appointments for a professional, optionally filtered by a date'

        argument :professional, required: true, desc: 'Full name of the professional'
        option :date, required: false, desc: 'Date to filter appointments by (should be the day)'

        example [
          '"Alma Estevez" # Lists all appointments for Alma Estevez',
          '"Alma Estevez" --date="2021-09-16" # Lists appointments for Alma Estevez on the specified date'
        ]

        def call(professional:, date: nil)
          directorio = Dir.pwd 
          array_aux = directorio.scan(/\w+/)
          str_aux = "/" + array_aux[0] + "/" + array_aux[1]
          directorio = str_aux + "/.polycon"
          directorio_profesional = directorio + "/" + professional
          if(Dir.exists?(directorio))
            if(Dir.exists?(directorio_profesional))
              if(!date.nil?)
                Dir.foreach(directorio_profesional) {|f| puts "#{f} \n" if f.include? date}
              else
                array = Dir.entries(directorio_profesional)
                array.delete(".")
                array.delete("..")
                puts array
              end
            else puts "El profesional ingresado no existe en el sistema"
            end
          else puts "No se encontraron datos"
          end
          #warn "TODO: Implementar listado de turnos de la o el profesional '#{professional}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class Reschedule < Dry::CLI::Command
        desc 'Reschedule an appointment'

        argument :old_date, required: true, desc: 'Current date of the appointment'
        argument :new_date, required: true, desc: 'New date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'

        example [
          '"2021-09-16 13:00" "2021-09-16 14:00" --professional="Alma Estevez" # Reschedules appointment on the first date for professional Alma Estevez to be now on the second date provided'
        ]

        def call(old_date:, new_date:, professional:)
          directorio = Dir.pwd 
          array_aux = directorio.scan(/\w+/)
          str_aux = "/" + array_aux[0] + "/" + array_aux[1]
          directorio = str_aux + "/.polycon"
          directorio_profesional = directorio + "/" + professional
          fecha_hora_vieja = old_date.scan(/\w+/)
          fecha_hora_nueva = new_date.scan(/\w+/)
          archivo_actual = directorio_profesional + "/" + fecha_hora_vieja[0] + "-" + fecha_hora_vieja[1] + "-" + fecha_hora_vieja[2] + "_" + fecha_hora_vieja[3] + "-" + fecha_hora_vieja[4] + ".paf"
          archivo_renombrado = directorio_profesional + "/" + fecha_hora_nueva[0] + "-" + fecha_hora_nueva[1] + "-" + fecha_hora_nueva[2] + "_" + fecha_hora_nueva[3] + "-" + fecha_hora_nueva[4] + ".paf"
          if(Dir.exists?(directorio))
            if(File.exists?(archivo_actual))
              if(!File.exists?(archivo_renombrado))
                File.rename archivo_actual, archivo_renombrado
                puts "Turno reagendado con éxito"
              else warn "No se pudo reagendar el turno porque ya existe uno en esa fecha y hora"
              end
            else
              warn "No se pudo reagendar el turno ya que no existe en el sistema"
            end
          else warn "No se encontraron datos"
          end
          #warn "TODO: Implementar cambio de fecha de turno con fecha '#{old_date}' para que pase a ser '#{new_date}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class Edit < Dry::CLI::Command
        desc 'Edit information for an appointments'

        argument :date, required: true, desc: 'Full date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'
        option :name, required: false, desc: "Patient's name"
        option :surname, required: false, desc: "Patient's surname"
        option :phone, required: false, desc: "Patient's phone number"
        option :notes, required: false, desc: "Additional notes for appointment"

        example [
          '"2021-09-16 13:00" --professional="Alma Estevez" --name="New name" # Only changes the patient\'s name for the specified appointment. The rest of the information remains unchanged.',
          '"2021-09-16 13:00" --professional="Alma Estevez" --name="New name" --surname="New surname" # Changes the patient\'s name and surname for the specified appointment. The rest of the information remains unchanged.',
          '"2021-09-16 13:00" --professional="Alma Estevez" --notes="Some notes for the appointment" # Only changes the notes for the specified appointment. The rest of the information remains unchanged.',
        ]

        def call(date:, professional:, **options)
          warn "TODO: Implementar modificación de un turno de la o el profesional '#{professional}' con fecha '#{date}', para cambiarle la siguiente información: #{options}.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end
    end
  end
end
