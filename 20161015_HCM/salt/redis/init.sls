redis:
  archive:
    - extracted 
    - source: http://download.redis.io/releases/redis-3.2.4.tar.gz
    - source_hash: sha1=f0fe685cbfdb8c2d8c74613ad8a5a5f33fba40c9
    - name: /usr/local/redis
    - archive_format: tar
  pkg:
    - installed
    - pkgs: 
      - make
      - build-essential
  cmd:
    - run
    - name: make
    - unless: test -e /usr/local/redis/redis-3.2.4/src/redis-server
    - cwd: /usr/local/redis/redis-3.2.4/
    - require:
      - cmd: redis_deps

redis_deps:
  cmd:
    - run
    - name: make hiredis jemalloc linenoise lua geohash-int
    - unless: test -e /usr/local/redis/redis-3.2.4/src/redis-server
    - cwd: /usr/local/redis/redis-3.2.4/deps

redis_upstart:
  file:
    - managed
    - source: salt://redis/upstart.jinja
    - name: /etc/init/redis.conf


redis_service:
  service:
    - running
    - name: redis
    - watch:
      - file: redis_upstart
