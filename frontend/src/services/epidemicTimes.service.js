import http from "../common/http";
class EpidemicTimesService {
     getAll() { return http.get("/epidemicTimes"); }
     get(RiceCropInformation_id) { return http.get(`/epidemicTimes/${RiceCropInformation_id}`); }
     create(data) { return http.post("/epidemicTimes", data); }
     update(RiceCropInformation_id, Epidemic_id, EpidemicTimes_times, data) { return http.put(`/epidemicTimes/${RiceCropInformation_id}/${Epidemic_id}/${EpidemicTimes_times}`, data); }
     delete(RiceCropInformation_id, Epidemic_id, EpidemicTimes_times) { return http.delete(`/epidemicTimes/${RiceCropInformation_id}/${Epidemic_id}/${EpidemicTimes_times}`); }
     findByName(name) { return http.get(`/epidemicTimes?name=${name}`); }
}
export default new EpidemicTimesService();