FROM bash:latest

RUN apk add --no-cache jq sed git; \
    git clone https://github.com/LinuxMalaysia-BigData-OpenData/interpol_notices.git

COPY interpol_notices/interpol-red.sh interpol_notices/interpol-red.sh /

RUN chmod +x /interpol-red.sh /interpol-red.sh

CMD ["bash", "/interpol-red.sh"]
CMD ["bash", "/interpol-yellow.sh"]
