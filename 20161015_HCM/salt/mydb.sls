include:
  - postgresql

dbuser:
  postgres_user:
    - present
    - name: mattermost
    - password: mattermostpw
    - createdb: True
    - require:
      - service: postgresql
  postgres_database:
    - present
    - name: mattermost
