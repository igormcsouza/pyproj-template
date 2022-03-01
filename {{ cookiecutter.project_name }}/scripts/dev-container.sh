docker build . --build-arg python_version=3.9.10 \
    -t igormcsouza/{{ cookiecutter.project_name }}:dev
docker run -it -v ${PWD}:/home/user/{{ cookiecutter.project_name }} \
    -e APP_ENV=dev igormcsouza/{{ cookiecutter.project_name }}:dev