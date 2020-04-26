FROM s390x/python:3-alpine

# Add QEMU
ADD https://github.com/multiarch/qemu-user-static/releases/download/v4.0.0-2/qemu-s390x-static.tar.gz /usr/bin/

RUN ls -la /usr/bin/

# Install requirements
WORKDIR /usr/src/app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy application sources
COPY src .

# Run the application
ENV FLASK_APP=app.py
CMD [ "flask", "run" ]
