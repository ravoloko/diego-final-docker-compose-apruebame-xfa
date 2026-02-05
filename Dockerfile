# Iniciamos con una imagen oficial de Python 3.11
FROM python:3.11-slim 

#Evita que Python escriba archivos .pyc en el disco del contenedor, manteniéndolo limpio.   
ENV PYTHONDONTWRITEBYTECODE 1
#Asegura que los logs de la aplicación se envíen directamente a la consola en tiempo real
ENV PYTHONUNBUFFERED 1

WORKDIR /app

#copiamos primero solo el archivo de requisitos antes que el resto del código.
COPY requirements.txt /app/

RUN pip install --no-cache-dir -r requirements.txt

COPY . /app/

#Copiamos el resto del código fuente al contenedor. Luego, ejecutamos collectstatic. Este comando de Django reúne todos los archivos CSS, JS e imágenes en una sola carpeta
RUN python manage.py collectstatic --noinput

EXPOSE 8000