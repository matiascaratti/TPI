La carpeta .polycon en el home del usuario es la que contiene la información de los profesionales, la 
cual está representada por carpetas (cada carpeta es un profesional). Dentro de dichas carpetas se encuentran los archivos .paf correspondientes a los turnos de cada profesional.

para las planillas se utilizó erb
el comando para crear una planilla es, por ejemplo: 
ruby bin/polycon g filterByDay "2021-10-18" --professional="Juan Perez"
el formato de la fecha es YYYY-MM-DD
las planillas se guardan en la carpeta .polycon/planillas 

------------------------------------------------------------------------------------------------------

polycon_app:

Utilicé la base de datos sqlite que viene con rails, en la cual se encuentran:
User
Professional
Appointments




Para la autenticación de usuarios utilicé la gema Devise
Para los permisos utilicé la gema CanCanCan
Para el diseño de la pagina utilicé Bootstrap y jquery-rails




Los usuarios predeterminados (definidos en polycon_app/db/seeds.rb) son:

admin: 
email: admin@correo.com contraseña: 12341234

asistente:
email: assistant@correo.com contraseña: 12341234

consultante:
email: consultant@correo.com contraseña : 12341234

en ese archivo también se encuentran definidos profesionales y turnos




Para hacer funcionar la aplicación: 
Posicionarse en la carpeta polycon_app desde la terminar y ejecutar el comando: rails s
