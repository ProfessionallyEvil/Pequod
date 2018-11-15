FROM ubuntu

RUN apt-get update
RUN apt-get install -y jq curl
ADD harpoon /harpoon
# run a infinite process for now, later we will have a simple service of sorts in place.
CMD ["tail", "-f", "/dev/null"]