import http from "../common/http";
class PredictionService {
     getAll() { return http.get("/prediction"); }
     get(id) { return http.get(`/prediction/findbyid/${id}`); }
     findByRiceCropInformation(RiceCropInformation_id) { return http.get(`/prediction/findbyRiceCropInformation/${RiceCropInformation_id}`); }
     create(RiceCropInformation_id) { return http.post(`/prediction//predictionwithLinearRegreesion/${RiceCropInformation_id}`); }
     // update(id, data) { return http.put(`/riceCropInformation/${id}`, data); }
     // delete(id) { return http.delete(`/riceCropInformation/${id}`); }
     findByName(name) { return http.get(`/prediction?name=${name}`); }
}
export default new PredictionService();