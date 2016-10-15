/tmp/test:
  file:
    - managed
    - contents: {{ grains['num_cpus'] }} {{ salt['pillar.get']('mypassword') }}
  
