FROM busybox as staging

WORKDIR /tmp/files

# dependencies.
COPY requirements.txt requirements.txt

FROM nvidia/cuda:11.3.1-base-ubuntu20.04

RUN apt-get update && \
	apt-get install -y \
	libglib2.0-0 \
	libsm6 \
	libxext6 \
	libxrender1 \
	libgl1-mesa-dev \
	python3-venv \
	python3-dev \
	gcc \
	g++ \
	tzdata \
	vim \
	# dumb-init for the entry point
	dumb-init \
	&& \
	# set the timezone
	ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && dpkg-reconfigure -f noninteractive tzdata \
	&& \
	rm -rf /var/lib/apt/lists/

WORKDIR /tmp/install
COPY --from=staging /tmp/files .

# Python virtual env
RUN python3 -m venv ~/venv

# Don't try to uninstall existing packages, e.g., numpy
RUN ~/venv/bin/pip install --no-cache-dir -U pip setuptools wheel && \
	~/venv/bin/python3 -m pip install --no-cache-dir -r requirements.txt

WORKDIR /app

COPY . /app

RUN ~/venv/bin/python3 -m pip install --no-cache-dir -v -e .

# do not write bytecode, this is useless in a container
ENV PYTHONDONTWRITEBYTECODE 1
# always flush the input
ENV PYTHONUNBUFFERED 1

ENTRYPOINT ["/usr/bin/dumb-init", "-c", "--"]

# Run the entrypoint.
CMD bash
