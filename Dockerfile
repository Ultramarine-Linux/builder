FROM registry.fedoraproject.org/fedora-minimal:rawhide

COPY dnf.conf /etc/dnf/dnf.conf

RUN sed -i '/\[fedora\]\|\[updates\]/a enabled=0' /etc/dnf/dnf.conf
RUN sed -iE '/^metadata_expire/d' /etc/yum.repos.d/fedora-rawhide.repo
RUN cat /etc/yum.repos.d/fedora-rawhide.repo >> /etc/dnf/dnf.conf
RUN cat /etc/dnf/dnf.conf
RUN dnf in -y --nogpgcheck --repo=terra,ultramarine terra-gpg-keys ultramarine-gpg-keys
RUN dnf up -y
RUN dnf swap -y fedora-release-common ultramarine-release-identity-container --allowerasing --setopt=clean_requirements_on_remove=false
RUN dnf swap -y systemd-standalone-sysusers systemd
RUN dnf in -y ultramarine-mock-configs ultramarine-mock-gpg-keys terra-mock-gpg-keys subatomic-cli anda{,-srpm-macros} terra-appstream-helper mock-scm \
gh wget less podman fuse-overlayfs dnf5-plugins util-linux-script mold sudo terra-sccache jq @buildsys-build --exclude=fedora-release*
RUN dnf clean packages dbcache
