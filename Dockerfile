FROM mcr.microsoft.com/dotnet/sdk:3.1-alpine3.14 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY ./ ./
RUN dotnet restore

# Copy everything else and build
RUN dotnet publish -c Release -o out

#Testing application
#RUN dotnet test out/XUnitTests.dll

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:3.1.21-alpine3.14

WORKDIR /app

#copying publish code 
COPY --from=build-env /app/out .

ENTRYPOINT ["dotnet", "TodoApi.dll"]
