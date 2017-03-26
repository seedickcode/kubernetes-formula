# -*- coding: utf-8 -*-
# vim: ft=jinja

{% from "kubernetes/map.jinja" import kubernetes with context %}

known_tokens.csv:
  file.managed:
    - name: {{ kubernetes.lookup.etcd_manifest_file }}
    - source: salt://kubernetes/templates/etcd.manifest.jinja
    - template: jinja
