# Pequod - Container hacking lab environment.
TODO: Intro here

* [Intro](#pequod)
* [setup](#setup)
* [Usage](#usage)
* [Troubleshooting](#troubleshooting)
* [FAQ](#faq)

![Moby Dick Final Chase](https://upload.wikimedia.org/wikipedia/commons/8/8b/Moby_Dick_final_chase.jpg)

## Setup
1. Make sure you've installed VirtualBox and Vagrant.

## Usage
TODO: How to use Pequod (tools included?)
#### Default start
Simply run `vagrant up` in the root dir of the project to get a default instance of the VM
#### Custom start*
Pequod offers two optional ways to build/start the vm:

1. Local box
    * Excute `vagrant --box_path=<path_to_box_file> up` to use a box file on your local machine.
2. Hosted box somewhere other than vagrantcloud
    * Execute `vagrant --box_url=<http(s)://url.to.box/file> up`
  
*The options must preceed `up` to avoid them being processed as args to `up`.*

#### Connect to the VM
Run `vagrant ssh` and if all went well you'll get an ssh session as `ahab` on the VM. **[Time to start whale hunting.](#targets)**

## Troubleshooting
TODO: Common troubleshooting tips

## FAQ
TODO: Common questions answered here. Tell people to make issues as well.
