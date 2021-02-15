from flask import Flask, request, send_file
from gevent.pywsgi import WSGIServer
import os
import subprocess
import uuid

api = Flask(__name__)


@api.route('/parse', methods=['POST'])
def parse_pdf_2_html():
    if request.method == 'POST':
        file = request.files['file']
        pdf_file_name, html_file_name = generate_unique_file_name()
        file.save(pdf_file_name)
        subprocess.call("pdf2htmlEX --fit-width 900 " + pdf_file_name, shell=True)
        html = send_file(html_file_name)
        os.remove(pdf_file_name)
        os.remove(html_file_name)
        return html


@api.route('/health', methods=['GET'])
def health_check():
    return 'ok'


def generate_unique_file_name():
    file_name = str(uuid.uuid4())
    return file_name + ".pdf", file_name + ".html"


def get_app_port():
    app_port = os.getenv("APP_HTTP_PORT")
    if app_port is None:
        return 9088
    else:
        return int(app_port)


if __name__ == '__main__':
    http_server = WSGIServer(('', get_app_port()), api)
    http_server.serve_forever()

