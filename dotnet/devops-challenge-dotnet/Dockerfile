FROM mcr.microsoft.com/dotnet/aspnet:5.0

ARG BUILD_ARTIFACTSTAGINGDIRECTORY

## Initial folder creation, copying contents
RUN apt-get update \
    && apt install -y unzip \
    && mkdir -p /app/ReleaseFolder/ \
    && chmod 755 /app/ReleaseFolder/

WORKDIR /app

COPY $BUILD_ARTIFACTSTAGINGDIRECTORY /app

## Expose port
EXPOSE 5000/tcp

## Unzip output from dotnet publish task /app/ReleaseFolder/ folder
RUN unzip /app/DevOpsChallenge.SalesApi.zip -d /app/ReleaseFolder/

ENTRYPOINT ["dotnet", "/app/ReleaseFolder/DevOpsChallenge.SalesApi.dll"]
