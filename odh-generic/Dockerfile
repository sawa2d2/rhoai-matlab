# Reference:
#   https://blogs.mathworks.com/japan-community/2023/02/03/jp_mathworks-matlab-kernel-for-jupyter-released/?from=jp

FROM quay.io/modh/odh-generic-data-science-notebook:v2

RUN pip3 install jupyter-matlab-proxy
ENV PATH="${PATH}:/home/ubuntu/.local/bin/"
