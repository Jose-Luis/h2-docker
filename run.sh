#!/bin/bash

set -e
set -x

scripts_dir=${H2_HOME}/init

cat $(find ${scripts_dir} -name "*.sql" | sort -V) > ${scripts_dir}/init.sql
rm -rf ${scripts_dir}/schema

java -cp ${H2_HOME}/h2/bin/h2*.jar org.h2.tools.Server \
    -web -webAllowOthers -webPort 81 \
    -tcp -tcpAllowOthers -tcpPort 1521 \
    -baseDir ${H2_HOME}/h2-data | \

java -cp ${H2_HOME}/h2/bin/h2*.jar org.h2.tools.RunScript \
    -url jdbc:h2:tcp://localhost:1521/${DATABASE_NAME} \
    -script ${H2_HOME}/init/init.sql \
    -showResults \
    -user sa

exec "$@";
