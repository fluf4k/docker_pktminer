#docker_pktminer


## Pull and run
```
docker pull fluf/pktminer
docker run -d fluf/pktminer --t THREADS --p ADDR
```

## or build it
```
git clone https://github.com/fluf4k/docker_pktminer.git
cd docker_pktminer
docker build -t pktminer:latest .
docker run -d pktminer:latest --t THREADS --p ADDR
```
