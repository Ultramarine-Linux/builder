FROM registry.fedoraproject.org/fedora-minimal:rawhide

COPY dnf.conf /etc/dnf/dnf.conf

RUN \
    sed -i '/\[fedora\]\|\[updates\]/a enabled=0' /etc/dnf/dnf.conf &&\
    sed -iE '/^metadata_expire/d' /etc/yum.repos.d/fedora-rawhide.repo &&\
    cat /etc/yum.repos.d/fedora-rawhide.repo >> /etc/dnf/dnf.conf &&\
    cat /etc/dnf/dnf.conf &&\
    dnf in -y --nogpgcheck --repo=terra,ultramarine terra-gpg-keys ultramarine-gpg-keys &&\
    dnf up -y &&\
    dnf swap -y systemd-standalone-sysusers systemd &&\
    dnf swap -y fedora-release-common ultramarine-release-identity-container --allowerasing &&\
    dnf in -y ultramarine-mock-configs ultramarine-mock-gpg-keys terra-mock-gpg-keys subatomic-cli anda{,-srpm-macros} terra-appstream-helper mock-scm \
        gh wget less podman fuse-overlayfs dnf5-plugins util-linux-script mold sudo terra-sccache jq @buildsys-build --exclude=fedora-release* &&\
    dnf clean packages dbcache
