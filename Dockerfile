FROM gcr.io/paradigmxyz/ctf/base:latest

ENV HTTP_PORT=8545

COPY requirements.txt /root

RUN python3 -m pip install -r /root/requirements.txt 

RUN true \
    && curl -L https://foundry.paradigm.xyz | bash \
    && bash -c "source /root/.bashrc && foundryup" \
    && chmod 755 -R /root \
    && true

COPY 98-start-gunicorn /startup

COPY eth_sandbox /usr/lib/python/eth_sandbox

ENV PYTHONPATH /usr/lib/python

COPY deploy/ /home/ctf/

COPY contracts /tmp/contracts

RUN true \
    && cd /home/ctf \
    && mv /tmp/contracts/foundry.toml /home/ctf \
    && cp -r /tmp/contracts /home/ctf/ \
    && /root/.foundry/bin/forge init --force \
    && /root/.foundry/bin/forge build \
    # && rm -rf /tmp/contracts \
    && true
