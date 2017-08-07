pc-pkgs:
  pkg.latest:
    - pkgs:
      - build-essential
      - git
      - libffi-dev
      - libssl-dev
      - python-dev
      - python-pip

pip-pkgs:
  pip.installed:
    - names:
      - pygit2
      - virtualenvwrapper
    - require:
      - pkg: pc-pkgs

