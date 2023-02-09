import http from "../common/http";
class ArableLandService {
     getAll() { return http.get("/arableLand"); }
     get(id) { return http.get(`/arableLand/${id}`); }
     create(data) { return http.post("/arableLand", data); }
     update(id, data) { return http.put(`/arableLand/${id}`, data); }
     delete(id) { return http.delete(`/arableLand/${id}`); }
     findByName(name) { return http.get(`/arableLand?name=${name}`); }
}
export default new ArableLandService();