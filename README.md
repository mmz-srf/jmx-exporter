# Package for Prometheus jmx exporter

## Build the docker image
```bash
docker build -t jmx-exporter:1.6.0 . --build-arg JMX_EXPORTER_VERSION=1.6.0
```
> The `JMX_EXPORTER_VERSION` defines the Version from [Prometheus JMX Exporter](https://prometheus.github.io/jmx_exporter/)

## Run the image locally
```bash
docker run -it -p 5556:5556 -v $(pwd)/example/config.yaml:/temp/config.yaml jmx-exporter:1.6.0
```

### Config
Mount the `config.yaml` at `/temp/config.yaml` or start the container with the desired mount path.

#### Example config
Create the config file with [HTTP mode configuration Rules](https://prometheus.github.io/jmx_exporter/configuration/rules)

```yaml
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

## Container release workflow
| Branch / Tag       | Phase   | Container tag | Rollout           |
| ------------------ | ------- | ------------- | ----------------- |
| develop-* (weekly) | **DEV** | dev           | on push           |
| tag (v0.0.1)       | **INT** | int-0.0.1     | on tag creation   |
| main               | **PRD** | 0.0.1         | workflow dispatch |
