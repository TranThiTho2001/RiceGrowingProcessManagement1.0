import http from "../common/http";
class CropService {
     getAll() { return http.get("/crop"); }
     get(id) { return http.get(`/crop/${id}`); }
     create(data) { return http.post("/crop", data); }
     update(id, data) { return http.put(`/crop/${id}`, data); }
     delete(id) { return http.delete(`/crop/${id}`); }
     findByName(name) { return http.get(`/crop?name=${name}`); }
}
export default new CropService();
