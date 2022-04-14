FROM python:3.9

WORKDIR /app
COPY . /app

RUN pip install --no-cache-dir --upgrade -r requirements.txt

ENTRYPOINT ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
