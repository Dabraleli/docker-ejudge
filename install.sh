cd /home/arkhipenko && \
rm -rf /home/arkhipenko/docker-ejudge && \
git clone https://github.com/Dabraleli/docker-ejudge.git && \
cd /home/arkhipenko/docker-ejudge && \
docker rm -f ejudge && \
docker build -t ejudge . && \
docker run -d --name ejudge -p 80:80 -v /opt/ejudge:/home/ejudge ejudge \
