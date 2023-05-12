import http from "../common/http";
import store from "../store";

class SeedService {
     constructor() {
          http.interceptors.request.use(config => {
               const user = store.getters.loggedInEmployee;
               if (user && user.accessToken) {
                    config.headers.authorization = `Bearer ${user.accessToken}`;
               }
               return config;
          });
     }
     
     getAll() { return http.get("/seed"); }
     
     get(id) { return http.get(`/seed/${id}`); }
     
     create(data) { return http.post("/seed", data); }
    
     update(id, data) { return http.put(`/seed/${id}`, data); }
     
     delete(id) { return http.delete(`/seed/${id}`); }
     
     findByName(name) { return http.get(`/seed?name=${name}`); }
}

export default new SeedService();