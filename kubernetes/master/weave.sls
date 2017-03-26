# -*- coding: utf-8 -*-
# vim: ft=jinja
{% from "kubernetes/map.jinja" import kubernetes with context %}

include:
  - kubernetes.node

cni_net_dir:
  file.directory:
    - name: {{ kubernetes.lookup.cni_net_dir }}

kube_proxy_config:
  file.managed:
    - name: {{ kubernetes.lookup.cni_net_dir }}/10-weave.conf
    - source: salt://kubernetes/templates/weave-node.conf.jinja
    - template: jinja
    - require:
      - file: {{ kubernetes.lookup.cni_net_dir }}

