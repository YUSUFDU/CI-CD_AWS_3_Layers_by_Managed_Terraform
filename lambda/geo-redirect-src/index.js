'use strict';

exports.handler = (event, context, callback) => {
  const request = event.Records[0].cf.request;
  const headers = request.headers;

  const country = headers['cloudfront-viewer-country'] ? headers['cloudfront-viewer-country'][0].value : null;

  // Basit örnek: TR dışındakileri 'us.example.com' a yönlendir
  if (country && country !== 'TR') {
    const response = {
      status: '302',
      statusDescription: 'Found',
      headers: {
        location: [{
          key: 'Location',
          value: 'https://us.example.com' + request.uri
        }]
      }
    };
    callback(null, response);
  } else {
    callback(null, request);
  }
};
