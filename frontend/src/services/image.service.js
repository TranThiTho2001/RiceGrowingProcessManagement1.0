import http from "../common/http";
import store from "../store";

class ImageService {
     constructor() {
          http.interceptors.request.use(config => {
               const user = store.getters.loggedInEmployee;
               if (user && user.accessToken) {
                    config.headers.authorization = `Bearer ${user.accessToken}`;
               }
               return config;
          });
     }

     getByID(id) { return http.get(`/image/${id}`); }
     create(data) {
          return http.post("/image", data);
     }
}

export default new ImageService();