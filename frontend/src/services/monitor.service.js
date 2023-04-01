import http from "../common/http";
import store from "../store";

class MonitorService {
     constructor() {
          http.interceptors.request.use(config => {
               const user = store.getters.loggedInEmployee;
               if (user && user.accessToken) {
                    config.headers.authorization = `Bearer ${user.accessToken}`;
               }
               return config;
          });
     }

     getAll() { return http.get("/monitor"); }
     get(id) { return http.get(`/monitor/${id}`); }
     create(data) { return http.post("/monitor", data); }
     update(id, data) { return http.put(`/monitor/${id}`, data); }
     delete(id, employeeid) { return http.delete(`/monitor/${id}/${employeeid}`); }
     findByName(name) { return http.get(`/monitor?name=${name}`); }
     getByName(name, RiceCropInformation_id) { return http.get(`/monitor/findbyname/${RiceCropInformation_id}?name=${name}`); }
}

export default new MonitorService();