FROM amarjot/sysbench_ubuntu_docker
COPY docker-script.sh /docker-script.sh
COPY cpu-script.sh /cpu-script.sh
COPY fileio-script.sh /fileio-script.sh
RUN chmod +x docker-script.sh
RUN chmod +x cpu-script.sh
RUN chmod +x fileio-script.sh
ENTRYPOINT bash docker-script.sh
