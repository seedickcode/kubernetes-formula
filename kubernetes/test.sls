{% from "kubernetes/map.jinja" import kubernetes with context %}

kubernetes:
  {{ kubernetes | yaml(False) | indent(2) }}

{{ salt['pillar.get'](kubernetes.config.ca_cert_pillar) }}

{# {{ salt['mine.get']('roles:cert.ca', 'x509.get_pem_entries', 'grain')[kubernetes.config.ca_host]['/etc/pki/ca.crt']|replace('\n', '') }} #}


