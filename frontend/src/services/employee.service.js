import http from "../common/http";
import store from "../store";

class EmployeeService {
     constructor() {
          http.interceptors.request.use(config => {
               const user = store.getters.loggedInEmployee;
               if (user && user.accessToken) {
                    config.headers.authorization = `Bearer ${user.accessToken}`;
               }
               return config;
          });
     }

     getAll() { return http.get("/employee"); }
     get(id) { return http.get(`/employee/${id}`); }
     create(data) { return http.post("/employee", data); }
     update(id, data) { return http.put(`/employee/${id}`, data); }
     changePassword(id, data) { return http.put(`/employee/change/${id}`, data); }
     delete(id) { return http.delete(`/employee/${id}`); }
     findByName(name) { return http.get(`/employee?name=${name}`); }
}

export default new EmployeeService();
