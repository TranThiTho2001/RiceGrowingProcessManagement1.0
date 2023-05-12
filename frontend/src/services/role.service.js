import http from "../common/http";
import store from "../store";

class RoleService {
     constructor() {
          http.interceptors.request.use(config => {
               const user = store.getters.loggedInEmployee;
               if (user && user.accessToken) {
                    config.headers.authorization = `Bearer ${user.accessToken}`;
               }
               return config;
          });
     }

     getAll() { return http.get("/role"); }
    
     get(id) { return http.get(`/role/${id}`); }
     
     create(data) { return http.post("/role", data); }
     
     update(id, data) { return http.put(`/role/${id}`, data); }
     
     delete(id) { return http.delete(`/role/${id}`); }
     
     findByName(name) { return http.get(`/role?name=${name}`); }
}

export default new RoleService();
