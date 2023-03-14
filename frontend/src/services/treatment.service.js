import http from "../common/http";
class TreatmentService {
     getAll() { return http.get("/treatment"); }
     findByEpidemicId(Epidemic_id) { return http.get(`/treatment/findbyEpidemicId/${Epidemic_id}`); }
     findByEpidemicName(name) { return http.get(`/treatment/findbyEpidemicName?name=${name}`); }
     findByPesticideId(Pesticide_id) { return http.get(`/treatment/findbyPesticideId/${Pesticide_id}`); }
     findByPesticideName(name) { return http.get(`/treatment/findbyPesticideName?name=${name}`); }
     create(data) { return http.post("/treatment", data); }
     update(Pesticide_id,Epidemic_id , data) { return http.put(`/treatment/${Pesticide_id}/${Epidemic_id}`, data); }
     delete(Pesticide_id, Epidemic_id) { return http.delete(`/treatment/${Pesticide_id}/${Epidemic_id}`); }
}
export default new TreatmentService();