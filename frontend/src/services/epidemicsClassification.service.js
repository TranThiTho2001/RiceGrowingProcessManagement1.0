import http from "../common/http";
import store from "../store";

class EpidemicsClassificationService {
     constructor() {
          http.interceptors.request.use(config => {
               const user = store.getters.loggedInEmployee;
               if (user && user.accessToken) {
                    config.headers.authorization = `Bearer ${user.accessToken}`;
               }
               return config;
          });
     }

     getAll() { return http.get("/epidemicsClassification"); }
     get(id) { return http.get(`/epidemicsClassification/${id}`); }
     create(data) { return http.post("/epidemicsClassification", data); }
     findByName(name) { return http.get(`/epidemicsClassification?name=${name}`); }
}

export default new EpidemicsClassificationService();