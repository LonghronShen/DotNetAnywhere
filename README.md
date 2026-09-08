Dot Net Anywhere
================
Dot Net Anywhere is an interpreted .NET CIL runtime.

-------

# This project is inactive. No issues or PRs will be dealt with.

*However! The code was used in initial prototypes of [Blazor](https://github.com/SteveSanderson/Blazor) IL-in-a-browser project :)*

-------

The runtime itself is written in C and has been designed to be as small and portable as possible, allowing .NET software to be used on resource-constrained devices where it is not possible to run a full .NET runtime (e.g. [Mono][1]).

How To Build
------------
The current build uses CMake and Ninja or another supported CMake generator.
The native runtime is compiled as C11; the managed libraries and examples are
built with `dotnet`/MSBuild.

On Debian or Ubuntu, install the build prerequisites first:

```
sudo apt-get update
sudo apt-get install build-essential cmake ninja-build dotnet-sdk-8.0 \
	zlib1g-dev libfreetype6-dev
```

Configure and build a native x86_64 tree:

```
cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=Debug
cmake --build build
```

For the legacy x86 configuration, install `gcc-multilib`, `g++-multilib`,
`libc6-dev-i386`, and `zlib1g-dev:i386`, then use a separate build tree:

```
cmake -S . -B build-x86 -G Ninja -DCMAKE_BUILD_TYPE=Debug \
	-DDNA_FORCE_32BIT=ON \
	-DZLIB_LIBRARY_RELEASE=/usr/lib/i386-linux-gnu/libz.so \
	-DZLIB_LIBRARY_DEBUG=/usr/lib/i386-linux-gnu/libz.so
cmake --build build-x86
```

Build output is written to `<build-directory>/bin/`, including `dna`, the
graphics library, the managed runtime libraries, `HelloWorld.exe`, and
`Snake.exe`.

How to use
----------

From a build output directory:

```
./dna [<options>] <CIL executable> [<CIL executable arguments>]
```

So, to run the included snake game:

```
./dna Snake.exe
```

The minimal runtime smoke test is:

```
./dna ./HelloWorld.exe
```

`HelloWorld.exe` returns `126` (`84 + 42`) rather than printing text. The
`-v` and `-vv` options enable module, garbage-collection, and JIT diagnostics.

The Dot Net Anywhere interpreter can show all two levels of verbosity. Using the -v option shows initial .NET module load data and garbage collection information. Using -vv also shows all methods that are being JITted.

Of course, the Snake.exe is a completely standard .NET executable file, so it can just be run using the normal Microsoft .NET runtime:

```
Snake.exe
```

This game was originally written to run on some custom hardware that did not have a standard keyboard, hence the controls are little odd:

* '6': Left
* '7': Down
* '8': Up
* '9': Right

Supported .NET runtime features
-------------------------------

The interpreter and corlib currently implement the following .NET 2.0 CLR and language features:

* Generics
* Garbage collection and finalization
* Weak references
* Full exception handling - try/catch/finally
* PInvoke; although it's not the most pleasant or fully-featured implementation possible, but it will work cross-platform without libffi
* Interfaces
* Delegates
* Events
* Nullable types
* Single-dimensional arrays
* Multi-threading; not using native threads, only actually runs in one native thread
* Very limited read-only reflection; typeof(), .GetType(), Type.Name, Type.Namespace, Type.IsEnum(), \<object\>.ToString() only

**Currently unsupported features**

* Attributes
* Most reflection
* Multi-dimensional arrays
* Unsafe code

Implementation
--------------

The Dot Net Anywhere interpreter JITs each method as required into an internal format, which is then interpreted using a [direct-threaded][3] interpreter. The JIT stage does a full stack-type analysis and explicitly stores type information within the internal format's opcodes, allowing considerably more efficient interpretation that if the CIL was directly interpreted.

Portability
-------------------------

Dot Net Anywhere has been designed to be fairly simple to port to custom platforms.

dna.exe and libIGraph.dll will need to be built for the platform. These are
written in C and use standard C11 payload accessors instead of zero-length
array members. Variable-size data is allocated after a fixed header and is
accessed through explicit pointer arithmetic.

The interpreter still uses compiler-specific threaded dispatch in
`JIT_Execute.c`: GCC and Clang use computed gotos, while MSVC uses the
existing architecture-specific assembly path. A fully portable switch- or
function-pointer-based dispatcher has not yet replaced this path.

The CMake configuration supports x86, x86_64, and ARM64 toolchains. Use
`DNA_FORCE_32BIT=ON` for an x86 build on a capable Linux host. The x86 runtime
configuration is verified; x86_64 and ARM64 still require runtime validation of
all metadata and JIT paths.

The only customisation that will generally be required is in the UI/input subsystem: The CustomDevice.dll managed library and the libIGraph.dll native library.

The embedded device that has been used for development has a 320x240 4-bit grey-scale screen and a 12-key keypad. This is all handled within the CustomDevice and libIGraph libraries, and will need to be customised for a device configuration.

To access the screen of the device, the CustomDevice class contains a method GetScreen() that returns a Graphics object that is the screen. If the device has a screen that is not a simple 2-D array of pixels then you will need to implement this differently.


[1]: http://www.mono-project.com
[2]: http://freetype.org
[3]: https://en.wikipedia.org/wiki/Threaded_code#Direct_threading
