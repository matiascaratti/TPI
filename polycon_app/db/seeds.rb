# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

###### Creación de Usuarios
User.create(email: "admin@correo.com", password: "12341234", password_confirmation: "12341234", role: "admin")
User.create(email: "assistant@correo.com", password: "12341234", password_confirmation: "12341234", role: "assistant")
User.create(email: "consultant@correo.com", password: "12341234", password_confirmation: "12341234", role: "consultant")

###### Creación de Profesionales
Professional.create(name: "Ramiro Blanco", email: "ramiro@correo.com", phone: "1133445566", specialty: "Odontología")
Professional.create(name: "Camila Fernandez", email: "camila@correo.com", phone: "1199887766", specialty: "Kinesiología")
Professional.create(name: "Laura Gomez", email: "laura@correo.com", phone: "1166554477", specialty: "Oftalmología")
Professional.create(name: "Guillermo Carmona", email: "guillermo@correo.com", phone: "1155443322", specialty: "Cardiología")

###### Creación de Turnos
Appointment.create(date: "14-02-2022 13:00", patient_name: "Dario", patient_surname: "Piedras", patient_phone: "1123432343", notes: "", professional_id: 1)
Appointment.create(date: "14-02-2022 15:00", patient_name: "Florencia", patient_surname: "Lopez", patient_phone: "1194945434", notes: "Podría demorar 5 o 10 minutos", professional_id: 1)
Appointment.create(date: "14-02-2022 17:00", patient_name: "Paula", patient_surname: "Estrada", patient_phone: "1156443356", notes: "", professional_id: 1)
Appointment.create(date: "15-02-2022 13:00", patient_name: "Daniel", patient_surname: "Alarcón", patient_phone: "1123542343", notes: "", professional_id: 1)
Appointment.create(date: "14-02-2022 13:00", patient_name: "Ariel", patient_surname: "Sierras", patient_phone: "1123678343", notes: "", professional_id: 2)
Appointment.create(date: "17-02-2022 13:00", patient_name: "Adriana", patient_surname: "Gonzales", patient_phone: "1123438843", notes: "", professional_id: 3)

