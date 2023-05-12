import http from "../common/http";
import store from "../store";

class ArableLandService {
     constructor() {
          http.interceptors.request.use(config => {
               const user = store.getters.loggedInEmployee;
               if (user && user.accessToken) {
                    config.headers.authorization = `Bearer ${user.accessToken}`;
               }
               return config;
          });
     }

     getAll() { return http.get("/arableLand"); }
     
     get(id) { return http.get(`/arableLand/${id}`); }
     
     create(data) { return http.post("/arableLand", data); }
     
     update(id, data) { return http.put(`/arableLand/${id}`, data); }
     
     delete(id) { return http.delete(`/arableLand/${id}`); }
    
     findByName(name) { return http.get(`/arableLand?name=${name}`); }
}

export default new ArableLandService();