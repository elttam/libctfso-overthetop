Hello Friend

The following commands may be of some help ...

~$ QEMU_GDB=1234 /usr/bin/qemu-arm /challenges/challenge/challenge

~$ gdb-multiarch /challenges/challenge/challenge -q
Reading symbols from /challenges/challenge/challenge...done.
(gdb) set sysroot /etc/qemu-binfmt/arm
(gdb) target remote localhost:1234

