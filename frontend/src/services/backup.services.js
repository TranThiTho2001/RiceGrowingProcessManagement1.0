import http from "../common/http";
import store from "../store";

class BackupService {
     constructor() {
          http.interceptors.request.use(config => {
               const user = store.getters.loggedInEmployee;
               if (user && user.accessToken) {
                    config.headers.authorization = `Bearer ${user.accessToken}`;
               }
               return config;
          });
     }

     getAll() { return http.get("/backup"); }
     get(id) { return http.get(`/backup/${id}`); }
     create(data) { return http.post("/backup", data); }
     delete(id, filename) { return http.delete(`/backup/${id}/${filename}`); }
     findByName(name) { return http.get(`/backup?name=${name}`); }
}

export default new BackupService();
