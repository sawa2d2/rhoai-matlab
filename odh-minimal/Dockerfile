# Reference of matlab ubuntu image:
#   https://blogs.mathworks.com/japan-community/2023/02/03/jp_mathworks-matlab-kernel-for-jupyter-released/?from=jp

# Source of RHOAI minimal image:
#   https://github.com/red-hat-data-services/notebooks/tree/main/jupyter/minimal/ubi9-python-3.9
# FROM quay.io/modh/odh-minimal-notebook-container:v2

# Source of UBI9 image:
#   https://catalog.redhat.com/software/containers/ubi9/skopeo/61959869ce09ff98ccc36338?container-tabs=gti
FROM registry.access.redhat.com/ubi9/skopeo:9.4-8.1721050495
RUN dnf install -y wget python39 python3-pip
RUN pip3 install micropipenv

# Install MatLab dependencies for UBI9 (Source: https://github.com/mathworks/jupyter-matlab-proxy/tree/main/install_guides/wsl2#set-up-matlab)
# For details: https://github.com/mathworks/jupyter-matlab-proxy/tree/main/install_guides/wsl2#set-up-matlab
RUN wget https://raw.githubusercontent.com/mathworks-ref-arch/container-images/main/matlab-deps/r2024a/ubi9/base-dependencies.txt
RUN cat base-dependencies.txt | xargs dnf install -y

# Install Jupyter dependencies
RUN wget https://raw.githubusercontent.com/red-hat-data-services/notebooks/main/jupyter/minimal/ubi9-python-3.9/Pipfile.lock
RUN wget https://raw.githubusercontent.com/red-hat-data-services/notebooks/main/jupyter/minimal/ubi9-python-3.9/start-notebook.sh
RUN echo "Installing softwares and packages" && micropipenv install && rm -f ./Pipfile.lock

# Install MATLAB
RUN wget https://www.mathworks.com/mpm/glnxa64/mpm
RUN chmod +x mpm
RUN dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
RUN dnf install -y libunwind
RUN ./mpm install --release=R2024a --destination=/matlab --products MATLAB

#RUN pip3 install jupyter-matlab-proxy
#ENV PATH="${PATH}:/home/ubuntu/.local/bin/"
