# assembly

## Requirements
* [podman](https://podman.io) `4.9.3+`
* [just](https://github.com/casey/just) `1.25.1+`

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

## Debugging

[LLDB Tutorial](https://lldb.llvm.org/use/tutorial.html)

To run process and stop at `_start`:
```shell
(lldb) process launch --stop-at-entry
```

Simple TUI can be invoked:
```shell
(lldb) gui
```

To read all General Purpose Registers:
```shell
(lldb) register read
```

To read 10 bytes from memory one by one and display as char[]:
```shell
(lldb) memory read --size 1 --count 15 --format char[] 0x00000000004000a0
```

To read two 32bit values from address stored in `x1` register and display in HEX:
```shell
(lldb) memory read --size 4 --count 2 --format x $x1
```