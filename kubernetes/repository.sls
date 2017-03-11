{% from "kubernetes/map.jinja" import kubernetes with context %}

kubernetes-repository:
  pkgrepo.managed:
    - name: deb http://apt.kubernetes.io/ kubernetes-xenial main
    - humanname: Kubernetes Repsitory
    - key_url: https://packages.cloud.google.com/apt/doc/apt-key.gpg
    - file: /etc/apt/sources.list.d/kubernetes.list
    - refresh_db: True

