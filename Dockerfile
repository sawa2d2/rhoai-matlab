# Project source: https://github.com/red-hat-data-services/notebooks/tree/main/jupyter/minimal
FROM quay.io/modh/odh-minimal-notebook-container:v2

USER 0
RUN pip3 install micropipenv

# Install MatLab dependencies for UBI9 (Source: https://github.com/mathworks/jupyter-matlab-proxy/tree/main/install_guides/wsl2#set-up-matlab)
# For details: https://github.com/mathworks/jupyter-matlab-proxy/tree/main/install_guides/wsl2#set-up-matlab
RUN wget https://raw.githubusercontent.com/mathworks-ref-arch/container-images/main/matlab-deps/r2024a/ubi9/base-dependencies.txt
RUN cat base-dependencies.txt | xargs dnf install -y

# Install MATLAB
RUN wget https://www.mathworks.com/mpm/glnxa64/mpm
RUN chmod +x mpm
RUN dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
RUN dnf install -y libunwind
RUN ./mpm install --release=R2024a --destination=/home/matlab --products MATLAB

## Install jupyter matlab proxy
## For details: https://blogs.mathworks.com/japan-community/2023/02/03/jp_mathworks-matlab-kernel-for-jupyter-released/?from=jp
RUN pip3 install jupyter-matlab-proxy
#RUN dnf install -y xorg-x11-server-Xvfb

## Clear dnf cache
RUN dnf clean all \
 && rm -rf /var/cache/dnf

ENV PATH="${PATH}:/home/matlab/bin/"

USER default
