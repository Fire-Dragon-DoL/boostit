import { apiRequest } from "./API.js";

export function current(token) {
  console.info("GET /current");

  return apiRequest("GET", "/current", { token }).then(async (response) => {
    let result = await response.json();
    return result["data"]["attributes"]["current"];
  });
}

export function reset(token, value) {
  let data = { current: value };
  let body = JSON.stringify(data);
  console.info(`PUT /current ${body}`);

  return apiRequest("PUT", "/current", { token, body }).then(
    async (response) => {
      let result = await response.json();
      return result["data"]["attributes"]["current"];
    }
  );
}

export function next(token) {
  console.info("GET /next");

  return apiRequest("GET", "/next", { token }).then(async (response) => {
    let result = await response.json();
    return result["data"]["attributes"]["current"];
  });
}
