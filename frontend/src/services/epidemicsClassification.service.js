import http from "../common/http";
class EpidemicsClassificationService {
     getAll() { return http.get("/epidemicsClassification"); }
     get(id) { return http.get(`/epidemicsClassification/${id}`); }
     create(data) { return http.post("/epidemicsClassification", data); }
     findByName(name) { return http.get(`/epidemicsClassification?name=${name}`); }
}
export default new EpidemicsClassificationService();