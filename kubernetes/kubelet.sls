# -*- coding: utf-8 -*-
# vim: ft=jinja
{% from "kubernetes/map.jinja" import kubernetes with context %}
include:
  - kubernetes.repository
  - kubernetes.certs

kubernetes_node_cert:
  file.managed:
    - name: {{ kubernetes.lookup.pki_directory }}/node-{{ salt['grains.get']('host','hostgrainfail') }}.pem
    - contents_pillar: {{ kubernetes.config.node_cert_pillar }}
    - require:
      - file: {{ kubernetes.lookup.pki_directory }}

kubernetes_node_key:
  file.managed:
    - name: {{ kubernetes.lookup.pki_directory }}/node-{{ salt['grains.get']('host','hostgrainfail') }}-key.pem
    - contents_pillar: {{ kubernetes.config.node_key_pillar }}
    - require:
      - file: {{ kubernetes.lookup.pki_directory }}

kubelet_systemd_config_directory:
  file.directory:
    - name: /etc/systemd/system/kubelet.service.d
    - makedirs: yes

kubelet_config:
  file.managed:
    - name: /etc/kubernetes/kubelet.conf
    - source: salt://kubernetes/templates/kubelet.conf.jinja
    - template: jinja
    - require:
      - pkg: kubelet
      - file: kubelet_systemd_config_directory

kubelet:
  pkg.latest:
    - name: kubelet
    - refresh: true
    - require:
      - pkgrepo: kubernetes-repository
      - file: kubernetes_node_cert
      - file: kubernetes_node_key

  file.managed:
    - name: /etc/systemd/system/kubelet.service.d/10-kubelet.conf
    - source: salt://kubernetes/templates/kubelet.systemd.config.jinja
    - template: jinja
    - require:
      - pkg: kubelet
      - file: kubelet_systemd_config_directory
      - file: kubelet_config

  service.running:
    - enable: True
    - name: kubelet
    - watch:
      - pkg: kubelet
      - file: kubelet
      - file: kubelet_config

service.systemctl_reload:
  module.run:
    - onchanges:
      - file: kubelet

