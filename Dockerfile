FROM debian:bookworm

# "update-alternatives --config python" para poder ejecutar python en vez de python3.11 o python3
# lynx para apachectl status

RUN apt-get update && \
    apt-get install -y apache2 && \
    apt-get install -y lynx && \
    apt-get install -y python3.11 && \
    apt-get install -y python3-pip && \
    apt-get install -y python3-venv && \
    update-alternatives --install /usr/bin/python python $(which python3.11) 1 && \
    apt-get clean

EXPOSE 80

# https://modwsgi.readthedocs.io/en/develop/index.html
# https://pypi.org/project/mod-wsgi/

RUN python3 -m venv /venv && \
    . /venv/bin/activate && \
    pip install mod_wsgi-standalone && \
    mod_wsgi-express module-config > /etc/apache2/mods-available/wsgi.load && \
    a2enmod wsgi && \
    service apache2 restart

COPY ./etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf

RUN service apache2 restart

# pueden ejecutarse los siguientes comandos entre el contenedor para verificación de instalación exitosa,
# es un servidor web independiente que no interviene con el ya instalado
# tener en cuenta los puertos para poder ejecutar, por defecto es el que se deja en EXPOSE a continuación
# para activar ambiente virtual: 
#    . /venv/bin/activate
# para ejecutar archivo de script de la aplicacion wsgi interno (no va con wsgi.py): 
#    mod_wsgi-express start-server --user www-data --group www-data
# para ejecutar archivo de script de la aplicacion wsgi: 
#    mod_wsgi-express start-server --user www-data --group www-data wsgi.py

EXPOSE 8000

WORKDIR /var/www

COPY ./var/www/wsgi-scripts/wsgi.py /var/www/wsgi-scripts/wsgi.py
COPY ./var/www/documents /var/www/documents
COPY ./var/www/index.html /var/www/index.html

COPY ./scripts/script.sh /scripts/script.sh

CMD [ "/bin/bash", "/scripts/script.sh" ]
