Vagrant.require_version ">= 1.7.0"

vmname = "libctf.so overthetop"

Vagrant.configure(2) do |config|
  config.vm.box = "generic/ubuntu1604"
  config.vm.box_version = "2.0.6"

  # share playbook provisioning files with guest
  config.vm.synced_folder ".", "/vagrant"

  # parallels share playbook using rsync
  config.vm.provider "parallels" do |v, override|
    override.vm.synced_folder ".", "/vagrant", type: "rsync"
  end

  # libvirt+qemu provider
  config.vm.provider "libvirt" do |libvirt|
    libvirt.uri = "qemu:///system"
  end

  # install and configure ctf
  config.vm.provision "ansible_local" do |ansible|
    ansible.verbose = true
    ansible.install = true
    ansible.playbook = "ansible/site.yml"
  end
end
