# BebopApplication

## LD_LIBRARY_PATH

Create a file `parrot.conf` in `/etc/ld.so.conf.d` folder. \
In this file, copy the path to the `lib` folder of the Parrot SDK

```
/home/kiwi/Sandbox/ParrotSDK/out/arsdk-native/staging/usr/lib 
```

Then, use `ldconfig` command to update the path.

```
sudo ldconfig
```

## Configure Makefile

In order to compile on your machine, your need to update the Makefile accordingly to your installation.

The variable that need to be updated are the following :

- CXX 
- INCLUDE_MODULE_ARSDK3
- LINK_MODULE_ARSDK3

## Compilation

`make` : Compile the application in release mode. \
`make debug` : Compile the application in debug mode. \
`make clean` : Delete the application and object file generated during compilation.

You can find all compilation logs in the `build.log` file

## Execution

To launch the application, just type in terminal :

```
./BebopApplication
```


