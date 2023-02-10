import http from "../common/http";
class DevelopmentStageService {
     getAll() { return http.get("/developmentStage"); }
     get(id) { return http.get(`/developmentStage/${id}`); }
     create(data) { return http.post("/developmentStage", data); }
     update(id, data) { return http.put(`/developmentStage/${id}`, data); }
     delete(id) { return http.delete(`/developmentStage/${id}`); }
     findByName(name) { return http.get(`/developmentStage?name=${name}`); }
}
export default new DevelopmentStageService();