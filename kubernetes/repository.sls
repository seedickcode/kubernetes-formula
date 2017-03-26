{% from "kubernetes/map.jinja" import kubernetes with context %}

kubernetes-repository:
  pkgrepo.managed:
    - name: {{ kubernetes.repository.name }}
    - humanname: Kubernetes Repsitory
    - key_url: {{ kubernetes.repository.key_url }}
    - file: /etc/apt/sources.list.d/kubernetes.list
    - refresh_db: True

