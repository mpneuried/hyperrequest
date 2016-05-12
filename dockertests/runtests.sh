VERSIONS[0]="0.10"
VERSIONS[1]="0.12"
VERSIONS[2]="4.2"
VERSIONS[3]="5.0"
VERSIONS[4]="5.4"
VERSIONS[4]="6.1"
VERSIONS[5]="lts"
VERSIONS[6]="latest"


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

SCRIPTDIR="dockertests"
cd $DIR
cd ..

for version in "${VERSIONS[@]}"
do
   :
   FV=`echo $version | sed 's/\./_/'`
   DFile="Dockerfile_$FV"
   if [ -f "$SCRIPTDIR/$DFile" ]; then
	   echo "TEST Version: $version"
	   BUILDLOGS="$DIR/dockerbuild_$version.log"
	   rm -f $BUILDLOGS
	   echo "Start build ..."
	   docker build -t=mpneuried.hyperrequest.test.$version -f=$SCRIPTDIR/$DFile . > $BUILDLOGS
	   echo "Run test ..."
	   docker run mpneuried.hyperrequest.test.$version >&2
   else
	   echo "Dockerfile '$DFile' not found"
   fi
done
