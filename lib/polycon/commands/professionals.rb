module Polycon
  module Commands
    module Professionals
      class Create < Dry::CLI::Command
        desc 'Create a professional'

        argument :name, required: true, desc: 'Full name of the professional'

        example [
          '"Alma Estevez"      # Creates a new professional named "Alma Estevez"',
          '"Ernesto Fernandez" # Creates a new professional named "Ernesto Fernandez"'
        ]

        def call(name:, **)
          directorio = Dir.pwd 
          array_aux = directorio.scan(/\w+/)
          str_aux = "/" + array_aux[0] + "/" + array_aux[1]
          directorio = str_aux + "/.polycon"
          directorio_profesional = directorio + "/" + name
          if(!Dir.exists?(directorio))
            Dir.mkdir(directorio)
          end
          if(!Dir.exists?(directorio_profesional))
            Dir.mkdir(directorio_profesional)
            puts "Creación exitosa"
          else
            puts "Ya existe el profesional"
          end
          #else
          #  existe_profesional = false
          #  File.open(archivo) do |f| 
          #    f.each_line do |line|
          #      existe_profesional = true if line.include? name
          #    end
          #  end
          #  if(!existe_profesional)    
          #    File.open(archivo, "a") {|f| f.write "#{name}\n"}
          #    puts "Creación exitosa"
          #  else
          #    puts "Ya existe el profesional"
          #  end
          #end
          #warn "TODO: Implementar creación de un o una profesional con nombre '#{name}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class Delete < Dry::CLI::Command
        desc 'Delete a professional (only if they have no appointments)'

        argument :name, required: true, desc: 'Name of the professional'

        example [
          '"Alma Estevez"      # Deletes a new professional named "Alma Estevez" if they have no appointments',
          '"Ernesto Fernandez" # Deletes a new professional named "Ernesto Fernandez" if they have no appointments'
        ]

        def call(name: nil)
          warn "TODO: Implementar borrado de la o el profesional con nombre '#{name}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class List < Dry::CLI::Command
        desc 'List professionals'

        example [
          "          # Lists every professional's name"
        ]

        def call(*)
          directorio = Dir.pwd 
          array_aux = directorio.scan(/\w+/)
          str_aux = "/" + array_aux[0] + "/" + array_aux[1]
          directorio = str_aux + "/.polycon"
          archivo = directorio + "/professionals.txt"
          if(Dir.exists?(directorio))
            array = Dir.entries(directorio)
            array.delete(".")
            array.delete("..")
            puts array
          end
          #warn "TODO: Implementar listado de profesionales.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class Rename < Dry::CLI::Command
        desc 'Rename a professional'

        argument :old_name, required: true, desc: 'Current name of the professional'
        argument :new_name, required: true, desc: 'New name for the professional'

        example [
          '"Alna Esevez" "Alma Estevez" # Renames the professional "Alna Esevez" to "Alma Estevez"',
        ]

        def call(old_name:, new_name:, **)
          warn "TODO: Implementar renombrado de profesionales con nombre '#{old_name}' para que pase a llamarse '#{new_name}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end
    end
  end
end
