FROM bash:latest

RUN apk add --no-cache curl jq sed git; \
    git clone https://github.com/LinuxMalaysia-BigData-OpenData/interpol_notices.git

RUN chmod +x interpol_notices/interpol-red.sh interpol_notices/interpol-red.sh

CMD ["bash", "interpol_notices/interpol-red.sh"]
CMD ["bash", "interpol_notices/interpol-yellow.sh"]
