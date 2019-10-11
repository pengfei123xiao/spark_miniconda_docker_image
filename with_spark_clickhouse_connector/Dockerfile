# ======spark-mini-clickhouse docker image======
FROM hseeberger/scala-sbt:8u222_1.3.0_2.13.0 AS bulid_clickhouse
RUN mkdir -p /repo;\
cd /repo;\
git clone https://github.com/VaBezruchko/spark-clickhouse-connector.git;\
touch /root/.sbt/nexus_url;\
cd /repo/spark-clickhouse-connector;\
sbt assembly;

FROM pengfei123xiao/spark-miniconda

COPY --from=bulid_clickhouse /repo/spark-clickhouse-connector/spark-clickhouse-connector/target/scala-2.11/spark-clickhouse-connector_2.11-2.4.0_0.22.jar /spark-2.4.4-bin-hadoop2.7/jars

RUN cd /spark-2.4.4-bin-hadoop2.7/jars;\
    wget http://kompics.sics.se/maven/repository/org/tensorflow/spark-tensorflow-connector_2.11/1.6.0/spark-tensorflow-connector_2.11-1.6.0.jar;\
    wget https://repo1.maven.org/maven2/ru/yandex/clickhouse/clickhouse-jdbc/0.1.54/clickhouse-jdbc-0.1.54.jar
