echo Removing containers and work files
docker-compose down
rm -Rf jenkins/jobs/docker-builder/builds jenkins/jobs/docker-builder/nextBuildNumber jenkins/jobs/docker-builder/workspace work/
