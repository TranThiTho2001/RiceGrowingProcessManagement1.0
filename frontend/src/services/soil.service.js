import http from "../common/http";
class SoilService {
     getAll() { return http.get("/soil"); }
     get(id) { return http.get(`/soil/${id}`); }
     create(data) { return http.post("/soil", data); }
     update(id, data) { return http.put(`/soil/${id}`, data); }
     delete(id) { return http.delete(`/soil/${id}`); }
     findByName(name) { return http.get(`/soil?name=${name}`); }
}
export default new SoilService();