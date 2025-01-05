# Puede visualizarse en ejecución en: 
<a href="https://test-python.drvelasquezq.site:8000" target="_blank">https://test-python.drvelasquezq.site:8000</a>
(prueba de instalación exitosa)

<a href="https://test-python.drvelasquezq.site" target="_blank">https://test-python.drvelasquezq.site</a>

# Descripción:
Este proyecto da los pasos para utilizar y crear imagen de docker que ejecuta una aplicación de Python integrando Apache con el modulo mod_wsgi en Debian

<ul>
<li>Apache: 2.4.62</li>
<li>Python: 3.11.2</li>
<li>mod_wsgi-standalone: 5.0.2</li>
<li>mod-wsgi-httpd: 2.4.62.1</li>
<li>Debian: Bookworm</li>
</ul>

# Uso

```bash
# clonar proyecto
git clone https://github.com/drvelasquezq/docker-python-3-apache2-wsgi-bookworm.git
# ingresar al proyecto
cd docker-python-3-apache2-wsgi-bookworm
# copiar variables de configuracion del proyecto
cp .env.dev .env
# crear contenedor
docker compose up -d
```

luego podrá ingresar a: http://localhost:8000 o http://localhost:8180

podría también cambiar: var/www/wsgi-scripts/wsgi.py descomentando en docker-compose.yml la línea: - "./var/www/wsgi-scripts/wsgi.py:/var/www/wsgi-scripts/wsgi.py" (tumbar contenedor y volver a montar)

### Ejemplo para construir la imagen: 
```bash
docker build --progress=plain --tag drvelasquezq/python-3-apache2-wsgi-bookworm:v1.0 .
```

### Ejemplo para crear contenedor que solo ejecute el script sh que ya está en la imagen
```bash
docker run --name container-python-3-apache2-wsgi-bookworm drvelasquezq/python-3-apache2-wsgi-bookworm:v1.0
```

## Ejemplo para crear contenedor con la imagen y ejecutarlo de manera interactiva:
```bash
docker run --tty --interactive -p 8180:80 -p 8000:8000 --name container-python-3-apache2-wsgi-bookworm drvelasquezq/python-3-apache2-wsgi-bookworm:v1.0 bash
```

## Ejemplo para crear contenedor con la imagen y ejecutarlo en segundo plano
```bash
docker run -d -p 8180:80 -p 8000:8000 --name container-python-3-apache2-wsgi-bookworm drvelasquezq/python-3-apache2-wsgi-bookworm:v1.0
```
```bash
# para luego ingresar al contenedor
docker exec -ti container-python-3-apache2-wsgi-bookworm bash
```

# Referencias
<a href="https://modwsgi.readthedocs.io/en/develop/index.html">https://modwsgi.readthedocs.io/en/develop/index.html</a>

<a href="https://modwsgi.readthedocs.io/en/develop/index.html">https://pypi.org/project/mod-wsgi/</a>