import http from "../common/http";
class SprayingTimesService {
     getAll() { return http.get("/sprayingTimes"); }
     get(RiceCropInformation_id) { return http.get(`/sprayingTimes/${RiceCropInformation_id}`); }
     create(data) { return http.post("/sprayingTimes", data); }
     update(RiceCropInformation_id, Pesticide_id, SprayingTimes_times, data) { return http.put(`/sprayingTimes/${RiceCropInformation_id}/${Pesticide_id}/${SprayingTimes_times}`, data); }
     delete(RiceCropInformation_id, Pesticide_id, SprayingTimes_times) { return http.delete(`/sprayingTimes/${RiceCropInformation_id}/${Pesticide_id}/${SprayingTimes_times}`); }
     findByName(name) { return http.get(`/sprayingTimes?name=${name}`); }
}
export default new SprayingTimesService();