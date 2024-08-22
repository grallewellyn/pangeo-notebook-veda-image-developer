FROM pangeo/pangeo-notebook:2024.04.05

USER root

COPY --chown=${NB_USER}:${NB_USER} image-tests /srv/repo/image-tests
COPY --chown=${NB_USER}:${NB_USER} scripts /srv/repo/scripts

USER ${NB_USER}

ADD environment.yml environment.yml
ADD maap_dps_jupyter_extension-0.7.2-py3-none-any.whl maap_dps_jupyter_extension-0.7.2-py3-none-any.whl
RUN pip install maap_dps_jupyter_extension-0.7.2-py3-none-any.whl

ADD maap_jupyter_server_extension-2.0.9-py3-none-any.whl maap_jupyter_server_extension-2.0.9-py3-none-any.whl
RUN pip install maap_jupyter_server_extension-2.0.9-py3-none-any.whl

RUN jupyter server extension enable maap_jupyter_server_extension

RUN mamba env update --prefix /srv/conda/envs/notebook --file environment.yml
