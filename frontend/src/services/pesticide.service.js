import http from "../common/http";
import store from "../store";

class PesticideService {
     constructor() {
          http.interceptors.request.use(config => {
               const user = store.getters.loggedInEmployee;
               if (user && user.accessToken) {
                    config.headers.authorization = `Bearer ${user.accessToken}`;
               }
               return config;
          });
     }

     getAll() { return http.get("/pesticide"); }
     
     get(id) { return http.get(`/pesticide/${id}`); }
    
     create(data) { return http.post("/pesticide", data); }
    
     update(id, data) { return http.put(`/pesticide/${id}`, data); }
     
     delete(id) { return http.delete(`/pesticide/${id}`); }
     
     findByName(name) { return http.get(`/pesticide?name=${name}`); }
}

export default new PesticideService();