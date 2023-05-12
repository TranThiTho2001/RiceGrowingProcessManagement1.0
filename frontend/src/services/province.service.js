import http from "../common/http";
import store from "../store";

class ProvinceService {
     constructor() {
          http.interceptors.request.use(config => {
               const user = store.getters.loggedInEmployee;
               if (user && user.accessToken) {
                    config.headers.authorization = `Bearer ${user.accessToken}`;
               }
               return config;
          });
     }

     getAll() { return http.get("/province"); }
     
     get(id) { return http.get(`/province/${id}`); }
     
     create(data) { return http.post("/province", data); }
     
     update(id, data) { return http.put(`/province/${id}`, data); }
     
     delete(id) { return http.delete(`/province/${id}`); }
     
     findByName(name) { return http.get(`/province?name=${name}`); }
}

export default new ProvinceService();
