// const API_URL = "http://api.giphy.com/v1/gifs/search";

// export function fetchGifs(text) {
//   let url = `${API_URL}?api_key=oeoPRSTlOA1jTrhVTQhH3pvbvnAvdGn1&q=${text}`;
//   return fetch(url)
//     .then((response) => {
//       if (response.status < 200 || response.status > 299) {
//         return Promise.reject(response);
//       }
//       return response;
//     })
//     .then((response) => response.json())
//     .then((response) => response.data)
//     .then((data) => {
//       return data.map((gif) => gif.images.original.url);
//     });
// }
