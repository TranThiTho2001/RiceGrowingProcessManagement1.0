import http from "../common/http";
import store from "../store";

class FertilizerTimesService {
     constructor() {
          http.interceptors.request.use(config => {
               const user = store.getters.loggedInEmployee;
               if (user && user.accessToken) {
                    config.headers.authorization = `Bearer ${user.accessToken}`;
               }
               return config;
          });
     }

     getAll() { return http.get("/fertilizerTimes"); }
     get(RiceCropInformation_id) { return http.get(`/fertilizerTimes/${RiceCropInformation_id}`); }
     create(data) { return http.post("/fertilizerTimes", data); }
     update(RiceCropInformation_id, Fertilizer_id, FertilizerTimes_times, data) { return http.put(`/fertilizerTimes/${RiceCropInformation_id}/${Fertilizer_id}/${FertilizerTimes_times}`, data); }
     delete(RiceCropInformation_id, Fertilizer_id, FertilizerTimes_times) { return http.delete(`/fertilizerTimes/${RiceCropInformation_id}/${Fertilizer_id}/${FertilizerTimes_times}`); }
     findByName(name) { return http.get(`/fertilizerTimes?name=${name}`); }
     getByName(name, RiceCropInformation_id) { return http.get(`/fertilizerTimes/findbyname/${RiceCropInformation_id}?name=${name}`); }
}

export default new FertilizerTimesService();