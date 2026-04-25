#Slim version of python for smaller image size (Cost/Performance)
FROM python:3.9-slim

ENV PYTHONDONOTWRITEBYCODE=1
ENV PYTHONUNBUFFERED=1

#Set working directory
WORKDIR /app

#Create a non-privilage user for security
RUN adduser --disabled-password appuser

#Copy requirements file first to leverage Dokcer layer caching 
COPY requirements.txt .
RUN pip install  --no-cache-dir -r requirements.txt

#Copy rest of app code
COPY . .

#Switch to non-privilage user
USER appuser

#Flask app port
EXPOSE 5000

CMD [ "python","app.py" ]