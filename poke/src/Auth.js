import { apiRequest } from "./API.js";

export function signUp(email, password, passwordConfirmation) {
  let data = {
    user: { email, password, password_confirmation: passwordConfirmation },
  };
  let body = JSON.stringify(data);

  return apiRequest("POST", "/users", { body }).then((response) => {
    let auth = response.headers.get("Authorization");
    return auth.replace("Bearer ", "");
  });
}

export function signIn(email, password) {
  let data = {
    user: { email, password },
  };
  let body = JSON.stringify(data);

  return apiRequest("POST", "/users/sign_in", { body }).then((response) => {
    let auth = response.headers.get("Authorization");
    return auth.replace("Bearer ", "");
  });
}
