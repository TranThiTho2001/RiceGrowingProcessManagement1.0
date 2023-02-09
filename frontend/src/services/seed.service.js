import http from "../common/http";
class SeedService {
     getAll() { return http.get("/seed"); }
     get(id) { return http.get(`/seed/${id}`); }
     create(data) { return http.post("/seed", data); }
     update(id, data) { return http.put(`/seed/${id}`, data); }
     delete(id) { return http.delete(`/seed/${id}`); }
     findByName(name) { return http.get(`/seed?name=${name}`); }
}
export default new SeedService();