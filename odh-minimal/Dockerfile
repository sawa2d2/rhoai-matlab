# Reference of matlab ubuntu image:
#   https://blogs.mathworks.com/japan-community/2023/02/03/jp_mathworks-matlab-kernel-for-jupyter-released/?from=jp

# Source of RHOAI minimal image:
# FROM quay.io/modh/odh-minimal-notebook-container:v2

# Source of UBI9 image:
#   https://catalog.redhat.com/software/containers/ubi9/skopeo/61959869ce09ff98ccc36338?container-tabs=gti
FROM registry.access.redhat.com/ubi9/skopeo:9.4-8.1721050495
RUN dnf install -y wget

RUN wget https://raw.githubusercontent.com/mathworks-ref-arch/container-images/main/matlab-deps/r2024a/ubi9/base-dependencies.txt
RUN cat base-dependencies.txt | xargs dnf install -y

#RUN pip3 install jupyter-matlab-proxy
#ENV PATH="${PATH}:/home/ubuntu/.local/bin/"
