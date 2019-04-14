#!/bin/bash

##### Beginning of file

set -ev

julia --check-bounds=yes --color=yes -e '
    import Pkg;
    Pkg.build("DelayedErrors");
    '

julia --check-bounds=yes --color=yes -e '
    import DelayedErrors;
    '

export JULIA_DEBUG="all"

julia --check-bounds=yes --color=yes -e '
    import Pkg;
    Pkg.test("DelayedErrors"; coverage=true);
    '

julia --check-bounds=yes --color=yes -e '
    import Pkg;
    try Pkg.add("Coverage") catch end;
    '

julia --check-bounds=yes --color=yes --code-coverage=all test/test-0.jl

julia --check-bounds=yes --color=yes --code-coverage=all test/test-1.jl ||
    echo "An exception was thrown."

julia --check-bounds=yes --color=yes -e '
    import Coverage;
    import DelayedErrors;
    cd(joinpath(dirname(pathof(DelayedErrors)), ".."));
    Coverage.Codecov.submit(Coverage.Codecov.process_folder());
    '

cat Project.toml

cat Manifest.toml

##### End of file
