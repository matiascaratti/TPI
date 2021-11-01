module Polycon
    module Models
        module Utils
            def self.polycon_directory()
                directory = Dir.pwd 
                array_aux = directory.scan(/\w+/)
                str_aux = "/" + array_aux[0] + "/" + array_aux[1]
                directory = str_aux + "/.polycon"
                return directory
            end
            

            def self.ensure_polycon_root_exists()
                if(!Dir.exists?(self.polycon_directory()))
                    Dir.mkdir(self.polycon_directory())
                end
            end


            def self.professional_exists?(professional)
                result = false
                professional_directory = self.polycon_directory() + "/" + professional
                if(Dir.exists?(professional_directory))
                    result = true
                end
                return result
            end

            def self.professional_has_appointments?(professional)
                result = false
                professional_directory = self.polycon_directory() + "/" + professional
                array = Dir.entries(professional_directory)
                array.delete(".")
                array.delete("..")
                if (array.size > 0)
                    result = true
                end
                return result
            end

            def self.appointment_file_directory(date, professional)
                date_aux = date.scan(/\w+/)
                professional_directory = Polycon::Models::Utils.polycon_directory() + "/" + professional
                file = professional_directory + "/" + date_aux[0] + "-" + date_aux[1] + "-" + date_aux[2] + "_" + date_aux[3] + "-" + date_aux[4] + ".paf"
                return file
            end


            def self.isEmpty?(string)
                result = false
                new_string = string.delete " "
                if (new_string.length() == 0)
                    result = true
                end
                return result
            end
        end
    end
end

