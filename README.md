polycon_app:

Utilicé la base de datos sqlite que viene con rails, en la cual se encuentran:
User: el email es unico
Professional: el nombre de cada profesional es unico, el email se puede repetir
Appointment: un profesional no puede tener 2 turnos en el mismo horario en un mismo dia, el rango de horario es de 8:00 a 19:30 inclusive. Los minutos de los turnos deben ser 00 (en punto), o 30 (y media).




Para la autenticación de usuarios utilicé la gema Devise
Para los permisos utilicé la gema CanCanCan
Para el diseño de la pagina utilicé Bootstrap y jquery-rails
Para la paginación utilicé las gemas will_paginate y will_paginate-bootstrap



Los usuarios predeterminados (definidos en polycon_app/db/seeds.rb) son:

admin: 
email: admin@correo.com contraseña: 12341234

asistente:
email: assistant@correo.com contraseña: 12341234

consultante:
email: consultant@correo.com contraseña : 12341234

en ese archivo también se encuentran definidos profesionales y turnos


Para volver a la página principal, presionar el logo ubicado en la barra de navegación.

Para hacer funcionar la aplicación: 
Posicionarse en la carpeta polycon_app desde la terminal y ejecutar el comando: rails s
