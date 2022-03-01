run:
	echo "Running {{ cookiecutter.project_name }}"

validate: .pre-commit-config.yaml
	pre-commit run --all-files

build: setup.py
	python setup.py bdist_wheel

clean:
	if [ -d "build" ]; then rm -r build; fi \
	if [ -d "dist" ]; then rm -r dist; fi \
