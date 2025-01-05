#!/bin/bash

if [[ $ALSO_RUN_THE_SERVER_MOD_WSGI_EXPRESS -eq 1 ]]; then
    # primero el apache global
    /usr/sbin/apachectl start

    # https://pypi.org/project/mod-wsgi/
    . /venv/bin/activate
    mod_wsgi-express setup-server --user www-data --group www-data --port=8000 --server-root=/etc/mod_wsgi-express-8000
    # /etc/mod_wsgi-express-8000/apachectl start
    /etc/mod_wsgi-express-8000/apachectl -D FOREGROUND
else 
    apachectl -D FOREGROUND
fi

