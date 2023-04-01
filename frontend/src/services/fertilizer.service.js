import http from "../common/http";
import store from "../store";

class FertilizerService {
     constructor() {
          http.interceptors.request.use(config => {
               const user = store.getters.loggedInEmployee;
               if (user && user.accessToken) {
                    config.headers.authorization = `Bearer ${user.accessToken}`;
               }
               return config;
          });
     }

     getAll() { return http.get("/fertilizer"); }
     get(id) { return http.get(`/fertilizer/${id}`); }
     create(data) { return http.post("/fertilizer", data); }
     update(id, data) { return http.put(`/fertilizer/${id}`, data); }
     delete(id) { return http.delete(`/fertilizer/${id}`); }
     findByName(name) { return http.get(`/fertilizer?name=${name}`); }
}

export default new FertilizerService();