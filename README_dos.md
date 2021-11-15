La carpeta .polycon en el home del usuario es la que contiene la información de los profesionales, la 
cual está representada por carpetas (cada carpeta es un profesional). Dentro de dichas carpetas se encuentran los archivos .paf correspondientes a los turnos de cada profesional.

para las planillas se utilizó erb
el comando para crear una planilla es, por ejemplo: 
ruby bin/polycon g filterByDay "2021-10-18" --professional="Juan Perez"
el formato de la fecha es YYYY-MM-DD
las planillas se guardan en la carpeta .polycon/planillas 
