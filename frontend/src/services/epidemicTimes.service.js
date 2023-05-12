import http from "../common/http";
import store from "../store";

class EpidemicTimesService {
     constructor() {
          http.interceptors.request.use(config => {
               const user = store.getters.loggedInEmployee;
               if (user && user.accessToken) {
                    config.headers.authorization = `Bearer ${user.accessToken}`;
               }
               return config;
          });
     }

     getAll() { return http.get("/epidemicTimes"); }
     
     get(RiceCropInformation_id) { return http.get(`/epidemicTimes/${RiceCropInformation_id}`); }
     
     create(data) { return http.post("/epidemicTimes", data); }
     
     update(RiceCropInformation_id, Epidemic_id, EpidemicTimes_times, data) { return http.put(`/epidemicTimes/${RiceCropInformation_id}/${Epidemic_id}/${EpidemicTimes_times}`, data); }
     
     delete(RiceCropInformation_id, Epidemic_id, EpidemicTimes_times) { return http.delete(`/epidemicTimes/${RiceCropInformation_id}/${Epidemic_id}/${EpidemicTimes_times}`); }
     
     findByName(name) { return http.get(`/epidemicTimes?name=${name}`); }
     
     getByName(name, RiceCropInformation_id) { return http.get(`/epidemicTimes/findbyname/${RiceCropInformation_id}?name=${name}`); }
}

export default new EpidemicTimesService();