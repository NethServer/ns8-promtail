# Promtail

Start and configure a Promtail instance.
The module use the [Promtail official docker image](https://github.com/grafana/loki/releases).

## Install

An instance of Promtail is installed by default on every cluster node.
Upon service startup, the default Loki cluster instance is found and
Promtail is configured to send log to it.

To add another Promtail instance run

    add-module promtail

## Uninstall

To uninstall the instance:
```
remove-module --no-preserve promtail1
```
