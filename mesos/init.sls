{% from "mesos/map.jinja" import config with context %}

mesos-downloaded:
  archive.extracted:
    - name: {{ config.prefix }}/
    - source: {{ config.archive_url }}
    - source_hash: {{ config.archive_md5 }}

{% for package_name in config.lookup.package_dependencies %}
mesos-dep-pkg-{{ package_name }}:
  pkg.installed:
    - name: {{ package_name }}
{% endfor %}

mesos-build:
  file.directory:
    - name: {{ config.prefix }}/mesos-{{ config.version }}/build
    - require:
      - archive: mesos-downloaded
  cmd.run:
    - name: '../configure --prefix={{ config.prefix }}/mesos-{{ config.version }} && make install'
    - cwd: {{ config.prefix }}/mesos-{{ config.version }}/build
    - unless: test -e {{ config.prefix }}/mesos-{{ config.version }}/bin/mesos-master.sh
    - require:
      - file: mesos-build
      {% for package_name in config.lookup.package_dependencies %}
      - pkg: mesos-dep-pkg-{{ package_name }}
      {% endfor %}