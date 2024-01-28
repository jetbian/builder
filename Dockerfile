FROM ubuntu:jammy
RUN echo "--> CACHE MISS IN DOCKERFILE: apt packages." && \
 DEBIAN_FRONTEND=noninteractive apt-get -y update && \
 DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends aria2 axel bash bc binfmt-support bison btrfs-progs build-essential ca-certificates ccache colorized-logs cpio cryptsetup curl debian-archive-keyring debootstrap device-tree-compiler dh-autoreconf dialog dirmngr dosfstools dpkg-dev dwarves expect f2fs-tools fdisk file flex g++ g++-aarch64-linux-gnu gawk gcc gcc-aarch64-linux-gnu gcc-arm-linux-gnueabi gcc-arm-linux-gnueabi gcc-arm-linux-gnueabihf gcc-or1k-elf gcc-riscv64-linux-gnu gcc-x86-64-linux-gnu gdisk git gnupg gpg imagemagick jq kmod libbison-dev libc6-amd64-cross libc6-dev libelf-dev libfdt-dev libfile-fcntllock-perl libfl-dev liblz4-tool libmpc-dev libncurses-dev libssl-dev libudev-dev libusb-1.0-0-dev linux-base locales lsof lzop make mkbootimg ncurses-base ncurses-term nilfs-tools ntpdate openssh-client parallel parted patchutils pbzip2 pigz pkg-config psmisc pv python3-dev python3-distutils python3-pip python3-setuptools python-is-python3 qemu-user-static qemu-utils rsync swig tree u-boot-tools udev unzip uuid-dev uuid-runtime wget xfsprogs xz-utils zerofree zip zlib1g-dev zstd

RUN sed -i 's/# en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen && \
    locale-gen

RUN mkdir -p /armnix || true

COPY scripts/entry.sh /usr/sbin/
ENTRYPOINT ["/usr/sbin/entry.sh"]

WORKDIR /armnix
ADD . /armnix/
