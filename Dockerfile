ARG BASE_IMAGE
FROM alpine:edge AS download

ARG SOURCERY_LITE_VERSION=2011.03-42
WORKDIR /
RUN apk add --no-cache tar wget
RUN wget -q https://sourcery.mentor.com/public/gnu_toolchain/arm-none-eabi/arm-${SOURCERY_LITE_VERSION}-arm-none-eabi.src.tar.bz2
RUN wget -q -O- https://sourcery.mentor.com/public/gnu_toolchain/arm-none-eabi/arm-${SOURCERY_LITE_VERSION}-arm-none-eabi-i686-pc-linux-gnu.tar.bz2 | tar xjf - 
WORKDIR /opt/sourcery/${SOURCERY_LITE_VERSION}
RUN cp -R /arm-${SOURCERY_LITE_VERSION}-arm-none-eabi.src.tar.bz2 /arm-*/* .

FROM ${BASE_IMAGE}
ARG SOURCERY_LITE_VERSION=2011.03-42

USER root
COPY --from=download /opt/sourcery/${SOURCERY_LITE_VERSION}/ /opt/sourcery/${SOURCERY_LITE_VERSION}/
USER user
ENV PATH ${PATH}:/opt/sourcery/${SOURCERY_LITE_VERSION}
