# Repro in docker

```shell
docker buildx create --use --name multiarch --node multiarch0

# arm64 and amd64 works:
docker buildx build --pull --load --progress plain --platform linux/arm64 -t aws-lc-sys-riscv64-build-issue-repro:arm64 .
docker buildx build --pull --load --progress plain --platform linux/amd64 -t aws-lc-sys-riscv64-build-issue-repro:amd64 .

# riscv64 errors:
docker buildx build --pull --load --progress plain --platform linux/riscv64 -t aws-lc-sys-riscv64-build-issue-repro:riscv64 .
```

# Error

```
#9 73.99   Missing dependency: cmake
#9 73.99
#9 73.99   thread 'main' (736) panicked at /usr/local/cargo/registry/src/index.crates.io-1949cf8c6b5b557f/aws-lc-sys-0.33.0/builder/main.rs:475:40:
#9 73.99   called `Result::unwrap()` on an `Err` value: "Required build dependency is missing. Halting build."
```

# Full output

```
$ docker buildx build --pull --load --progress plain --platform linux/riscv64 -t test:riscv .
#0 building with "multiarch" instance using docker-container driver

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 462B done
#1 DONE 0.0s

#2 [internal] load metadata for docker.io/library/rust:1-trixie
#2 DONE 0.7s

#3 [internal] load .dockerignore
#3 transferring context: 2B done
#3 DONE 0.0s

#4 [1/5] FROM docker.io/library/rust:1-trixie@sha256:ad8c72c693b517ed60c930839daed91a5696fa6118f031d888cd0b7055a921a3
#4 resolve docker.io/library/rust:1-trixie@sha256:ad8c72c693b517ed60c930839daed91a5696fa6118f031d888cd0b7055a921a3 done
#4 CACHED

#5 [internal] load build context
#5 transferring context: 57.45MB 0.6s done
#5 DONE 0.6s

#6 [2/5] RUN apt-get update && apt-get install -y musl-tools
#6 0.411 Get:1 http://deb.debian.org/debian trixie InRelease [140 kB]
#6 0.482 Get:2 http://deb.debian.org/debian trixie-updates InRelease [47.3 kB]
#6 0.488 Get:3 http://deb.debian.org/debian-security trixie-security InRelease [43.4 kB]
#6 0.655 Get:4 http://deb.debian.org/debian trixie/main riscv64 Packages [9379 kB]
#6 3.560 Get:5 http://deb.debian.org/debian trixie-updates/main riscv64 Packages [5144 B]
#6 3.972 Get:6 http://deb.debian.org/debian-security trixie-security/main riscv64 Packages [67.4 kB]
#6 5.764 Fetched 9683 kB in 6s (1745 kB/s)
#6 5.764 Reading package lists...
#6 7.705 Reading package lists...
#6 9.603 Building dependency tree...
#6 9.960 Reading state information...
#6 10.23 The following additional packages will be installed:
#6 10.23   musl musl-dev
#6 10.33 The following NEW packages will be installed:
#6 10.33   musl musl-dev musl-tools
#6 10.43 0 upgraded, 3 newly installed, 0 to remove and 28 not upgraded.
#6 10.43 Need to get 1472 kB of archives.
#6 10.43 After this operation, 9194 kB of additional disk space will be used.
#6 10.43 Get:1 http://deb.debian.org/debian trixie/main riscv64 musl riscv64 1.2.5-3 [434 kB]
#6 10.53 Get:2 http://deb.debian.org/debian trixie/main riscv64 musl-dev riscv64 1.2.5-3 [996 kB]
#6 10.70 Get:3 http://deb.debian.org/debian trixie/main riscv64 musl-tools riscv64 1.2.5-3 [41.8 kB]
#6 13.06 Fetched 1472 kB in 0s (4114 kB/s)
#6 13.13 Selecting previously unselected package musl:riscv64.
(Reading database ... 26122 files and directories currently installed.)
#6 13.15 Preparing to unpack .../musl_1.2.5-3_riscv64.deb ...
#6 13.15 Unpacking musl:riscv64 (1.2.5-3) ...
#6 13.28 Selecting previously unselected package musl-dev:riscv64.
#6 13.28 Preparing to unpack .../musl-dev_1.2.5-3_riscv64.deb ...
#6 13.28 Unpacking musl-dev:riscv64 (1.2.5-3) ...
#6 13.50 Selecting previously unselected package musl-tools.
#6 13.50 Preparing to unpack .../musl-tools_1.2.5-3_riscv64.deb ...
#6 13.50 Unpacking musl-tools (1.2.5-3) ...
#6 13.58 Setting up musl:riscv64 (1.2.5-3) ...
#6 13.58 Setting up musl-dev:riscv64 (1.2.5-3) ...
#6 13.60 Setting up musl-tools (1.2.5-3) ...
#6 DONE 13.7s

#7 [3/5] WORKDIR /app
#7 DONE 0.0s

#8 [4/5] ADD . .
#8 DONE 0.1s

#9 [5/5] RUN case "riscv64" in       riscv64) TARGET=riscv64gc-unknown-linux-musl ;;       *) echo "Does not support riscv64" && exit 1 ;;     esac &&     rustup target add $TARGET &&     cargo build --target $TARGET
#9 0.640 info: downloading component 'rust-std' for 'riscv64gc-unknown-linux-musl'
#9 1.837 info: installing component 'rust-std' for 'riscv64gc-unknown-linux-musl'
#9 7.797     Updating crates.io index
#9 8.308  Downloading crates ...
#9 8.943   Downloaded cfg-if v1.0.4
#9 8.982   Downloaded shlex v1.3.0
#9 8.992   Downloaded quote v1.0.42
#9 9.005   Downloaded unicode-ident v1.0.22
#9 9.014   Downloaded proc-macro2 v1.0.103
#9 9.022   Downloaded memchr v2.7.6
#9 9.034   Downloaded minimal-lexical v0.2.1
#9 9.044   Downloaded nom v7.1.3
#9 9.055   Downloaded itertools v0.13.0
#9 9.064   Downloaded aho-corasick v1.1.4
#9 9.076   Downloaded cc v1.2.46
#9 9.087   Downloaded regex v1.12.2
#9 9.098   Downloaded prettyplease v0.2.37
#9 9.106   Downloaded log v0.4.28
#9 9.112   Downloaded find-msvc-tools v0.1.5
#9 9.116   Downloaded bitflags v2.10.0
#9 9.123   Downloaded bindgen v0.72.1
#9 9.139   Downloaded libloading v0.8.9
#9 9.144   Downloaded syn v2.0.110
#9 9.163   Downloaded jobserver v0.1.34
#9 9.167   Downloaded regex-syntax v0.8.8
#9 9.182   Downloaded glob v0.3.3
#9 9.185   Downloaded fs_extra v1.3.0
#9 9.190   Downloaded either v1.15.0
#9 9.193   Downloaded clang-sys v1.8.1
#9 9.198   Downloaded rustc-hash v2.1.1
#9 9.201   Downloaded dunce v1.0.5
#9 9.204   Downloaded cmake v0.1.54
#9 9.206   Downloaded cexpr v0.6.0
#9 9.217   Downloaded regex-automata v0.4.13
#9 9.250   Downloaded libc v0.2.177
#9 9.436   Downloaded aws-lc-sys v0.33.0
#9 9.927    Compiling libc v0.2.177
#9 9.929    Compiling proc-macro2 v1.0.103
#9 9.930    Compiling glob v0.3.3
#9 9.930    Compiling quote v1.0.42
#9 9.931    Compiling unicode-ident v1.0.22
#9 9.932    Compiling prettyplease v0.2.37
#9 9.932    Compiling minimal-lexical v0.2.1
#9 9.932    Compiling cfg-if v1.0.4
#9 9.933    Compiling regex-syntax v0.8.8
#9 9.934    Compiling shlex v1.3.0
#9 9.935    Compiling memchr v2.7.6
#9 9.935    Compiling find-msvc-tools v0.1.5
#9 9.935    Compiling either v1.15.0
#9 9.936    Compiling bindgen v0.72.1
#9 9.936    Compiling rustc-hash v2.1.1
#9 9.938    Compiling log v0.4.28
#9 10.67    Compiling libloading v0.8.9
#9 11.40    Compiling bitflags v2.10.0
#9 11.62    Compiling dunce v1.0.5
#9 12.05    Compiling fs_extra v1.3.0
#9 12.34    Compiling itertools v0.13.0
#9 13.76    Compiling nom v7.1.3
#9 14.04    Compiling clang-sys v1.8.1
#9 18.64    Compiling regex-automata v0.4.13
#9 20.63    Compiling syn v2.0.110
#9 21.07    Compiling jobserver v0.1.34
#9 23.07    Compiling cc v1.2.46
#9 24.37    Compiling cexpr v0.6.0
#9 28.44    Compiling regex v1.12.2
#9 28.84    Compiling cmake v0.1.54
#9 69.96    Compiling aws-lc-sys v0.33.0
#9 73.99 error: failed to run custom build command for `aws-lc-sys v0.33.0`
#9 73.99
#9 73.99 Caused by:
#9 73.99   process didn't exit successfully: `/app/target/debug/build/aws-lc-sys-453d47f01c56e298/build-script-main` (exit status: 101)
#9 73.99   --- stdout
#9 73.99   cargo:rerun-if-env-changed=AWS_LC_SYS_NO_PREFIX_riscv64gc_unknown_linux_musl
#9 73.99   cargo:rerun-if-env-changed=AWS_LC_SYS_NO_PREFIX
#9 73.99   cargo:rerun-if-env-changed=AWS_LC_SYS_PREGENERATING_BINDINGS_riscv64gc_unknown_linux_musl
#9 73.99   cargo:rerun-if-env-changed=AWS_LC_SYS_PREGENERATING_BINDINGS
#9 73.99   cargo:rerun-if-env-changed=AWS_LC_SYS_EXTERNAL_BINDGEN_riscv64gc_unknown_linux_musl
#9 73.99   cargo:rerun-if-env-changed=AWS_LC_SYS_EXTERNAL_BINDGEN
#9 73.99   cargo:rerun-if-env-changed=AWS_LC_SYS_NO_ASM_riscv64gc_unknown_linux_musl
#9 73.99   cargo:rerun-if-env-changed=AWS_LC_SYS_NO_ASM
#9 73.99   cargo:rerun-if-env-changed=AWS_LC_SYS_CFLAGS_riscv64gc_unknown_linux_musl
#9 73.99   cargo:rerun-if-env-changed=AWS_LC_SYS_CFLAGS
#9 73.99   cargo:rerun-if-env-changed=CFLAGS_riscv64gc_unknown_linux_musl
#9 73.99   cargo:rerun-if-env-changed=CFLAGS
#9 73.99   cargo:rerun-if-env-changed=AWS_LC_SYS_PREBUILT_NASM_riscv64gc_unknown_linux_musl
#9 73.99   cargo:rerun-if-env-changed=AWS_LC_SYS_PREBUILT_NASM
#9 73.99   cargo:rerun-if-env-changed=AWS_LC_SYS_C_STD_riscv64gc_unknown_linux_musl
#9 73.99   cargo:rerun-if-env-changed=AWS_LC_SYS_C_STD
#9 73.99   cargo:rerun-if-env-changed=AWS_LC_SYS_CMAKE_BUILDER_riscv64gc_unknown_linux_musl
#9 73.99   cargo:rerun-if-env-changed=AWS_LC_SYS_CMAKE_BUILDER
#9 73.99   cargo:rerun-if-env-changed=AWS_LC_SYS_NO_PREGENERATED_SRC_riscv64gc_unknown_linux_musl
#9 73.99   cargo:rerun-if-env-changed=AWS_LC_SYS_NO_PREGENERATED_SRC
#9 73.99   cargo:rerun-if-env-changed=AWS_LC_SYS_EFFECTIVE_TARGET_riscv64gc_unknown_linux_musl
#9 73.99   cargo:rerun-if-env-changed=AWS_LC_SYS_EFFECTIVE_TARGET
#9 73.99   cargo:rerun-if-env-changed=AWS_LC_SYS_NO_JITTER_ENTROPY_riscv64gc_unknown_linux_musl
#9 73.99   cargo:rerun-if-env-changed=AWS_LC_SYS_NO_JITTER_ENTROPY
#9 73.99   cargo:rerun-if-env-changed=AWS_LC_SYS_STATIC_riscv64gc_unknown_linux_musl
#9 73.99   cargo:rerun-if-env-changed=AWS_LC_SYS_STATIC
#9 73.99   cargo:rerun-if-env-changed=AWS_LC_SYS_CMAKE_riscv64gc_unknown_linux_musl
#9 73.99   cargo:rerun-if-env-changed=AWS_LC_SYS_CMAKE
#9 73.99   cargo:rerun-if-env-changed=CMAKE_riscv64gc_unknown_linux_musl
#9 73.99   cargo:rerun-if-env-changed=CMAKE
#9 73.99
#9 73.99   --- stderr
#9 73.99   Missing dependency: cmake
#9 73.99
#9 73.99   thread 'main' (736) panicked at /usr/local/cargo/registry/src/index.crates.io-1949cf8c6b5b557f/aws-lc-sys-0.33.0/builder/main.rs:475:40:
#9 73.99   called `Result::unwrap()` on an `Err` value: "Required build dependency is missing. Halting build."
#9 73.99   stack backtrace:
#9 73.99      0:     0x55555564a08c - std::backtrace_rs::backtrace::libunwind::trace::h19d02dae018996f6
#9 73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/../../backtrace/src/backtrace/libunwind.rs:117:9
#9 73.99      1:     0x55555564a08c - std::backtrace_rs::backtrace::trace_unsynchronized::hc3cf01dc2a509fe8
#9 73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/../../backtrace/src/backtrace/mod.rs:66:14
#9 73.99      2:     0x55555564a08c - std::sys::backtrace::_print_fmt::h7ca57c13d7771337
#9 73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/sys/backtrace.rs:66:9
#9 73.99      3:     0x55555564a08c - <std::sys::backtrace::BacktraceLock::print::DisplayBacktrace as core::fmt::Display>::fmt::he13866e547aa6474
#9 73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/sys/backtrace.rs:39:26
#9 73.99      4:     0x555555659da2 - core::fmt::rt::Argument::fmt::hcc8b946e999eeecd
#9 73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/core/src/fmt/rt.rs:173:76
#9 73.99      5:     0x555555659da2 - core::fmt::write::h7ec379caef9abfdb
#9 73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/core/src/fmt/mod.rs:1468:25
#9 73.99      6:     0x555555620a66 - std::io::default_write_fmt::h2048a2ecbd7d8b0e
#9 73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/io/mod.rs:639:11
#9 73.99      7:     0x555555620a66 - std::io::Write::write_fmt::ha075ff2089fc58e3
#9 73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/io/mod.rs:1954:13
#9 73.99      8:     0x55555562b512 - std::sys::backtrace::BacktraceLock::print::h59746be1dc3f7abc
#9 73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/sys/backtrace.rs:42:9
#9 73.99      9:     0x555555630870 - std::panicking::default_hook::{{closure}}::h386fed57fa940bb0
#9 73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/panicking.rs:301:27
#9 73.99     10:     0x5555556306ea - std::panicking::default_hook::hb9cf893a65344ff5
#9 73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/panicking.rs:328:9
#9 73.99     11:     0x555555630e1e - std::panicking::panic_with_hook::h672f94c943173e63
#9 73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/panicking.rs:834:13
#9 73.99     12:     0x555555630cc0 - std::panicking::panic_handler::{{closure}}::h6e50b63f3a768c45
#9 73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/panicking.rs:707:13
#9 73.99     13:     0x55555562b628 - std::sys::backtrace::__rust_end_short_backtrace::h1776227192369da8
#9 73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/sys/backtrace.rs:174:18
#9 73.99     14:     0x555555615e16 - __rustc[eb8946e36839644a]::rust_begin_unwind
#9 73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/panicking.rs:698:5
#9 73.99     15:     0x55555557fb14 - core::panicking::panic_fmt::h2fc2f0f9c939d323
#9 73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/core/src/panicking.rs:75:14
#9 73.99     16:     0x55555557f5c4 - core::result::unwrap_failed::hc3eb7511ec56f8e7
#9 73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/core/src/result.rs:1855:5
#9 73.99     17:     0x555555585804 - core::result::Result<T,E>::unwrap::h6c1d6954487267a4
#9 73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/core/src/result.rs:1226:23
#9 73.99     18:     0x555555585804 - build_script_main::get_builder::h68d4cd09206ca52c
#9 73.99                                  at /usr/local/cargo/registry/src/index.crates.io-1949cf8c6b5b557f/aws-lc-sys-0.33.0/builder/main.rs:475:40
#9 73.99     19:     0x55555558a0f2 - build_script_main::main::h0175d26f49e06254
#9 73.99                                  at /usr/local/cargo/registry/src/index.crates.io-1949cf8c6b5b557f/aws-lc-sys-0.33.0/builder/main.rs:734:19
#9 73.99     20:     0x555555599310 - core::ops::function::FnOnce::call_once::hcb70fbffb03de1f6
#9 73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/core/src/ops/function.rs:250:5
#9 73.99     21:     0x555555596d8c - std::sys::backtrace::__rust_begin_short_backtrace::haaafdb36e0c976b2
#9 73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/sys/backtrace.rs:158:18
#9 73.99     22:     0x5555555986e2 - std::rt::lang_start::{{closure}}::hd5e315373acebc77
#9 73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/rt.rs:206:18
#9 73.99     23:     0x555555621f12 - core::ops::function::impls::<impl core::ops::function::FnOnce<A> for &F>::call_once::h9571ef0ee0d04786
#9 73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/core/src/ops/function.rs:287:21
#9 73.99     24:     0x555555621f12 - std::panicking::catch_unwind::do_call::h343f9cc7cd80de60
#9 73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/panicking.rs:590:40
#9 73.99     25:     0x555555621f12 - std::panicking::catch_unwind::hf2d537e6d485b012
#9 73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/panicking.rs:553:19
#9 73.99     26:     0x555555621f12 - std::panic::catch_unwind::h1339bd80a946f56a
#9 73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/panic.rs:359:14
#9 73.99     27:     0x555555621f12 - std::rt::lang_start_internal::{{closure}}::hfaa56c44c107bf52
#9 73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/rt.rs:175:24
#9 73.99     28:     0x555555621f12 - std::panicking::catch_unwind::do_call::h5b4aff40e46fe173
#9 73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/panicking.rs:590:40
#9 73.99     29:     0x555555621f12 - std::panicking::catch_unwind::h5eb346487e3f797a
#9 73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/panicking.rs:553:19
#9 73.99     30:     0x555555621f12 - std::panic::catch_unwind::h8335f01e47495fc0
#9 73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/panic.rs:359:14
#9 73.99     31:     0x555555621f12 - std::rt::lang_start_internal::h0524d910d551d537
#9 73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/rt.rs:171:5
#9 73.99     32:     0x5555555986cc - std::rt::lang_start::hb31a164e08ee16a5
#9 73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/rt.rs:205:5
#9 73.99     33:     0x55555558b068 - main
#9 73.99     34:     0x2aaaab31d99c - <unknown>
#9 73.99     35:     0x2aaaab31da44 - __libc_start_main
#9 73.99     36:     0x55555557fb34 - _start
#9 73.99     37:                0x0 - <unknown>
#9 ERROR: process "/bin/sh -c case \"$TARGETARCH\" in       riscv64) TARGET=riscv64gc-unknown-linux-musl ;;       *) echo \"Does not support $TARGETARCH\" && exit 1 ;;     esac &&     rustup target add $TARGET &&     cargo build --target $TARGET" did not complete successfully: exit code: 101
------
 > [5/5] RUN case "riscv64" in       riscv64) TARGET=riscv64gc-unknown-linux-musl ;;       *) echo "Does not support riscv64" && exit 1 ;;     esac &&     rustup target add $TARGET &&     cargo build --target $TARGET:
73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/panic.rs:359:14
73.99     31:     0x555555621f12 - std::rt::lang_start_internal::h0524d910d551d537
73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/rt.rs:171:5
73.99     32:     0x5555555986cc - std::rt::lang_start::hb31a164e08ee16a5
73.99                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/rt.rs:205:5
73.99     33:     0x55555558b068 - main
73.99     34:     0x2aaaab31d99c - <unknown>
73.99     35:     0x2aaaab31da44 - __libc_start_main
73.99     36:     0x55555557fb34 - _start
73.99     37:                0x0 - <unknown>
------
Dockerfile:15
--------------------
  14 |
  15 | >>> RUN case "$TARGETARCH" in \
  16 | >>>       riscv64) TARGET=riscv64gc-unknown-linux-musl ;; \
  17 | >>>       *) echo "Does not support $TARGETARCH" && exit 1 ;; \
  18 | >>>     esac && \
  19 | >>>     rustup target add $TARGET && \
  20 | >>>     cargo build --target $TARGET
  21 |
--------------------
ERROR: failed to build: failed to solve: process "/bin/sh -c case \"$TARGETARCH\" in       riscv64) TARGET=riscv64gc-unknown-linux-musl ;;       *) echo \"Does not support $TARGETARCH\" && exit 1 ;;     esac &&     rustup target add $TARGET &&     cargo build --target $TARGET" did not complete successfully: exit code: 101
```

I tried after installing `cmake` too but was pretty sure it was still going to fail:

```
$ docker buildx build --pull --load --progress plain --platform linux/riscv64 -t test:riscv .
#0 building with "multiarch" instance using docker-container driver

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 491B done
#1 DONE 0.0s

#2 [internal] load metadata for docker.io/library/rust:1-trixie
#2 DONE 0.6s

#3 [internal] load .dockerignore
#3 transferring context: 2B done
#3 DONE 0.0s

#4 [1/6] FROM docker.io/library/rust:1-trixie@sha256:ad8c72c693b517ed60c930839daed91a5696fa6118f031d888cd0b7055a921a3
#4 resolve docker.io/library/rust:1-trixie@sha256:ad8c72c693b517ed60c930839daed91a5696fa6118f031d888cd0b7055a921a3 done
#4 DONE 0.0s

#5 [2/6] RUN apt-get update && apt-get install -y musl-tools
#5 CACHED

#6 [internal] load build context
#6 transferring context: 63.41kB 0.0s done
#6 DONE 0.0s

#7 [3/6] RUN apt-get install -y cmake
#7 0.112 Reading package lists...
#7 2.006 Building dependency tree...
#7 2.368 Reading state information...
#7 2.638 The following additional packages will be installed:
#7 2.639   cmake-data libarchive13t64 libjsoncpp26 librhash1 libuv1t64
#7 2.641 Suggested packages:
#7 2.641   cmake-doc cmake-format elpa-cmake-mode ninja-build lrzip
#7 2.798 The following NEW packages will be installed:
#7 2.799   cmake cmake-data libarchive13t64 libjsoncpp26 librhash1 libuv1t64
#7 2.915 0 upgraded, 6 newly installed, 0 to remove and 28 not upgraded.
#7 2.915 Need to get 14.2 MB of archives.
#7 2.915 After this operation, 43.7 MB of additional disk space will be used.
#7 2.915 Get:1 http://deb.debian.org/debian trixie/main riscv64 cmake-data all 3.31.6-2 [2268 kB]
#7 3.346 Get:2 http://deb.debian.org/debian trixie/main riscv64 libarchive13t64 riscv64 3.7.4-4 [366 kB]
#7 3.436 Get:3 http://deb.debian.org/debian trixie/main riscv64 libjsoncpp26 riscv64 1.9.6-3 [78.1 kB]
#7 3.440 Get:4 http://deb.debian.org/debian trixie/main riscv64 librhash1 riscv64 1.4.5-1 [145 kB]
#7 3.479 Get:5 http://deb.debian.org/debian trixie/main riscv64 libuv1t64 riscv64 1.50.0-2 [154 kB]
#7 3.514 Get:6 http://deb.debian.org/debian trixie/main riscv64 cmake riscv64 3.31.6-2 [11.2 MB]
#7 8.439 Fetched 14.2 MB in 3s (4394 kB/s)
#7 8.521 Selecting previously unselected package cmake-data.
(Reading database ... 26390 files and directories currently installed.)
#7 8.542 Preparing to unpack .../0-cmake-data_3.31.6-2_all.deb ...
#7 8.589 Unpacking cmake-data (3.31.6-2) ...
#7 8.933 Selecting previously unselected package libarchive13t64:riscv64.
#7 8.937 Preparing to unpack .../1-libarchive13t64_3.7.4-4_riscv64.deb ...
#7 8.939 Unpacking libarchive13t64:riscv64 (3.7.4-4) ...
#7 9.053 Selecting previously unselected package libjsoncpp26:riscv64.
#7 9.055 Preparing to unpack .../2-libjsoncpp26_1.9.6-3_riscv64.deb ...
#7 9.056 Unpacking libjsoncpp26:riscv64 (1.9.6-3) ...
#7 9.135 Selecting previously unselected package librhash1:riscv64.
#7 9.137 Preparing to unpack .../3-librhash1_1.4.5-1_riscv64.deb ...
#7 9.138 Unpacking librhash1:riscv64 (1.4.5-1) ...
#7 9.224 Selecting previously unselected package libuv1t64:riscv64.
#7 9.226 Preparing to unpack .../4-libuv1t64_1.50.0-2_riscv64.deb ...
#7 9.226 Unpacking libuv1t64:riscv64 (1.50.0-2) ...
#7 9.313 Selecting previously unselected package cmake.
#7 9.315 Preparing to unpack .../5-cmake_3.31.6-2_riscv64.deb ...
#7 9.316 Unpacking cmake (3.31.6-2) ...
#7 10.52 Setting up libuv1t64:riscv64 (1.50.0-2) ...
#7 10.52 Setting up libjsoncpp26:riscv64 (1.9.6-3) ...
#7 10.53 Setting up cmake-data (3.31.6-2) ...
#7 10.57 Setting up librhash1:riscv64 (1.4.5-1) ...
#7 10.58 Setting up libarchive13t64:riscv64 (3.7.4-4) ...
#7 10.58 Setting up cmake (3.31.6-2) ...
#7 10.58 Processing triggers for libc-bin (2.41-12) ...
#7 DONE 10.7s

#8 [4/6] WORKDIR /app
#8 DONE 0.0s

#9 [5/6] ADD . .
#9 DONE 0.1s

#10 [6/6] RUN case "riscv64" in       riscv64) TARGET=riscv64gc-unknown-linux-musl ;;       *) echo "Does not support riscv64" && exit 1 ;;     esac &&     rustup target add $TARGET &&     cargo build --target $TARGET
#10 0.643 info: downloading component 'rust-std' for 'riscv64gc-unknown-linux-musl'
#10 1.929 info: installing component 'rust-std' for 'riscv64gc-unknown-linux-musl'
#10 7.951     Updating crates.io index
#10 8.427  Downloading crates ...
#10 8.559   Downloaded bitflags v2.10.0
#10 8.613   Downloaded shlex v1.3.0
#10 8.623   Downloaded unicode-ident v1.0.22
#10 8.632   Downloaded proc-macro2 v1.0.103
#10 8.643   Downloaded log v0.4.28
#10 8.652   Downloaded bindgen v0.72.1
#10 8.674   Downloaded aho-corasick v1.1.4
#10 8.689   Downloaded quote v1.0.42
#10 8.697   Downloaded libloading v0.8.9
#10 8.706   Downloaded prettyplease v0.2.37
#10 8.714   Downloaded minimal-lexical v0.2.1
#10 8.725   Downloaded memchr v2.7.6
#10 8.734   Downloaded nom v7.1.3
#10 8.747   Downloaded itertools v0.13.0
#10 8.759   Downloaded regex v1.12.2
#10 8.771   Downloaded cc v1.2.46
#10 8.778   Downloaded jobserver v0.1.34
#10 8.783   Downloaded glob v0.3.3
#10 8.787   Downloaded find-msvc-tools v0.1.5
#10 8.791   Downloaded clang-sys v1.8.1
#10 8.797   Downloaded rustc-hash v2.1.1
#10 8.800   Downloaded fs_extra v1.3.0
#10 8.805   Downloaded syn v2.0.110
#10 8.823   Downloaded either v1.15.0
#10 8.826   Downloaded dunce v1.0.5
#10 8.829   Downloaded regex-syntax v0.8.8
#10 8.844   Downloaded cmake v0.1.54
#10 8.847   Downloaded cfg-if v1.0.4
#10 8.850   Downloaded cexpr v0.6.0
#10 8.864   Downloaded regex-automata v0.4.13
#10 8.898   Downloaded libc v0.2.177
#10 9.076   Downloaded aws-lc-sys v0.33.0
#10 9.583    Compiling libc v0.2.177
#10 9.585    Compiling proc-macro2 v1.0.103
#10 9.586    Compiling unicode-ident v1.0.22
#10 9.586    Compiling glob v0.3.3
#10 9.587    Compiling quote v1.0.42
#10 9.587    Compiling prettyplease v0.2.37
#10 9.588    Compiling cfg-if v1.0.4
#10 9.589    Compiling memchr v2.7.6
#10 9.589    Compiling minimal-lexical v0.2.1
#10 9.589    Compiling shlex v1.3.0
#10 9.590    Compiling regex-syntax v0.8.8
#10 9.590    Compiling find-msvc-tools v0.1.5
#10 9.592    Compiling bindgen v0.72.1
#10 9.592    Compiling either v1.15.0
#10 9.592    Compiling rustc-hash v2.1.1
#10 9.594    Compiling log v0.4.28
#10 10.36    Compiling libloading v0.8.9
#10 11.09    Compiling bitflags v2.10.0
#10 11.25    Compiling dunce v1.0.5
#10 11.63    Compiling fs_extra v1.3.0
#10 12.06    Compiling itertools v0.13.0
#10 13.39    Compiling nom v7.1.3
#10 13.61    Compiling clang-sys v1.8.1
#10 18.05    Compiling regex-automata v0.4.13
#10 20.39    Compiling syn v2.0.110
#10 20.77    Compiling jobserver v0.1.34
#10 22.77    Compiling cc v1.2.46
#10 24.09    Compiling cexpr v0.6.0
#10 27.92    Compiling regex v1.12.2
#10 28.58    Compiling cmake v0.1.54
#10 69.75    Compiling aws-lc-sys v0.33.0
#10 73.90 warning: aws-lc-sys@0.33.0: Building with: CMake
#10 73.90 warning: aws-lc-sys@0.33.0: Symbol Prefix: Some("aws_lc_0_33_0")
#10 73.90 warning: aws-lc-sys@0.33.0: Environment Variable found 'CMAKE': 'cmake'
#10 73.90 warning: aws-lc-sys@0.33.0: CMAKE environment variable set: cmake
#10 73.90 warning: aws-lc-sys@0.33.0: Target platform: 'riscv64gc-unknown-linux-musl'
#10 73.90 warning: aws-lc-sys@0.33.0: ######
#10 73.90 warning: aws-lc-sys@0.33.0: If bindgen is unable to locate a header file, use the BINDGEN_EXTRA_CLANG_ARGS environment variable to specify additional include paths.
#10 73.90 warning: aws-lc-sys@0.33.0: See: https://github.com/rust-lang/rust-bindgen?tab=readme-ov-file#environment-variables
#10 73.90 warning: aws-lc-sys@0.33.0: ######
#10 73.90 error: failed to run custom build command for `aws-lc-sys v0.33.0`
#10 73.90
#10 73.90 Caused by:
#10 73.90   process didn't exit successfully: `/app/target/debug/build/aws-lc-sys-453d47f01c56e298/build-script-main` (exit status: 101)
#10 73.90   --- stdout
#10 73.90   cargo:rerun-if-env-changed=AWS_LC_SYS_NO_PREFIX_riscv64gc_unknown_linux_musl
#10 73.90   cargo:rerun-if-env-changed=AWS_LC_SYS_NO_PREFIX
#10 73.90   cargo:rerun-if-env-changed=AWS_LC_SYS_PREGENERATING_BINDINGS_riscv64gc_unknown_linux_musl
#10 73.90   cargo:rerun-if-env-changed=AWS_LC_SYS_PREGENERATING_BINDINGS
#10 73.90   cargo:rerun-if-env-changed=AWS_LC_SYS_EXTERNAL_BINDGEN_riscv64gc_unknown_linux_musl
#10 73.90   cargo:rerun-if-env-changed=AWS_LC_SYS_EXTERNAL_BINDGEN
#10 73.90   cargo:rerun-if-env-changed=AWS_LC_SYS_NO_ASM_riscv64gc_unknown_linux_musl
#10 73.90   cargo:rerun-if-env-changed=AWS_LC_SYS_NO_ASM
#10 73.90   cargo:rerun-if-env-changed=AWS_LC_SYS_CFLAGS_riscv64gc_unknown_linux_musl
#10 73.90   cargo:rerun-if-env-changed=AWS_LC_SYS_CFLAGS
#10 73.90   cargo:rerun-if-env-changed=CFLAGS_riscv64gc_unknown_linux_musl
#10 73.90   cargo:rerun-if-env-changed=CFLAGS
#10 73.90   cargo:rerun-if-env-changed=AWS_LC_SYS_PREBUILT_NASM_riscv64gc_unknown_linux_musl
#10 73.90   cargo:rerun-if-env-changed=AWS_LC_SYS_PREBUILT_NASM
#10 73.90   cargo:rerun-if-env-changed=AWS_LC_SYS_C_STD_riscv64gc_unknown_linux_musl
#10 73.90   cargo:rerun-if-env-changed=AWS_LC_SYS_C_STD
#10 73.90   cargo:rerun-if-env-changed=AWS_LC_SYS_CMAKE_BUILDER_riscv64gc_unknown_linux_musl
#10 73.90   cargo:rerun-if-env-changed=AWS_LC_SYS_CMAKE_BUILDER
#10 73.90   cargo:rerun-if-env-changed=AWS_LC_SYS_NO_PREGENERATED_SRC_riscv64gc_unknown_linux_musl
#10 73.90   cargo:rerun-if-env-changed=AWS_LC_SYS_NO_PREGENERATED_SRC
#10 73.90   cargo:rerun-if-env-changed=AWS_LC_SYS_EFFECTIVE_TARGET_riscv64gc_unknown_linux_musl
#10 73.90   cargo:rerun-if-env-changed=AWS_LC_SYS_EFFECTIVE_TARGET
#10 73.90   cargo:rerun-if-env-changed=AWS_LC_SYS_NO_JITTER_ENTROPY_riscv64gc_unknown_linux_musl
#10 73.90   cargo:rerun-if-env-changed=AWS_LC_SYS_NO_JITTER_ENTROPY
#10 73.90   cargo:rerun-if-env-changed=AWS_LC_SYS_STATIC_riscv64gc_unknown_linux_musl
#10 73.90   cargo:rerun-if-env-changed=AWS_LC_SYS_STATIC
#10 73.90   cargo:rerun-if-env-changed=AWS_LC_SYS_CMAKE_riscv64gc_unknown_linux_musl
#10 73.90   cargo:rerun-if-env-changed=AWS_LC_SYS_CMAKE
#10 73.90   cargo:rerun-if-env-changed=CMAKE_riscv64gc_unknown_linux_musl
#10 73.90   cargo:rerun-if-env-changed=CMAKE
#10 73.90   cargo:warning=Building with: CMake
#10 73.90   cargo:warning=Symbol Prefix: Some("aws_lc_0_33_0")
#10 73.90   cargo:rerun-if-env-changed=AWS_LC_SYS_CMAKE_riscv64gc_unknown_linux_musl
#10 73.90   cargo:rerun-if-env-changed=AWS_LC_SYS_CMAKE
#10 73.90   cargo:rerun-if-env-changed=CMAKE_riscv64gc_unknown_linux_musl
#10 73.90   cargo:rerun-if-env-changed=CMAKE
#10 73.90   cargo:warning=Environment Variable found 'CMAKE': 'cmake'
#10 73.90   cargo:warning=CMAKE environment variable set: cmake
#10 73.90   cargo:warning=Target platform: 'riscv64gc-unknown-linux-musl'
#10 73.90   cargo:warning=######
#10 73.90   cargo:warning=If bindgen is unable to locate a header file, use the BINDGEN_EXTRA_CLANG_ARGS environment variable to specify additional include paths.
#10 73.90   cargo:warning=See: https://github.com/rust-lang/rust-bindgen?tab=readme-ov-file#environment-variables
#10 73.90   cargo:warning=######
#10 73.90
#10 73.90   --- stderr
#10 73.90   bindgen-cli exited with an error status:
#10 73.90   STDOUT:
#10 73.90
#10 73.90   STDERR:
#10 73.90   Failure invoking external bindgen! External bindgen command failed.
#10 73.90
#10 73.90   thread 'main' (736) panicked at /usr/local/cargo/registry/src/index.crates.io-1949cf8c6b5b557f/aws-lc-sys-0.33.0/builder/main.rs:803:5:
#10 73.90   aws-lc-sys build failed. Please enable the 'bindgen' feature on aws-lc-rs or aws-lc-sys.For more information, see the aws-lc-rs User Guide: https://aws.github.io/aws-lc-rs/index.html
#10 73.90   stack backtrace:
#10 73.90      0:     0x55555564a08c - std::backtrace_rs::backtrace::libunwind::trace::h19d02dae018996f6
#10 73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/../../backtrace/src/backtrace/libunwind.rs:117:9
#10 73.90      1:     0x55555564a08c - std::backtrace_rs::backtrace::trace_unsynchronized::hc3cf01dc2a509fe8
#10 73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/../../backtrace/src/backtrace/mod.rs:66:14
#10 73.90      2:     0x55555564a08c - std::sys::backtrace::_print_fmt::h7ca57c13d7771337
#10 73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/sys/backtrace.rs:66:9
#10 73.90      3:     0x55555564a08c - <std::sys::backtrace::BacktraceLock::print::DisplayBacktrace as core::fmt::Display>::fmt::he13866e547aa6474
#10 73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/sys/backtrace.rs:39:26
#10 73.90      4:     0x555555659da2 - core::fmt::rt::Argument::fmt::hcc8b946e999eeecd
#10 73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/core/src/fmt/rt.rs:173:76
#10 73.90      5:     0x555555659da2 - core::fmt::write::h7ec379caef9abfdb
#10 73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/core/src/fmt/mod.rs:1468:25
#10 73.90      6:     0x555555620a66 - std::io::default_write_fmt::h2048a2ecbd7d8b0e
#10 73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/io/mod.rs:639:11
#10 73.90      7:     0x555555620a66 - std::io::Write::write_fmt::ha075ff2089fc58e3
#10 73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/io/mod.rs:1954:13
#10 73.90      8:     0x55555562b512 - std::sys::backtrace::BacktraceLock::print::h59746be1dc3f7abc
#10 73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/sys/backtrace.rs:42:9
#10 73.90      9:     0x555555630870 - std::panicking::default_hook::{{closure}}::h386fed57fa940bb0
#10 73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/panicking.rs:301:27
#10 73.90     10:     0x5555556306ea - std::panicking::default_hook::hb9cf893a65344ff5
#10 73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/panicking.rs:328:9
#10 73.90     11:     0x555555630e1e - std::panicking::panic_with_hook::h672f94c943173e63
#10 73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/panicking.rs:834:13
#10 73.90     12:     0x555555630c94 - std::panicking::panic_handler::{{closure}}::h6e50b63f3a768c45
#10 73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/panicking.rs:700:13
#10 73.90     13:     0x55555562b628 - std::sys::backtrace::__rust_end_short_backtrace::h1776227192369da8
#10 73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/sys/backtrace.rs:174:18
#10 73.90     14:     0x555555615e16 - __rustc[eb8946e36839644a]::rust_begin_unwind
#10 73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/panicking.rs:698:5
#10 73.90     15:     0x55555557fb14 - core::panicking::panic_fmt::h2fc2f0f9c939d323
#10 73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/core/src/panicking.rs:75:14
#10 73.90     16:     0x55555558a7fc - build_script_main::main::h0175d26f49e06254
#10 73.90                                  at /usr/local/cargo/registry/src/index.crates.io-1949cf8c6b5b557f/aws-lc-sys-0.33.0/builder/main.rs:803:5
#10 73.90     17:     0x555555599310 - core::ops::function::FnOnce::call_once::hcb70fbffb03de1f6
#10 73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/core/src/ops/function.rs:250:5
#10 73.90     18:     0x555555596d8c - std::sys::backtrace::__rust_begin_short_backtrace::haaafdb36e0c976b2
#10 73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/sys/backtrace.rs:158:18
#10 73.90     19:     0x5555555986e2 - std::rt::lang_start::{{closure}}::hd5e315373acebc77
#10 73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/rt.rs:206:18
#10 73.90     20:     0x555555621f12 - core::ops::function::impls::<impl core::ops::function::FnOnce<A> for &F>::call_once::h9571ef0ee0d04786
#10 73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/core/src/ops/function.rs:287:21
#10 73.90     21:     0x555555621f12 - std::panicking::catch_unwind::do_call::h343f9cc7cd80de60
#10 73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/panicking.rs:590:40
#10 73.90     22:     0x555555621f12 - std::panicking::catch_unwind::hf2d537e6d485b012
#10 73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/panicking.rs:553:19
#10 73.90     23:     0x555555621f12 - std::panic::catch_unwind::h1339bd80a946f56a
#10 73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/panic.rs:359:14
#10 73.90     24:     0x555555621f12 - std::rt::lang_start_internal::{{closure}}::hfaa56c44c107bf52
#10 73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/rt.rs:175:24
#10 73.90     25:     0x555555621f12 - std::panicking::catch_unwind::do_call::h5b4aff40e46fe173
#10 73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/panicking.rs:590:40
#10 73.90     26:     0x555555621f12 - std::panicking::catch_unwind::h5eb346487e3f797a
#10 73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/panicking.rs:553:19
#10 73.90     27:     0x555555621f12 - std::panic::catch_unwind::h8335f01e47495fc0
#10 73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/panic.rs:359:14
#10 73.90     28:     0x555555621f12 - std::rt::lang_start_internal::h0524d910d551d537
#10 73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/rt.rs:171:5
#10 73.90     29:     0x5555555986cc - std::rt::lang_start::hb31a164e08ee16a5
#10 73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/rt.rs:205:5
#10 73.90     30:     0x55555558b068 - main
#10 73.90     31:     0x2aaaab31d99c - <unknown>
#10 73.90     32:     0x2aaaab31da44 - __libc_start_main
#10 73.90     33:     0x55555557fb34 - _start
#10 73.90     34:                0x0 - <unknown>
#10 ERROR: process "/bin/sh -c case \"$TARGETARCH\" in       riscv64) TARGET=riscv64gc-unknown-linux-musl ;;       *) echo \"Does not support $TARGETARCH\" && exit 1 ;;     esac &&     rustup target add $TARGET &&     cargo build --target $TARGET" did not complete successfully: exit code: 101
------
 > [6/6] RUN case "riscv64" in       riscv64) TARGET=riscv64gc-unknown-linux-musl ;;       *) echo "Does not support riscv64" && exit 1 ;;     esac &&     rustup target add $TARGET &&     cargo build --target $TARGET:
73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/panic.rs:359:14
73.90     28:     0x555555621f12 - std::rt::lang_start_internal::h0524d910d551d537
73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/rt.rs:171:5
73.90     29:     0x5555555986cc - std::rt::lang_start::hb31a164e08ee16a5
73.90                                  at /rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/std/src/rt.rs:205:5
73.90     30:     0x55555558b068 - main
73.90     31:     0x2aaaab31d99c - <unknown>
73.90     32:     0x2aaaab31da44 - __libc_start_main
73.90     33:     0x55555557fb34 - _start
73.90     34:                0x0 - <unknown>
------
Dockerfile:16
--------------------
  15 |
  16 | >>> RUN case "$TARGETARCH" in \
  17 | >>>       riscv64) TARGET=riscv64gc-unknown-linux-musl ;; \
  18 | >>>       *) echo "Does not support $TARGETARCH" && exit 1 ;; \
  19 | >>>     esac && \
  20 | >>>     rustup target add $TARGET && \
  21 | >>>     cargo build --target $TARGET
  22 |
--------------------
ERROR: failed to build: failed to solve: process "/bin/sh -c case \"$TARGETARCH\" in       riscv64) TARGET=riscv64gc-unknown-linux-musl ;;       *) echo \"Does not support $TARGETARCH\" && exit 1 ;;     esac &&     rustup target add $TARGET &&     cargo build --target $TARGET" did not complete successfully: exit code: 101
```
