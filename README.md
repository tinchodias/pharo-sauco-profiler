# Sauco PerfMeter

[![Test](https://github.com/tinchodias/pharo-sauco-profiler/actions/workflows/test.yml/badge.svg)](https://github.com/tinchodias/pharo-sauco-profiler/actions/workflows/test.yml)

A user interface for the Pharo profilers. 


## Install

First: Manually load full [Roassal3](https://github.com/ObjectProfile/Roassal3), and the `Roassal3-FlameGraph` package.
Second: Evaluate the following script: 
~~~smalltalk
Metacello new
    baseline: 'SaucoPerfMeter';
    repository: 'github://tinchodias/pharo-sauco-profiler';
    load.
~~~

## Where to start

Find several examples oof use in class-side of `SaReport`, such as:

```Smalltalk
SaReport exampleUUID
```

## License

The code is licensed under [MIT](LICENSE).

## What is the *sauco* word? 

Sauco is a name of [a tree](https://es.wikipedia.org/wiki/Sambucus_australis). One of the variants has fruits like these:

![Fruits](https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/Sambucus_nigra2.jpg/320px-Sambucus_nigra2.jpg)
