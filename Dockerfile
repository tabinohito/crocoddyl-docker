ARG BASE_IMAGE=irslrepo/irsl_system:noetic
FROM ${BASE_IMAGE}
RUN sh -c "echo 'deb [arch=amd64] http://robotpkg.openrobots.org/packages/debian/pub $(lsb_release -cs) robotpkg' >> /etc/apt/sources.list.d/robotpkg.list" && \
    curl http://robotpkg.openrobots.org/packages/debian/robotpkg.key | apt-key add -

RUN apt update && \
    apt install -y robotpkg-py3\*-crocoddyl && \
    apt clean && \
    rm -rf /var/lib/apt/lists/

ENV PATH /opt/openrobots/bin:$PATH
ENV PKG_CONFIG_PATH /opt/openrobots/lib/pkgconfig:$PKG_CONFIG_PATH
ENV LD_LIBRARY_PATH /opt/openrobots/lib:$LD_LIBRARY_PATH
ENV PYTHONPATH /opt/openrobots/lib/python3.8/site-packages:$PYTHONPATH
RUN pip install matplotlib