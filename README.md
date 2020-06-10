[//]: <> (abdevcode)
# SCE
Practica SCE: ecommerce (ruby on rails) - practica para crear un tienda online usando Ruby on rails 

##### Clonar el repositorio

`git clone https://github.com/abdevcode/sce.git`

##### Actualizar el repositorio
`git fetch`

##### Consultar el estado actual de los ficheros
`git status`

##### Añadir ficheros y directorios
`git add -- <fichero>`
> Si los queremos añadir todos
> 
> `git add .`

##### Eliminar un fichero/directorio
`git rm -- <fichero>`

##### Realizar un commit
`git commit -a -a "<nombre>: mensaje descriptivo del commit"`

##### Realizar un push
`git push origin master`

##### Realizar un pull
`git pull origin master`

##### Descargar el estado del repositorio remoto
`git fetch`

##### Visualizar todos los commits graficamente 
`gitk --all --date-order &`

##### Para no tener que poner la contraseña cada vez que accedemos podemos guardarla
> Con esto, en el siguiente acceso que se realice al repositorio remoto, el usuario y contraseña introducidos quedan almacenados en un fichero `~/.git-credentials`.

`git config --global credential.helper store`

> Si nos preocupa que la contraseña quede guardada en el disco duro, podemos utilizar un asistente de credenciales «cache» (es decir, en memoria).
> En este caso con un timeout de 1h que podemos modificar a gusto

`git config --global credential.helper 'cache --timeout=3600'`




