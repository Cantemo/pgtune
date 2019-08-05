#! /bin/bash -xe

docker build -t pgtunebuild:el6 -f Dockerfile-el6 .
docker build -t pgtunebuild:el7 -f Dockerfile-el7 .

docker run --rm -v $PWD:$PWD -w $PWD pgtunebuild:el7 rpmbuild -D "%buildnumber $BUILD_NUMBER" -D "%_topdir $PWD/buildroot" -ba pgtune.spec
docker run --rm -v $PWD:$PWD -w $PWD pgtunebuild:el6 rpmbuild -D "%buildnumber $BUILD_NUMBER" -D "%_topdir $PWD/buildroot" -ba pgtune.spec

mv buildroot/RPMS/*/*.rpm .

# rpmbuild -ba pgtune.spec
