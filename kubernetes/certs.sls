# -*- coding: utf-8 -*-
# vim: ft=jinja

{% from "kubernetes/map.jinja" import kubernetes with context %}

{% set certgen="make-cert.sh" %}
{% if kubernetes.master_cert_ip is defined %}
  {% set certgen="make-ca-cert.sh" %}
{% endif %}

openssl:
  pkg.installed: []

kube-cert:
  group.present:
    - system: True

kubernetes-cert:
  cmd.script:
    - unless: test -f /srv/kubernetes/server.cert
    - source: salt://kubernetes/files/{{certgen}}
{% if kubernetes.master_cert_ip is defined %}
    # Not supported by this easy-rsa bundle - todo - args: {{kubernetes.master_cert_ip}} {{kubernetes.master_extra_sans|default('')}}
    - args: {{kubernetes.master_cert_ip}}
    - require:
      - pkg: curl
{% endif %}
    - cwd: /
    - runas: root
    - shell: /bin/bash
    - require:
      - pkg: openssl
