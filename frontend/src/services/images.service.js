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

     getAll() { return http.get("/images"); }
    
     getByID(id) { return http.get(`/images/${id}`); }
     
     create(data) { return http.post("/images", data); }
     
     delete(id) { return http.delete(`/images/${id}`); }
    
     findByName(name) { return http.get(`/images?name=${name}`); }
     
     update(id, data) { return http.put(`images/${id}`, data); }
}

export default new ImageService();