# -*- coding: utf-8 -*-
# vim: ft=jinja
{% from "kubernetes/map.jinja" import kubernetes with context %}

include:
  - kubernetes.repository
  - kubernetes.kubelet

kube_manifests_dir:
  file.directory:
    - name: {{ kubernetes.lookup.manifests_dir }}

kube_proxy_config:
  file.managed:
    - name: {{ kubernetes.lookup.manifests_dir }}/kube-proxy.yaml
    - source: salt://kubernetes/templates/kube-proxy.yaml.jinja
    - template: jinja
    - require:
      - pkg: kubelet
      - file: {{ kubernetes.lookup.manifests_dir }}

