FROM gitpod/workspace-full

USER gitpod

WORKDIR $HOME/.openshift

RUN sudo chown -R gitpod $HOME/.openshift \
    && wget "https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz" "https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-install-linux.tar.gz" \
    && for i in *.gz; do tar xfvz $i; done \
    && mkdir bin \
    && mv kubectl oc openshift-install bin \
    && rm *.gz *.md

ENV PATH=$PATH:$HOME/.openshift/bin
