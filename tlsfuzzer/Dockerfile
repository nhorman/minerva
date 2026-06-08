FROM python:3.11-slim

# Install git to clone repositories
RUN apt-get update && apt-get install -y git tcpdump vim gcc && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Clone tlsfuzzer and its primary dependency
RUN git clone https://github.com/tlsfuzzer/tlsfuzzer.git
RUN git clone https://github.com/tlsfuzzer/tlslite-ng.git
RUN git clone https://github.com/GeorgePantelakis/minerva-toolkit


# Install tlslite-ng in editable/development mode
WORKDIR /app/tlslite-ng
RUN pip install -r requirements.txt -r build-requirements.txt
RUN python ./setup.py install

# Switch to the tlsfuzzer scripts directory
WORKDIR /app/tlsfuzzer
RUN pip install -r requirements.txt -r requirements-timing.txt
RUN python ./setup.py install

RUN pip uninstall pycropto && pip install pycryptodome

COPY ./ecdsa_key_type.patch .
COPY ./fix_bit_time_analysis.patch .
RUN patch -p1 --merge < ./ecdsa_key_type.patch
RUN patch -p1 --merge < ./fix_bit_time_analysis.patch

COPY ./run_minerva.sh .
RUN cmod +x ./run_minerva.sh


# Set the default command to show usage instruction
CMD ["sleep", "infinity"]
