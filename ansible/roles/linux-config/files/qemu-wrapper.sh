#!/bin/bash -eux
apt-get install -y qemu --no-install-recommends
mkdir /etc/qemu-binfmt
ln -s /usr/arm-linux-gnueabihf /etc/qemu-binfmt/arm
cat > /tmp/qemu-wrapper.c <<EOF
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
char *blacklist[] = {
    "QEMU_GDB",
    "QEMU_LD_PREFIX",
    "QEMU_STACK_SIZE",
    "QEMU_CPU",
    "QEMU_SET_ENV",
    "QEMU_UNSET_ENV",
    "QEMU_ARGV0",
    "QEMU_UNAME",
    "QEMU_GUEST_BASE",
    "QEMU_RESERVED_VA",
    "QEMU_LOG",
    "QEMU_DFILTER",
    "QEMU_LOG_FILENAME",
    "QEMU_PAGESIZE",
    "QEMU_SINGLESTEP",
    "QEMU_STRACE",
    "QEMU_RAND_SEED",
    "QEMU_TRACE",
    "QEMU_VERSION",
    "TMPDIR"
};
int main(int argc, char **argv, char **envp)
{
    unsigned int i = 0;
    char *new_argv0 = NULL;
    for(i = 0; i < sizeof(blacklist) / sizeof(blacklist[0]); i++) {
        if(unsetenv(blacklist[i])) {
            perror("unsetenv");
            goto fail;
        }
    }
    if(asprintf(&new_argv0, "/usr/bin/qemu%s", strrchr(argv[0], '-')) == -1) {
        perror("asprintf");
        goto fail;
    }
    argv[0] = new_argv0;
    execve(argv[0], argv, envp);
    perror("execve");
fail:
    exit(EXIT_FAILURE);
}
EOF
gcc /tmp/qemu-wrapper.c -o /usr/bin/qemu-wrapper -O3
rm /tmp/qemu-wrapper.c
strip /usr/bin/qemu-wrapper
shopt -s extglob
for binary in /usr/bin/qemu-!(@(system*|wrapper))
do
	binary=$(basename $binary)
	ln -s /usr/bin/qemu-wrapper /usr/bin/qemu-wrapper-${binary#qemu-}
done
shopt -u extglob

