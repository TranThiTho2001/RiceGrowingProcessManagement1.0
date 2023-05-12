import http from "../common/http";
import store from "../store";

class DevelopmentStageService {
     constructor() {
          http.interceptors.request.use(config => {
               const user = store.getters.loggedInEmployee;
               if (user && user.accessToken) {
                    config.headers.authorization = `Bearer ${user.accessToken}`;
               }
               return config;
          });
     }

     getAll() { return http.get("/developmentStage"); }
    
     get(id) { return http.get(`/developmentStage/${id}`); }
     
     create(data) { return http.post("/developmentStage", data); }
     
     update(id, data) { return http.put(`/developmentStage/${id}`, data); }
     
     delete(id) { return http.delete(`/developmentStage/${id}`); }
     
     findByName(name) { return http.get(`/developmentStage?name=${name}`); }
}

export default new DevelopmentStageService();