# Copyright 2020 The BizFly Authors. All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

FROM golang:alpine3.11  AS build-env
WORKDIR /app
ADD . /app
RUN cd /app && GO111MODULE=on GOARCH=amd64 go build -o bizfly-cloud-controller-manager cmd/bizfly-cloud-controller-manager/main.go

FROM amd64/alpine:3.11

RUN apk add --no-cache ca-certificates

COPY --from=build-env /app/bizfly-cloud-controller-manager /bin/

CMD ["/bin/bizfly-cloud-controller-manager"]