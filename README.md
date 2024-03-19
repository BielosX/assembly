# assembly

## Troubleshooting

### MacOS podman issue

When podman build is killed with error simmilar to this:
``` shell
/bin/bash: line 1: 24215 Killed
```

Try increasing podman VM memory
```shell
podman machine stop
podman machine set --cpus 4 --memory 16384
podman machine start
```