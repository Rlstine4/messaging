include(CPM)

set(CPM_USE_LOCAL_PACKAGES ${USE_LOCAL_PACKAGES})

CPMAddPackage(
    NAME expected
    GITHUB_REPOSITORY TartanLlama/expected
    GIT_TAG v1.3.1
    OPTIONS
        "EXPECTED_BUILD_TESTS OFF"
        "EXPECTED_BUILD_PACKAGE OFF"
)

CPMAddPackage(
    NAME libzmq
    GITHUB_REPOSITORY zeromq/libzmq
    GIT_TAG v4.3.5
    OPTIONS
        "ZMQ_BUILD_TESTS OFF"
        "WITH_LIBSODIUM OFF"
        "WITH_PERF_TOOL OFF"
        "WITH_DOCS OFF"
)

# --- ZeroMQ: C++ bindings (header-only) --------------------------------------
CPMAddPackage(
    NAME cppzmq
    GITHUB_REPOSITORY zeromq/cppzmq
    GIT_TAG v4.11.0
    OPTIONS
        "CPPZMQ_BUILD_TESTS OFF"
)
