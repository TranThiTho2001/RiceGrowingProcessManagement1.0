import http from "../common/http";
class EmployeeService {
     getAll() { return http.get("/employee"); }
     get(id) { return http.get(`/employee/${id}`); }
     create(data) { return http.post("/employee", data); }
     update(id, data) { return http.put(`/employee/${id}`, data); }
     delete(id) { return http.delete(`/employee/${id}`); }
     deleteAll() { return http.delete("/employee"); }
     findByName(name) { return http.get(`/employee?name=${name}`); }
}
export default new EmployeeService();
