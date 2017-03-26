{% from "kubernetes/map.jinja" import kubernetes with context %}

include:
  - kubernetes.repository
  - kubernetes.docker
  - kubernetes.certs
  - kubernetes.kubelet

kubectl_package:
  pkg.latest:
    - name: kubectl
    - refresh: true
    - require:
      - pkgrepo: kubernetes-repository

kubernetes_cni_package:
  pkg.latest:
    - name: kubernetes-cni
    - refresh: true
    - require:
      - pkgrepo: kubernetes-repository
