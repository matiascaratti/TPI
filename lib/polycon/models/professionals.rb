module Polycon
    module Models
        class Professional


            def self.create(name)
                Utils.ensure_polycon_root_exists()
                if(!Utils.professional_exists?(name)) 
                    directory = Utils.polycon_directory() + "/" + name
                    Dir.mkdir(directory)
                    puts "Creación exitosa"
                else
                    warn "Ya existe el profesional"
                end
            end


            def self.delete(name)
                Utils.ensure_polycon_root_exists()
                if(Utils.professional_exists?(name))
                    if(!Utils.professional_has_appointments?(name))
                        professional_directory = Utils.polycon_directory + "/" + name
                        Dir.delete(professional_directory)
                        puts "Profesional eliminado con éxito"
                    else
                        warn "El profesional cuenta con turnos agendados. No se puede eliminar"
                    end
                else
                    warn "El profesional ingresado no existe"
                end
            end


            def self.list()
                Utils.ensure_polycon_root_exists()
                array = Dir.entries(Utils.polycon_directory())
                array.delete(".")
                array.delete("..")
                return array
            end


            def self.rename(old_name, new_name)
                Utils.ensure_polycon_root_exists()
                if(Utils.professional_exists?(old_name))
                    if(!Utils.professional_exists?(new_name))
                        old_directory = Utils.polycon_directory() + "/" + old_name
                        new_directory = Utils.polycon_directory() + "/" + new_name
                        File.rename old_directory, new_directory
                        puts "Profesional renombrado con éxito"
                    else
                        warn "Ya existe un profesional con el nuevo nombre ingresado"
                    end
                else
                    warn "El profesional ingresado no existe"
                end
            end
        end
    end
end

            