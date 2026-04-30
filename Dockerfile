FROM registry.fedoraproject.org/fedora-minimal:43

COPY dnf.conf /etc/dnf/dnf.conf

RUN dnf in -y --nogpgcheck --repo=terra,ultramarine terra-gpg-keys ultramarine-gpg-keys && \
    dnf up -y && \
    dnf swap -y fedora-release-common ultramarine-release-identity-container --allowerasing --setopt=clean_requirements_on_remove=false && \
    dnf swap -y systemd-standalone-sysusers systemd && \
    dnf in -y ultramarine-mock-configs subatomic-cli anda{,-srpm-macros} terra-appstream-helper mock-scm \
gh wget less podman fuse-overlayfs dnf5-plugins util-linux-script mold sudo terra-sccache jq @buildsys-build --exclude=fedora-release* && \
    dnf clean packages dbcache
