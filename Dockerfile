FROM node:16-alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install

COPY . .

RUN npm run build


FROM nginx
# Drop everything from prev builder container and keep bare minimum : nginx and build files (no other dependencies for example)
COPY --from=builder /app/build /usr/share/nginx/html