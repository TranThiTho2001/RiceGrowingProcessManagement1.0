import http from "../common/http";
import store from "../store";

class NutrientService {
     constructor() {
          http.interceptors.request.use(config => {
               const user = store.getters.loggedInEmployee;
               if (user && user.accessToken) {
                    config.headers.authorization = `Bearer ${user.accessToken}`;
               }
               return config;
          });
     }

     getAll() { return http.get("/nutrient"); }
     get(id) { return http.get(`/nutrient/${id}`); }
     create(data) { return http.post("/nutrient", data); }
     update(id, data) { return http.put(`/nutrient/${id}`, data); }
     delete(id) { return http.delete(`/nutrient/${id}`); }
     findByName(name) { return http.get(`/nutrient?name=${name}`); }
}

export default new NutrientService();
