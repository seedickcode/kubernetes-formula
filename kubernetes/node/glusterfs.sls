#Install and configure items needed to support using node as GlusterFS storage node

{% from "kubernetes/map.jinja" import kubernetes with context %}

lvm_package:
  pkg.latest:
    - name: lvm
    - refresh: true
