FROM python:3.12-slim

ENV APP_HOME /app
WORKDIR $APP_HOME
COPY ./src ./

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

CMD ["python", "main.py"]
