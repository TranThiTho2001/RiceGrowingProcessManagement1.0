import http from "../common/http";
class FertilizerTimesService {
     getAll() { return http.get("/fertilizerTimes"); }
     get(RiceCropInformation_id) { return http.get(`/fertilizerTimes/${RiceCropInformation_id}`); }
     create(data) { return http.post("/fertilizerTimes", data); }
     update(RiceCropInformation_id, Fertilizer_id, FertilizerTimes_times, data) { return http.put(`/fertilizerTimes/${RiceCropInformation_id}/${Fertilizer_id}/${FertilizerTimes_times}`, data); }
     delete(RiceCropInformation_id, Fertilizer_id, FertilizerTimes_times) { return http.delete(`/fertilizerTimes/${RiceCropInformation_id}/${Fertilizer_id}/${FertilizerTimes_times}`); }
     findByName(name) { return http.get(`/fertilizerTimes?name=${name}`); }
}
export default new FertilizerTimesService();