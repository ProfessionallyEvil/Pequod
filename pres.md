# Container Hacking or Something Like That

### Disclaimer
__The information in this document should only be used legally on systems YOU own, or that you have permission to test/mess with/whatever! It's intended for educational purposes. Lastly just don't be an arse.__

```
                          ,   ,
    ~~~~~~~~~~~~~~~~~~~~~~~"o"~~~~
            ____________     o
    	 _--            --_ o
        /       ___      __\ o
       / _         _\    \__o 
      / / |              X  |
     / /   \	           /
    / _ \   \             /
    \/ \/    -.____ ____.-
```

## Who am I?
I'm Cory Sabol (aka bit0pus, that's bit-oh-puhs, like magnum opus).
I work as a software developer and (sometimes) a pentester for [SecureIdeas](www.secureideas.com).
I'm also a hobby game developer in that I make terrible games that I'm ashamed of.

__twitter__: [@bit0pus](https://twitter.com/bit0pus)

__email__: ninja AT lookoutitsa.ninja (yeah, I know.)

__website__: [lookoutitsa.ninja](lookoutitsa.ninja)

[__blogpost on this topic__](https://blog.secureideas.com/2018/05/escaping-the-whale-things-you-probably-shouldnt-do-with-docker-part-1.html)

## What are we going to do?
I'm going talk at you about some half baked ideas that I have, about hacking/fingerprinting/escaping containers.
Then hopefully somebody who knows way more than me decides that they should share that knowledge and they then contribute
to this project and the sister project [Am-I-Being-Contained](https://github.com/ProfessionallyEvil/am-i-being-contained).

After that we'll try to use some of this stuff to escape a container. Maybe. I mean, hopefully.

### What is a container?
The word *container* get's thrown around a lot. It doesn't really mean too much. They are really just a way to run an isolated
process on a system. That's pretty much it. They might seem like VMs on the surface, but they really aren't. Container are built using a bunch of linux (if that's the system you're on) primitives, with some extra features thrown on top. You can check out this [great little blog post about it](https://jvns.ca/blog/2016/10/10/what-even-is-a-container/).

Here are some other useful links to learn more.
* https://github.com/opencontainers
* https://www.opencontainers.org/
* https://linuxcontainers.org/lxc/introduction/
* https://www.docker.com/what-docker

### Getting setup checklist
- [x] Clone this repo
- [x] Install VirtualBox and Vagrant
- [x] Run `vagrant up` and hope that everything provisions smoothly
- [x] Run `vagrant ssh` to connect to the virtual machine

### Alright let's just dive into the good stuff(?)
#### Bind mounts
It's a common work flow with docker to create a container to run your code in during development. You might mount the source code as bind mount into the container, and then have the container execute your source code. This allows you to develop on your host system and quickly reflect those changes in the docker container. Innocuous enough. 

But, again if we can somehow get a shell in the container, then the bind mount possibly gives us some extra ways to mess with things. As far as I know right now, there isn't an easy way to tell if a file is a bind mount without access to the docker tool or daemon.

* Attach to the example container interactively.
  * `docker exec -it container_name|sha /bin/bash`
* Go add some files or whatever to the bind mounted folder.
* Detatch from shell and check the contents of the folder on the host.

#### The Docker socket
The docker socket is a unix socket which has a (semi) RESTful api that contols the docker daemon. This is also what the docker command line tool uses to do, well, everything that it does.
You can ask the socket for info on all containers on the system, create containers, delete them, and so on. So, how does that help us? Well just look at [all this code on github](https://github.com/search?q=-v+%2Fvar%2Frun%2Fdocker.sock%3A&type=Code) where the docker socket is being mounted to a docker container. Why might people do that when it can control so much on the host system, and essentially has root privileges? 

Because it's often nice to have a docker container be able to ask about, create, and otherwise manage other containers on the host. See where I'm going with this?

* Get a shell through some process or web app like a more clever person than I would.
  * `cat /proc/1/cgroup | grep -E -i ":/docker/|:/garden/"`
  * `find "/" 2>&1 | grep -E "(.*\/docker\.sock|^docker\.sock)$"`
* Fingerprint for the docker socket (or just find out if you're in a container)
* Start telling the docker socket to do stuff.
  * See https://github.com/ProfessionallyEvil/am-i-being-contained/tree/master/misc
* We win.

So, how to avoid what we just did? 
* __Don't mount the docker socket into a container__.
* If you must; don't run your code/process as root (the docker default).
* __Don't mount the docker socket into a container__.
* Probably a lot of other ways that I can't think of right now because it's late...

#### If I have time/energy; Kernel sharing
Containers share the same kernel as the host. After all they're just processes running on the host, using it's kernel. This is pretty important because of one major implication - __If the host kernel is vulnerable to something, the container is vulnerable too__. The Pequod VM is deliberately built with an outdated version of Ubuntu with a vulnerable kernel.

#### Now it's your turn
If you're running the Pequod vm you should be able to go to `127.0.0.1:8000/index.html`. Once there it's up to you to figure out what to do (only look at the source if you're really desperate, or ask me for help).


