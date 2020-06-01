export const API_URL = process.env["REACT_APP_BOOM_URL"];

export function request(urlText, opts = {}) {
  let url = `${API_URL}${urlText}`;

  return fetch(url).then((response) => {
    if (response.status < 200 || response.status > 299) {
      return Promise.reject(response);
    }
    return response;
  });
}
