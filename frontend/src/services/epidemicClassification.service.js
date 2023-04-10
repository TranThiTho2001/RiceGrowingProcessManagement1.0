import http from "../common/http";
import store from "../store";

class EpidemicClassificationService {
     constructor() {
          http.interceptors.request.use(config => {
               const user = store.getters.loggedInEmployee;
               if (user && user.accessToken) {
                    config.headers.authorization = `Bearer ${user.accessToken}`;
               }
               return config;
          });
     }

     getAll() { return http.get("/epidemicClassification"); }
     get(id) { return http.get(`/epidemicClassification/${id}`); }
     create(data) { return http.post("/epidemicClassification", data); }
     findByName(name) { return http.get(`/epidemicClassification?name=${name}`); }
}

export default new EpidemicClassificationService();