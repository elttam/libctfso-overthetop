# Overview

libctfso-overthetop is a bundle of ARM Linux CTF challenges
requiring memory corruption.

Works out of the box on my machine, YMMV - PR's welcome.

# Prerequisites

To use this bundle you should have [Vagrant](https://www.vagrantup.com)
installed along with one of the following hypervisors:

* Virtualbox
* Hyper-V
* Parallels
* libvirt+QEMU
* VMWare Desktop (should work but not tested)

If you know what you're doing and prefer to manage deployment yourself, you can
simply run the [Ansible](https://www.ansible.com/)
[playbook](./ansible/site.yml) on a [Ubuntu Xenial
amd64](http://releases.ubuntu.com/xenial/) target.

## Notes

If you are using Parallels or libvirt+QEMU, please ensure you have `rsync`
installed locally.

If this is your first time using Vagrant with libvirt, please run `vagrant
plugin install vagrant-libvirt`.

If this is your first time using Vagrant with Parallels, please run `vagrant
plugin install vagrant-parallels`.

If this is your first time using Vagrant with Hyper-V, please run all commands
from an Administrator console. In addition, you will be asked to enter your
Windows username/password to enable shared folder support for provisioning.

# Usage

The following command will download a Ubuntu 16.04 VM template from VagrantHub,
create a new virtual machine for 'libctfso-overthetop', and build/install
challenges under the `/challenges` directory of the VM:

**Note:** This can take a while the first time you run it depending on your host
specs and internet connection.

```sh
vagrant up
```

You can re-provision anytime with:

```sh
vagrant provision
```

You can connect to the virtual machine with:

```sh
vagrant ssh
```

This will login to the virtual machine using the 'vagrant' user account,
which has `sudo` privileges so that you can install any additional packages that
you want.

You can stop the virtual machine with:

```sh
vagrant halt
```

And delete the virtual machine with:

```sh
vagrant destroy
```

# Challenges

You should switch to the 'hahn' user account (password = 'hahn') when you are
ready to play:

```sh
su - hahn
```

All challenges can be found under the `/challenges/` directory.

Difficulty estimates are relative to other challenges in this bundle.

---

**Title:** softcover-walk  
**Category:** ARM Memory Corruption  
**Flag:** `libctf{8d26bc70-5d8f-423d-8e8b-afce769344d1}`  
**Relative Difficulty:** Easy

---

**Title:** bashes-sp-data  
**Category:** ARM Memory Corruption  
**Flag:** `libctf{7b86c8cb-70a9-43d5-8642-2ab65ce18a46}`  
**Relative Difficulty:** Medium  

---

**Title:** fat-morphine  
**Category:** ARM Memory Corruption  
**Flag:** `libctf{14b9c051-4a0a-4158-a303-b85a181bac96}`  
**Relative Difficulty:** Medium

---

**Title:** whoever-flopa  
**Category:** ARM Memory Corruption  
**Flag:** `libctf{8eb6767f-9440-44da-9c3a-57cb210f441e}`  
**Relative Difficulty:** Hard

---

# Hints

Each challenge directory should have everything you need to figure out a plan of
attack. If you really want, you can treat this source repository as an oracle by
asking it questions like:

```
hahn@apocalypse:~/libctfso-overthetop/ansible/roles$ grep -iR 'randomize_va_space' . >/dev/null && true || false
hahn@apocalypse:~/libctfso-overthetop/ansible/roles$ echo $?
0
hahn@apocalypse:~/libctfso-overthetop/ansible/roles$ grep -iR 'idontexist' . >/dev/null && true || false
hahn@apocalypse:~/libctfso-overthetop/ansible/roles$ echo $?
1
hahn@apocalypse:~/libctfso-overthetop/ansible/roles$ 
```
