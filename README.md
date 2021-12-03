polycon_app:

-Utilicé la base de datos sqlite que viene con rails, en la cual se encuentran:
User: el email es unico
Professional: el nombre de cada profesional es unico, el email se puede repetir
Appointment: un profesional no puede tener 2 turnos en el mismo horario en un mismo dia, el rango de horario es de 8:00 a 19:30 inclusive. Los minutos de los turnos deben ser 00 (en punto), o 30 (y media).




-Para la autenticación de usuarios utilicé la gema Devise
-Para los permisos utilicé la gema CanCanCan
-Para el diseño de la pagina utilicé Bootstrap y jquery-rails
-Para la paginación utilicé las gemas will_paginate y will_paginate-bootstrap



-Los usuarios predeterminados (definidos en polycon_app/db/seeds.rb) son:

admin: 
email: admin@correo.com contraseña: 12341234

asistente:
email: assistant@correo.com contraseña: 12341234

consultante:
email: consultant@correo.com contraseña : 12341234

-En ese archivo también se encuentran definidos profesionales y turnos.
A los profesionales les agrege telefono, email y especialidad para que tengan mas datos,
pero tanto el email como el telefono se pueden repetir. Lo que no se puede repetir es el nombre,
respetando el enunciado.
Hay 11 profesionales. El profesional con ID 1, Alan Blanco, posee 4 turnos, 3 son el dia 14/02/2022 y
1 el 15/02/2022. La profesional con ID 2, Camila Fernandez, posee 1 turno el 14/02/2022. Y finalmente, 
la profesional con ID 3, Laura Gomez posee 1 turno el dia 17/02/2021.


-Para volver a la página principal, presionar el logo ubicado en la barra de navegación.

-Para hacer funcionar la aplicación: 
Posicionarse en la carpeta polycon_app desde la terminal y ejecutar los comandos:
npm install
rake db:migrate
rails db:seed
rails s
