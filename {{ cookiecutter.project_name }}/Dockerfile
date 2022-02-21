ARG ENV=dev
ARG PYTHON_VERSION=3.9

FROM python:${PYTHON_VERSION}-slim


# Python Virtual Environment                                               
ENV VIRTUAL_ENV=.venv 

# Create a user                                                                 
RUN useradd -ms /bin/bash user                                                  
WORKDIR /home/user 

# Install linux dependencies
WORKDIR /tmp
COPY linux-requirements.txt linux-requirements.txt
RUN apt-get update && \
  apt-get install -yq --no-install-recommends \
  $(grep -vE '^#' linux-requirements.txt) && \
  rm -rf /var/lib/apt/lists/*

USER user

# Create an environment for python packages and install needed dependencies     
RUN python -m venv $VIRTUAL_ENV                                                 
ENV PATH="$VIRTUAL_ENV/bin:$PATH"  

# Install dev dependencies if on develop
COPY dev-requirements.txt /tmp/dev-requirements.txt
RUN if [ "$ENV" = "dev" ] ; then pip install -r dev-requirements.txt --no-input ; fi
