FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
USER app
WORKDIR /app
EXPOSE 8080
EXPOSE 8081

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["ApiExample.csproj", "."]
RUN dotnet restore "./././ApiExample.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "./ApiExample.csproj" -c $BUILD_CONFIGURATION -o /app/build

FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "./ApiExample.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .

ENV ASPNETCORE_URLS=http://+:8080
# (optional but nice on newer .NET) 
ENV ASPNETCORE_HTTP_PORTS=8080

ENTRYPOINT ["dotnet", "ApiExample.dll"]