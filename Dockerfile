FROM lsiobase/alpine:3.10

LABEL maintainer "Nicolas Coutin <ilshidur@gmail.com>"

RUN apk --no-cache add tor

EXPOSE 9001

COPY torrc.default /etc/tor/torrc.default
RUN chown -R tor /etc/tor

COPY entrypoint.sh /entrypoint.sh
RUN chmod ugo+rx /entrypoint.sh

ENV TOR_ORPort 9001
ENV TOR_ContactInfo "Random Person nobody@tor.org"
ENV TOR_RelayBandwidthRate "100 KBytes"
ENV TOR_RelayBandwidthBurst "200 KBytes"

USER tor

RUN mkdir /var/lib/tor/.tor
VOLUME /var/lib/tor/.tor
RUN chown -R tor /var/lib/tor/.tor

ENTRYPOINT [ "/entrypoint.sh" ]