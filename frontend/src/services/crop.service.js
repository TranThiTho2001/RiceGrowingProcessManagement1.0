import http from "../common/http";
import store from "../store";

class CropService {
     constructor() {
          http.interceptors.request.use(config => {
               const user = store.getters.loggedInEmployee;
               if (user && user.accessToken) {
                    config.headers.authorization = `Bearer ${user.accessToken}`;
               }
               return config;
          });
     }

     getAll() { return http.get("/crop"); }
     
     get(id) { return http.get(`/crop/${id}`); }
    
     create(data) { return http.post("/crop", data); }
     
     update(id, data) { return http.put(`/crop/${id}`, data); }
    
     delete(id) { return http.delete(`/crop/${id}`); }
     
     findByName(name) { return http.get(`/crop?name=${name}`); }
}

export default new CropService();
