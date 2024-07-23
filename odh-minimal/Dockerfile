# Source of UBI9 image:
#   https://catalog.redhat.com/software/containers/ubi9/skopeo/61959869ce09ff98ccc36338?container-tabs=gti
FROM registry.access.redhat.com/ubi9/skopeo:9.4-8.1721050495
RUN dnf install -y wget python39 python3-pip
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


# Install Jupyter packages
# Source of RHOAI minimal image:
#   https://github.com/red-hat-data-services/notebooks/tree/main/jupyter/minimal/ubi9-python-3.9
WORKDIR /opt/app-root/bin
COPY utils utils/
COPY Pipfile.lock start-notebook.sh ./

RUN echo "Installing softwares and packages" && micropipenv install && rm -f ./Pipfile.lock

#ENV PATH="${PATH}:/home/ubuntu/.local/bin/"

# Disable announcement plugin of jupyterlab
RUN jupyter labextension disable "@jupyterlab/apputils-extension:announcements"

# Fix permissions to support pip in Openshift environments
#RUN chmod -R g+w /opt/app-root/lib/python3.9/site-packages && \
#      fix-permissions /opt/app-root -P

# Install jupyter matlab proxy
# For details: https://blogs.mathworks.com/japan-community/2023/02/03/jp_mathworks-matlab-kernel-for-jupyter-released/?from=jp
RUN pip3 install jupyter-matlab-proxy

WORKDIR /opt/app-root/src

# Replace Notebook's launcher, "(ipykernel)" with Python's version 3.x.y
#RUN sed -i -e "s/Python.*/$(python --version | cut -d '.' -f-2)\",/" /opt/app-root/share/jupyter/kernels/python3/kernel.json

ENTRYPOINT ["start-notebook.sh"]

