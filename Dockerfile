FROM registry.fedoraproject.org/fedora-minimal:rawhide

COPY dnf.conf /etc/dnf/dnf.conf

RUN \
    sed -i '/\[fedora\]\|\[updates\]/a enabled=0' /etc/dnf/dnf.conf &&\
    sed -iE '/^metadata_expire/d' /etc/yum.repos.d/fedora-rawhide.repo &&\
    cat /etc/yum.repos.d/fedora-rawhide.repo >> /etc/dnf/dnf.conf &&\
    cat /etc/dnf/dnf.conf &&\
    dnf5 in -y --nogpgcheck --repo=terra,ultramarine terra-gpg-keys ultramarine-gpg-keys python3-dnf &&\
    dnf4 up -y &&\
    dnf4 swap -y systemd-standalone-sysusers systemd &&\
    dnf4 swap -y fedora-release-common ultramarine-release-identity-container --allowerasing &&\
    dnf4 in -y python3-dnf &&\
    dnf4 in -y ultramarine-mock-configs subatomic-cli anda{,-srpm-macros} terra-appstream-helper mock-scm \
        gh wget less podman fuse-overlayfs dnf5-plugins dnf-plugins-core util-linux-script mold sudo terra-sccache jq @buildsys-build --exclude=fedora-release* &&\
    dnf5 clean packages dbcache &&\
    dnf4 clean all &&\
    cp -pv /etc/pki/rpm-gpg/RPM-GPG-KEY-um* -t /etc/pki/mock &&\
    cp -pv /etc/pki/rpm-gpg/RPM-GPG-KEY-terra* -t /etc/pki/mock
