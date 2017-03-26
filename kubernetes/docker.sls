{% from "kubernetes/map.jinja" import kubernetes with context %}

bridge-utils:
  pkg.installed

# TODO: This should be based on network strategy instead of os_family
net.ipv4.ip_forward:
  sysctl.present:
    - value: 1

lxc-docker:
  pkg:
    - purged

docker-io:
  pkg:
    - purged

docker_bridge_device:
  network.managed:
    - name: {{ kubernetes.lookup.bridge }}
    - enabled: True
    - type: bridge
    - proto: manual
    - ports: none
    - bridge: {{ kubernetes.lookup.bridge }}
    - delay: 0
    - bypassfirewall: True

/etc/systemd/system/docker.service.d/kubernetes.conf:
  file.managed:
    - source: "salt://{{ slspath }}/files/docker.systemd.dropin"
    - makedirs: true
