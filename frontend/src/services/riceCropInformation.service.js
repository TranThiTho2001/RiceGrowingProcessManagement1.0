import http from "../common/http";
import store from "../store";

class RiceCropInformationService {
     constructor() {
          http.interceptors.request.use(config => {
               const user = store.getters.loggedInEmployee;
               if (user && user.accessToken) {
                    config.headers.authorization = `Bearer ${user.accessToken}`;
               }
               return config;
          });
     }

     getAll() { return http.get("/riceCropInformation"); }
     get(id) { return http.get(`/riceCropInformation/${id}`); }
     findByEmployeeAndRiceCropName(name, id) { return http.get(`/riceCropInformation/findbynameandemployee/${name}/${id}`); }
     create(data) { return http.post("/riceCropInformation", data); }
     update(id, data) { return http.put(`/riceCropInformation/${id}`, data); }
     delete(id) { return http.delete(`/riceCropInformation/${id}`); }
     findByName(name) { return http.get(`/riceCropInformation?name=${name}`); }
     findRiceCropHarvested() {return http.get(`/riceCropInformation/findRiceCropHarvested/find`); }
     
}

export default new RiceCropInformationService();