bridge-utils:
  pkg.installed

# TODO: This should really be based on network strategy instead of os_family
net.ipv4.ip_forward:
  sysctl.present:
    - value: 1

lxc-docker:
  pkg:
    - purged

docker-io:
  pkg:
    - purged

cbr0:
  network.managed:
    - enabled: True
    - type: bridge
    - proto: manual
    - ports: none
    - bridge: cbr0
    - delay: 0
    - bypassfirewall: True

/etc/systemd/system/docker.service.d/kubernetes.conf:
  file.managed:
    - source: "salt://kubernetes/files/docker.systemd.dropin"
    - makedirs: true
