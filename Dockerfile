FROM python:3.13-slim-bookworm@sha256:0c5171fd1e80d3133604e1006aa5f788c5f020631537dd1e09edcbe874bb8192

# Create a user and a group
RUN groupadd -r exporter && useradd -r -g exporter exporter -u 999

# Create the /app directory and set the owner
RUN mkdir /app \
    && chown -R exporter:exporter /app

WORKDIR /app

COPY requirements.txt /app

RUN pip install --no-cache-dir -r /app/requirements.txt

# Copy the build context (defined in .dockerignore)
COPY . /app

USER 999

ENTRYPOINT ["python", "-m", "rq_exporter"]
