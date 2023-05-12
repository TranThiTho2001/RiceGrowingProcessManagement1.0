import http from "../common/http";
import store from "../store";

class EpidemicService {
     constructor() {
          http.interceptors.request.use(config => {
               const user = store.getters.loggedInEmployee;
               if (user && user.accessToken) {
                    config.headers.authorization = `Bearer ${user.accessToken}`;
               }
               return config;
          });
     }

     getAll() { return http.get("/epidemic"); }
    
     get(id) { return http.get(`/epidemic/${id}`); }
     
     create(data) { return http.post("/epidemic", data); }
     
     update(id, data) { return http.put(`/epidemic/${id}`, data); }
    
     delete(id) { return http.delete(`/epidemic/${id}`); }
     
     findByName(name) { return http.get(`/epidemic?name=${name}`); }
}

export default new EpidemicService();