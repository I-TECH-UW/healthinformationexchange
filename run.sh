docker build -t itechuw/healthinformationexchange:local .
docker run -it --rm -p 8000:80 itechuw/healthinformationexchange:local