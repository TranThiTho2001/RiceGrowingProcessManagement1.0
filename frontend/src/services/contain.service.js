import http from "../common/http";
import store from "../store";

class ContainService {
     constructor() {
          http.interceptors.request.use(config => {
               const user = store.getters.loggedInEmployee;
               if (user && user.accessToken) {
                    config.headers.authorization = `Bearer ${user.accessToken}`;
               }
               return config;
          });
     }

     getAll() { return http.get("/contain"); }
     getByFertilizerId(Fertilizer_id) { return http.get(`/contain/getbyFertilizerId/${Fertilizer_id}`); }
     getByNutrientId(Nutrient_id) { return http.get(`/contain/getbyNutrientId/${Nutrient_id}`); }
     getByFertilizerAndNutrient(Fertilizer_id, Nutrient_id) { return http.get(`/contain/getbyFertilizerAndNutrient/${Fertilizer_id}/${Nutrient_id}`); }
     create(data) { return http.post("/contain", data); }
     update(Fertilizer_id, Nutrient_id, data) { return http.put(`/contain/${Fertilizer_id}/${Nutrient_id}`, data); }
     delete(Fertilizer_id, Nutrient_id) { return http.delete(`/contain/${Fertilizer_id}/${Nutrient_id}`); }
     findByName(name) { return http.get(`/contain?name=${name}`); }
}

export default new ContainService();
