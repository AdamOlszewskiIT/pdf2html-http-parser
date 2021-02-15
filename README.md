# PDF2HTML Service

Transforms pdf into html files via http request handled by gevent server.

## Setup

1. Setup virtual env
```bash
python3 -m venv pdf2html
```

2. Setup dependencies
```bash
pip install -r requirements.txt
```

## Run it

1. Run server
```bash
python pdf_2_html_service
```

2. Build docker image
```bash
docker build -t pdf2html .
```

3. Run docker container
```bash
docker run -itd -p 9088:9088 pdf2html
```

## Usage

1. Test with `curl`
```bash
curl --form file='@/path/to/your/pdf' http://0.0.0.0:9088/parse
```