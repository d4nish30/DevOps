FROM node:16-alpine AS build
WORKDIR /app
COPY app.html /app


FROM node:16-alpine
WORKDIR /app
COPY --from=build /app/app.html .
EXPOSE 8000
CMD ["node"] 