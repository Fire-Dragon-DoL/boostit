export const API_URL = process.env["REACT_APP_BOOM_URL"];

// opts:
// - token
// - body
export function apiRequest(method, urlText, opts = {}) {
  let token = opts["token"] || null;
  let url = `${API_URL}${urlText}`;
  let headers = new Headers();

  headers.append("Content-Type", "application/vnd.api+json");
  headers.append("Accept", "application/vnd.api+json");
  if (token !== null) {
    headers.append("Authorization", `Bearer ${token}`);
  }

  let params = {};
  params.headers = headers;
  params.method = method;
  if (opts.body) {
    params.body = opts.body;
  }

  return fetch(url, params).then((response) => {
    if (response.status < 200 || response.status > 299) {
      return Promise.reject(response);
    }
    return response;
  });
}
