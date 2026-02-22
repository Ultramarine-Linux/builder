FROM registry.fedoraproject.org/fedora-minimal:42

COPY dnf.conf /etc/dnf/dnf.conf

RUN \
    dnf5 in -y --nogpgcheck --repo=terra,ultramarine --setopt=terra.baseurl='https://repos.fyralabs.com/terra$releasever',ultramarine.baseurl='https://repos.fyralabs.com/um$releasever' terra-gpg-keys ultramarine-gpg-keys &&\
    dnf5 up -y &&\
    dnf5 swap -y systemd-standalone-sysusers systemd &&\
    dnf5 swap -y fedora-release-common ultramarine-release-common --allowerasing &&\
    dnf5 in -y ultramarine-mock-configs subatomic-cli anda{,-srpm-macros} terra-appstream-helper mock-scm \
        gh wget less podman fuse-overlayfs dnf5-plugins script mold sudo terra-sccache jq @buildsys-build &&\
    dnf5 clean packages dbcache &&\
    cp -v /etc/pki/rpm-gpg/RPM-GPG-KEY-um* -t /etc/pki/mock &&\
    cp -v /etc/pki/rpm-gpg/RPM-GPG-KEY-terra* -t /etc/pki/mock
