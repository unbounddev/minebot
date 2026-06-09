FROM eclipse-temurin:21.0.11_10-jre-noble
WORKDIR /mc
# RUN apt-get install wget
# RUN wget https://piston-data.mojang.com/v1/objects/64bb6d763bed0a9f1d632ec347938594144943ed/server.jar
CMD java -Xmx4G -Xms4G -jar server.jar nogui