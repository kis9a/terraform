"use strict";

const white_list = ["${admin_ip}", "${vpn_ip}"];

exports.handler = (event, _, callback) => {
  const request = event.Records[0].cf.request;
  const isAdminURI = request.uri.includes("${admin_path}");
  const isAdminIP = white_list.includes(request.clientIp);
  if (!isAdminURI) {
    callback(null, request);
  } else {
    if (isAdminIP) {
      callback(null, request);
    } else {
      callback(null, {
        status: "403",
        statusDescription: "Forbidden",
        httpVersion: request.httpVersion,
        body: "<!DOCTYPE html><html><head><title>403</title></head><body>Not allowed IP address</body></html>",
        headers: {
          "cache-control": [
            {
              key: "Cache-Control",
              value: "max-age=100",
            },
          ],
          "content-type": [
            {
              key: "Content-Type",
              value: "text/html; charset=utf-8",
            },
          ],
        },
      });
    }
  }
};
