### Build the docker image
```bash
docker build -t jmx-exporter:1.4.0 . --build-arg JMX_EXPORTER_VERSION=1.4.0
```

### Run local tests
```bash
docker run -p 5556:5556 -v $(pwd)/.test/config.yaml:/temp/config.yaml jmx-exporter:1.4.0
```


### Config file
Mount the `config.yaml` at `/temp/config.yaml`

example config.yaml
````yaml
jmxUrl: service:jmx:rmi:///jndi/rmi://127.0.0.1:9999/jmxrmi
startDelaySeconds: 0
ssl: false
includeObjectNames:
  - "java.lang:type=ClassLoading"
  - "java.lang:type=Compilation"
  - "java.lang:type=GarbageCollector,*"
  - "java.lang:type=Memory"
  - "java.lang:type=MemoryPool,*"
```

https://prometheus.github.io/jmx_exporter/1.4.0/http-mode/rules/
