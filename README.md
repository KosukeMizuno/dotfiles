# README

## with docker-compose
- `sudo docker-compose up --build -d && sudo docker-compose exec centos8 bash`
- `sudo docker-compose exec centos8 bash`

## without
- `sudo docker stop dot && sudo docker rm dot`
- `sudo ./build.sh && sudo docker run --name=dot -u=u1 -v "$PWD:/home/u1/dotfiles:ro" -it dotfiles_portable:latest`
