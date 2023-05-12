import http from "../common/http";
import store from "../store";

class SoilService {
     constructor() {
          http.interceptors.request.use(config => {
               const user = store.getters.loggedInEmployee;
               if (user && user.accessToken) {
                    config.headers.authorization = `Bearer ${user.accessToken}`;
               }
               return config;
          });
     }

     getAll() { return http.get("/soil"); }
     
     get(id) { return http.get(`/soil/${id}`); }
     
     create(data) { return http.post("/soil", data); }
     
     update(id, data) { return http.put(`/soil/${id}`, data); }
     
     delete(id) { return http.delete(`/soil/${id}`); }
     
     findByName(name) { return http.get(`/soil?name=${name}`); }
}

export default new SoilService();