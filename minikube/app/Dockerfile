FROM python:3.8-alpine
RUN addgroup -S webapp && adduser -S -G webapp webapp 

WORKDIR /app
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt 

COPY app.py app.py
COPY templates templates

USER webapp
EXPOSE 5000
CMD ["python3", "app.py"]

