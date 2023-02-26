import http from "../common/http";
class RiceCropInformationService {
     getAll() { return http.get("/riceCropInformation"); }
     get(id) { return http.get(`/riceCropInformation/${id}`); }
     findByEmployeeAndRiceCropName(name,id) { return http.get(`/riceCropInformation/${name}/${id}`); }
     create(data) { return http.post("/riceCropInformation", data); }
     update(id, data) { return http.put(`/riceCropInformation/${id}`, data); }
     delete(id) { return http.delete(`/riceCropInformation/${id}`); }
     findByName(name) { return http.get(`/riceCropInformation?name=${name}`); }
}
export default new RiceCropInformationService();