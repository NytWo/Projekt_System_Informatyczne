
FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /src
COPY ["BethanysPieShop.csproj", "."]
RUN dotnet restore "./BethanysPieShop.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "BethanysPieShop.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "BethanysPieShop.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "BethanysPieShop.dll"]