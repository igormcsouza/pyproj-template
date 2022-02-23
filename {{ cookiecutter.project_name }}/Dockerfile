ARG python_version=3.9.10

FROM python:${python_version}-slim

# Environment variables                       
ENV APP_ENV=dev
ENV EDITOR=vi                        
ENV DEBIAN_FRONTEND=noninteractive
ENV VIRTUAL_ENV=/tmp/.venv

# Create a user                                                                 
RUN useradd -ms /bin/bash user                                                  

WORKDIR /tmp

# Install linux dependencies
COPY linux-requirements.txt linux-requirements.txt
RUN if [ "$APP_ENV" = "dev" ] ; then apt-get update && \
  apt-get install -yq --no-install-recommends \
  $(grep -vE '^#' linux-requirements.txt) && \
  rm -rf /var/lib/apt/lists/* ; fi

USER user

# Install ZSH and OhMyZsh
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.2/zsh-in-docker.sh)" -- \
    -a 'CASE_SENSITIVE="true"' \
    -t robbyrussell \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-completions

# Create an environment for python packages and install needed dependencies
   
RUN python -m venv $VIRTUAL_ENV                                                 
ENV PATH="$VIRTUAL_ENV/bin:$PATH"  

# Install dev dependencies if on develop
COPY dev-requirements.txt /tmp/dev-requirements.txt
RUN pip install --upgrade pip
RUN if [ "$APP_ENV" = "dev" ] ; then pip install -r dev-requirements.txt --no-input ; fi

# Initialize the main directory
WORKDIR /home/user/{{ cookiecutter.project_name }}

COPY . .

USER root
RUN pip-compile

USER user
RUN pip install -r requirements.txt

ENTRYPOINT [ "/bin/zsh" ]
