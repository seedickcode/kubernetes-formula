# -*- coding: utf-8 -*-
# vim: ft=jinja

{% from "kubernetes/map.jinja" import kubernetes with context %}

{{ kubernetes.lookup.pki_directory }}:
  file.directory: []

kubernetes_ca_cert:
  file.managed:
    - name: {{ kubernetes.lookup.pki_directory }}/ca.pem
    - contents_pillar: {{ kubernetes.config.ca_cert_pillar }}
    - require:
      - file: {{ kubernetes.lookup.pki_directory }}

kubernetes_ca_key:
  file.managed:
    - name: {{ kubernetes.lookup.pki_directory }}/ca-key.pem
    - contents_pillar: {{ kubernetes.config.ca_key_pillar }}
    - require:
      - file: {{ kubernetes.lookup.pki_directory }}
    
#kubernetes_apiserver_cert:
#  file.managed:
#    - name: {{ kubernetes.lookup.pki_directory }}/apiserver.pem
#    - contents_pillar: {{ kubernetes.config.apiserver_cert_pillar }}
#    - require:
#      - file: {{ kubernetes.lookup.pki_directory }}
#
#kubernetes_apiserver_key:
#  file.managed:
#    - name: {{ kubernetes.lookup.pki_directory }}/apiserver-key.pem
#    - contents_pillar: {{ kubernetes.config.apiserver_key_pillar }}
#    - require:
#      - file: {{ kubernetes.lookup.pki_directory }}
#    
