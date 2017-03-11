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

known_tokens.csv:
  file.managed:
    - source: salt://kubernetes/templates/known_tokens.csv.jinja
    - template: jinja
