import http from "../common/http";
class EpidemicService {
     getAll() { return http.get("/epidemic"); }
     get(id) { return http.get(`/epidemic/${id}`); }
     create(data) { return http.post("/epidemic", data); }
     update(id, data) { return http.put(`/epidemic/${id}`, data); }
     delete(id) { return http.delete(`/epidemic/${id}`); }
     findByName(name) { return http.get(`/epidemic?name=${name}`); }
}
export default new EpidemicService();