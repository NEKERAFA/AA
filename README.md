# Repositorio de Aprendizaje Automático

## Descarga del repositorio

### Windows / Mac

Tenéis la aplicación [GitHub Desktop](https://desktop.github.com/) para trabajar gráficamente. Una vez instalada, refrescad esta página y dadle al botón de **Clone or download**. Pulsad **Open in Desktop** para clonarlo. Elegid la carpeta donde clonarlo y listo.

### GNU/Linux

Tenéis que instalar el paquete Git, que ya viene incluido en los repositorios. Podeis usar uno de los siguientes comandos:

* Debian / Ubuntu 15.10 (Y anteriores)

```bash
$ sudo apt-get install git
```

* Ubuntu 16.04 (Y posteriores)

```bash
$ sudo apt install git
```

* Fedora 21 (Y anteriores)

```bash
$ sudo yum install git
```

* Fedora 22 (Y posteriores)

```bash
$ sudo dnf install git
```

Los demás sistemas os los [buscais](https://git-scm.com/download/linux) vosotros.

Una vez hecho vamos a la carpeta donde clonar el repositorio y copiamos:

```bash
$ git clone https://github.com/NEKERAFA/AA.git
```

## Subir al repositorio o bajar actualizaciones

### Windows / Mac

Una vez modificado los archivos de la carpeta del repositorio en local, abrimos GitHub Desktop y nos detectará los cambios. Para hacer un *commit* de los cambios, debemos añadir algo a *Summary* y luego pulsamos **Commit to master**. Una vez hecho le damos al botón **Sync** para que suba la nueva versión al repositorio.

Para bajarnos lo último añadido por los demás también hay que darle al botón **Sync**, solo que sin hacer ningún *commit*.

### GNU/Linux

Para subir los archivos en local, nos desplazamos al directorio y añadimos los archivos al repositorio local:

```bash
$ git add .
```

Ahora tenéis que crear el *commit*, hay dos opciones:

```bash
$ git commit -m "Descripción del commit"

$ git commit -e	# Abrirá nano para añadir la descripción
```

Ahora subimos los comentarios:

```bash
$ git push
```

Para bajarnos las actualizaciones del repositorio:

```bash
$ git pull
```
