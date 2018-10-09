FROM openjdk:8

ENV H2_HOME /opt/h2
ENV DATABASE_NAME test
ENV DOWNLOAD http://www.h2database.com/h2-2018-03-18.zip

RUN mkdir -p ${H2_HOME}

WORKDIR ${H2_HOME}

ADD run.sh run.sh
ADD init-scripts init

RUN curl ${DOWNLOAD} -o h2.zip && unzip h2.zip && rm h2.zip

EXPOSE 81 1521

ENTRYPOINT ["/bin/bash", "run.sh"]