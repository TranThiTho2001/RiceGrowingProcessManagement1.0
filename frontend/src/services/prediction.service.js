import http from "../common/http";
import store from "../store";

class PredictionService {
     constructor() {
          http.interceptors.request.use(config => {
               const user = store.getters.loggedInEmployee;
               if (user && user.accessToken) {
                    config.headers.authorization = `Bearer ${user.accessToken}`;
               }
               return config;
          });
     }

     getAll() { return http.get("/prediction"); }
     get(id) { return http.get(`/prediction/findbyid/${id}`); }
     findByRiceCropInformation(RiceCropInformation_id) { return http.get(`/prediction/findbyRiceCropInformation/${RiceCropInformation_id}`); }
     create(RiceCropInformation_id, data) { return http.post(`/prediction//predictionwithLinearRegreesion/${RiceCropInformation_id}`, data); }
     // update(id, data) { return http.put(`/riceCropInformation/${id}`, data); }
     // delete(id) { return http.delete(`/riceCropInformation/${id}`); }
     findByName(name) { return http.get(`/prediction?name=${name}`); }
}

export default new PredictionService();