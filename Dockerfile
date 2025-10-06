FROM python:3.11-slim-bullseye

ARG PIP_DISABLE_PIP_VERSION_CHECK=1
ARG PIP_NO_CACHE_DIR=1

# Set the working directory in the container
WORKDIR /app

# RUN apt-get update && apt-get install -y \
#  gcc \
#  && rm -rf /var/lib/apt/lists/*

# Copy the requirements file from the parent directory into the container at /app
COPY ./requirements.txt /app/requirements.txt

# Update pip and Install any needed packages specified in requirements.txt
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt 



# Copy the current directory contents into the container at /app
COPY ./ /app/

EXPOSE 8000

# Run the command to start Gunicorn

COPY ./entrypoint.sh /

RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]