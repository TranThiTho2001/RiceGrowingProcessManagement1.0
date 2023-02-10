import http from "../common/http";
class FertilizerService {
     getAll() { return http.get("/fertilizer"); }
     get(id) { return http.get(`/fertilizer/${id}`); }
     create(data) { return http.post("/fertilizer", data); }
     update(id, data) { return http.put(`/fertilizer/${id}`, data); }
     delete(id) { return http.delete(`/fertilizer/${id}`); }
     findByName(name) { return http.get(`/fertilizer?name=${name}`); }
}
export default new FertilizerService();