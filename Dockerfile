# Pull the python image
FROM python:3.11-alpine

# Copy requirements.txt to image
COPY ./requirements.txt /app/requirements.txt

# Switch the working directory to /app
WORKDIR /app

# Install deps from requirements.txt
RUN pip install -r requirements.txt

# Copy application files to image
COPY . /app

# Set the docker entrypoint
ENTRYPOINT [ "python" ]
CMD [ "hello.py" ]
