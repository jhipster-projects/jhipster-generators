# jhipster-generators
Packaged jhipster-generators ready to ship and sail in Docker containers 

## Using Docker

Download the Dockerfile:

```bash
mkdir docker
cd docker
wget https://github.com/jhipster-projects/jhipster-generators/raw/main/Dockerfile
```

Build the Docker images:

```bash
docker build -t jhipster-generator:latest .
```

Make a folder where you want to generate the Service:

```bash
mkdir service
cd service
```

Run the generator from image to generate service:

```bash
docker run -it --rm -v $PWD:/home/jhipster/app jhipster-generator
```

Run and attach interactive shell to the generator docker container to work from inside the running container:

```bash
docker run -it --rm -v $PWD:/home/jhipster/app jhipster-generator /bin/bash
```


## License

The code is available under the [GNU Affero General Public License v3.0](https://github.com/jhipster-projects/jhipster-generators/blob/main/LICENSE) license.
