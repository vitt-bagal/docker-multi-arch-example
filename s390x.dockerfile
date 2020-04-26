FROM alpine AS builder

# Download QEMU, see https://github.com/docker/hub-feedback/issues/1261
ENV QEMU_URL https://github.com/multiarch/qemu-user-static/releases/download/v4.0.0-2/qemu-s390x-static.tar.gz
RUN apk add curl && curl -L ${QEMU_URL} | tar zxvf - -C /usr/bin/

FROM s390x/python:3-alpine

# Add QEMU
#ADD https://github.com/multiarch/qemu-user-static/releases/download/v4.0.0-2/qemu-s390x-static.tar.gz /usr/bin/
# Add QEMU
COPY --from=builder /usr/bin/qemu-s390x-static /usr/bin/

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
