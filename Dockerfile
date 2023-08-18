# Example Usage: 
## docker build -t itechuw/healthinformationexchange:local .
## docker run -it --rm -p 8000:80 itechuw/healthinformationexchange:local
# For local development:
## mkdocs build
## docker run -it --rm -p 8000:80 -v $(pwd)/site:/usr/share/nginx/html itechuw/healthinformationexchange:local

FROM python:3

RUN mkdir /docs

WORKDIR /docs

COPY requirements.txt /docs

RUN pip install --no-cache-dir -r requirements.txt

COPY . /docs

RUN mkdocs build


FROM nginx:stable
COPY --from=0 /docs/site /usr/share/nginx/html
