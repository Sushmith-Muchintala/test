# Go Version
FROM golang:1.22-alpine

# Environment variables which CompileDaemon requires to run
ENV PROJECT_DIR=/app \
    GO111MODULE=on \
    CGO_ENABLED=0

# Basic setup of the container
RUN mkdir /app
RUN mkdir /dp-scim2-parser
RUN mkdir /ia-jwt-parser
COPY ./dp-scim2-parser/ /dp-scim2-parser/
COPY ./ia-jwt-parser/ /ia-jwt-parser/
COPY ./im-alert-api /app
WORKDIR /app

# Get CompileDaemon
RUN go get github.com/githubnemo/CompileDaemon
RUN go install github.com/githubnemo/CompileDaemon

# The build flag sets how to build after a change has been detected in the source code
# The command flag sets how to run the app after it has been built
ENTRYPOINT CompileDaemon -build="go build -o api" -command="./api/alert-api"