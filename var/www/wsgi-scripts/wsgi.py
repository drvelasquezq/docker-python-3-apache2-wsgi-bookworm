"""
# https://modwsgi.readthedocs.io/en/develop/user-guides/quick-configuration-guide.html

def application(environ, start_response):
    status = '200 OK'
    output = b'Hello World!'

    response_headers = [('Content-type', 'text/plain'),
                        ('Content-Length', str(len(output)))]
    start_response(status, response_headers)

    return [output]
"""

import os
import sys
import platform
import importlib.metadata


def application(environ, start_response):

    status = '200 OK'
    headers = [('Content-type', 'text/plain; charset=utf-8')]
    start_response(status, headers)

    output = [
        f"Python Version: {sys.version}\n",
        f"Python Path: {sys.path}\n",
        f"Platform: {sys.platform}\n",
        f"Executable: {sys.executable}\n",
        f"System: {platform.system()}\n",
        f"Release: {platform.release()}\n",
        f"Version: {platform.version()}\n",
        f"Machine: {platform.machine()}\n",
        f"Processor: {platform.processor()}\n",
    ]

    output.append("Installed Packages:\n")

    for dist in importlib.metadata.distributions():
        output.append(f"  {dist.name}: {dist.version}\n")

    output.append("Environment Variables:\n")

    for key, value in os.environ.items():
        output.append(f"  {key}: {value}\n")

    output.append("WSGI Environment:\n")

    for key, value in environ.items():
        output.append(f"  {key}: {value}\n")

    return [
        line.encode('utf-8') for line in output
    ]
