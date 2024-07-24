# Project source: https://github.com/red-hat-data-services/notebooks/tree/main/jupyter/minimal
FROM quay.io/modh/odh-minimal-notebook-container:v2

USER 0

## Install dependencies for MATLAB
## For details: https://blogs.mathworks.com/japan-community/2023/02/03/jp_mathworks-matlab-kernel-for-jupyter-released/?from=jp
RUN pip3 install micropipenv jupyter-matlab-proxy

# Install MatLab dependencies for UBI9 (Source: https://github.com/mathworks/jupyter-matlab-proxy/tree/main/install_guides/wsl2#set-up-matlab)
# For details: https://github.com/mathworks/jupyter-matlab-proxy/tree/main/install_guides/wsl2#set-up-matlab
RUN wget https://raw.githubusercontent.com/mathworks-ref-arch/container-images/main/matlab-deps/r2024a/ubi9/base-dependencies.txt \
 && cat base-dependencies.txt | xargs dnf install -y \
 && rm -rf base-dependencies.txt

# Install MATLAB
RUN dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
RUN dnf install -y libunwind
RUN wget https://www.mathworks.com/mpm/glnxa64/mpm \
 && chmod +x mpm \
 && ./mpm install --release=R2024a --destination=/home/matlab --products MATLAB \
 && rm -rf mpm
ENV PATH="${PATH}:/home/matlab/bin/"

# Install xorg-x11-server-Xvfb
RUN dnf install -y \
  https://dl.rockylinux.org/pub/rocky/9/AppStream/x86_64/os/Packages/l/libxkbfile-1.1.0-8.el9.x86_64.rpm \
  https://dl.rockylinux.org/pub/rocky/9/AppStream/x86_64/os/Packages/x/xkbcomp-1.4.4-4.el9.x86_64.rpm \
  https://dl.rockylinux.org/pub/rocky/9/AppStream/x86_64/os/Packages/x/xorg-x11-server-common-1.20.11-24.el9.x86_64.rpm \
  https://dl.rockylinux.org/pub/rocky/9/AppStream/x86_64/os/Packages/l/libXdmcp-1.1.3-8.el9.x86_64.rpm \
  https://dl.rockylinux.org/pub/rocky/9/AppStream/x86_64/os/Packages/l/libXfont2-2.0.3-12.el9.x86_64.rpm \
  https://dl.rockylinux.org/pub/rocky/9/AppStream/x86_64/os/Packages/x/xorg-x11-server-Xvfb-1.20.11-24.el9.x86_64.rpm \
  && dnf clean all \
  && rm -rf /var/cache/dnf

USER default
