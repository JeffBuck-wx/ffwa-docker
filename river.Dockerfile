FROM python:3.10-slim

WORKDIR /app

COPY ./river/requirements.txt .

RUN pip install -r requirements.txt \
    && rm requirements.txt

COPY ./river/*.py .

CMD [ "python", "handler.py" ]
