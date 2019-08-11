FROM python:3.7-alpine3.9

WORKDIR /usr/src/api

RUN apk add --no-cache -t .build-deps g++=8.3.0-r0

COPY ./Pipfile* ./

RUN pip install --no-cache-dir pipenv==2018.11.26 && \
    pipenv install

RUN apk del --purge .build-deps

COPY ./api.py ./

EXPOSE 5000

ENTRYPOINT ["pipenv", "run", "gunicorn", "-b", "0:5000", "-k", "eventlet", "api:api"]
