# Based on:
#   https://github.com/red-hat-data-services/notebooks/blob/main/jupyter/minimal/ubi9-python-3.9/Dockerfile

FROM mathworks/matlab:latest

LABEL name="odh-notebook-jupyter-minimal-ubi9-python-3.9" \
    summary="Minimal Jupyter notebook image for ODH notebooks" \
    description="Minimal Jupyter notebook image with base Python 3.9 builder image based on UBI9 for ODH notebooks" \
    io.k8s.display-name="Minimal Jupyter notebook image for ODH notebooks" \
    io.k8s.description="Minimal Jupyter notebook image with base Python 3.9 builder image based on UBI9 for ODH notebooks" \
    authoritative-source-url="https://github.com/opendatahub-io/notebooks" \
    io.openshift.build.commit.ref="main" \
    io.openshift.build.source-location="https://github.com/opendatahub-io/notebooks/tree/main/jupyter/minimal/ubi9-python-3.9" \
    io.openshift.build.image="quay.io/opendatahub/workbench-images:jupyter-minimal-ubi9-python-3.9"

RUN sudo apt-get update -y \
 && sudo apt-get install -y git \
 && sudo apt-get clean \
 && sudo rm -rf /var/lib/apt/lists/*

RUN pip3 install jupyterlab micropipenv 
ENV PATH="/home/matlab/Document/MATLAB:/opt/app-root/bin:/home/ubuntu/.local/bin/:${PATH}"

WORKDIR /opt/app-root/bin

COPY utils utils/
COPY Pipfile.lock start-notebook.sh ./

# Install Python dependencies from Pipfile.lock file
RUN echo "Installing softwares and packages" && micropipenv install && sudo rm -f ./Pipfile.lock

# Disable announcement plugin of jupyterlab
#RUN jupyter labextension disable "@jupyterlab/apputils-extension:announcements"

# Fix permissions to support pip in Openshift environments
#RUN chmod -R g+w /opt/app-root/lib/python3.9/site-packages && \
#      fix-permissions /opt/app-root -P

WORKDIR /opt/app-root/src

# Replace Notebook's launcher, "(ipykernel)" with Python's version 3.x.y
#RUN sed -i -e "s/Python.*/$(python --version | cut -d '.' -f-2)\",/" /opt/app-root/share/jupyter/kernels/python3/kernel.json

ENTRYPOINT ["start-notebook.sh"]

