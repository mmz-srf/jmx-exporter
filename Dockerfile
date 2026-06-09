FROM eclipse-temurin:25-jre

# Set environment variables
ARG JMX_EXPORTER_VERSION=1.6.0
ENV JMX_EXPORTER_VERSION=${JMX_EXPORTER_VERSION}
ENV JMX_EXPORTER_PORT=5556
ENV APP_NAME="jmx-exporter"
ENV JMX_EXPORTER_REPOSITORY="https://github.com/prometheus/jmx_exporter"

# Metadata
LABEL description="Java JMX to Prometheus exporter"
LABEL org.opencontainers.image.description="Java JMX to Prometheus exporter"
LABEL org.opencontainers.image.title="jmx-exporter"
LABEL org.opencontainers.image.version="${JMX_EXPORTER_VERSION}"

RUN apt-get update && apt-get install -y curl

# Create application directory
RUN mkdir -p /opt/jmx_exporter

# Download JMX exporter jar and configuration file
RUN curl -fL https://github.com/prometheus/jmx_exporter/releases/download/v${JMX_EXPORTER_VERSION}/jmx_prometheus_standalone-${JMX_EXPORTER_VERSION}.jar \
    -o /opt/jmx_exporter/jmx_prometheus_standalone.jar

RUN apt-remove -y curl && apt-get clean

# Create non-root user
RUN useradd -D -u 1001 -h /opt/jmx_exporter jmxuser
RUN chown -R 1001:root /opt/jmx_exporter

USER 1001
WORKDIR /opt/jmx_exporter

EXPOSE ${JMX_EXPORTER_PORT}

ENTRYPOINT ["java", "-jar", "jmx_prometheus_standalone.jar"]

# Run the application with the JMX Exporter agent and configuration file
CMD ["5556","/temp/config.yaml"]
