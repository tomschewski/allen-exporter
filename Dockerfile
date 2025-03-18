# Use an official Python base image
FROM python:3.9-slim

# Set working directory in the container
WORKDIR /src
COPY experanto /src/experanto
COPY neuralpredictors /src/neuralpredictors
COPY sensorium_2023 /src/sensorum_2023
COPY requirements.txt /src

# Install system dependencies for AllenSDK and Jupyter
RUN apt-get update && \
	apt-get install -y --no-install-recommends git ffmpeg && \
	apt-get clean && rm -rf /var/liv/apt/lists/*

RUN pip install --upgrade pip \
    && pip install -r requirements.txt \
    && pip install -e /src/experanto \
    && pip install -e /src/neuralpredictors


# Expose the default Jupyter Notebook port
EXPOSE 8888

# Set default command to run Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--allow-root"]
