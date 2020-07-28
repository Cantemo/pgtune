#! /bin/bash -xe

docker build -t pgtunebuild:el7 -f Dockerfile-el7 .
docker build -t pgtunebuild:el8 -f Dockerfile-el8 .

docker run --rm --user $(id -u):$(id -g) -v $PWD:$PWD -w $PWD pgtunebuild:el7 rpmbuild -D "%buildnumber $BUILD_NUMBER" -D "%_topdir $PWD/buildroot" -ba pgtune.spec
docker run --rm --user $(id -u):$(id -g) -v $PWD:$PWD -w $PWD pgtunebuild:el8 rpmbuild -D "%buildnumber $BUILD_NUMBER" -D "%_topdir $PWD/buildroot" -ba pgtune.spec

mv buildroot/RPMS/*/*.rpm .

# rpmbuild -ba pgtune.spec
