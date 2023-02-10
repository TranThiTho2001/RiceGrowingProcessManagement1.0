import http from "../common/http";
class ActivityDetailsService {
     getAll() { return http.get("/activityDetails"); }
     get(RiceCropInformation_id) { return http.get(`/activityDetails/${RiceCropInformation_id}`); }
     create(data) { return http.post("/activityDetails", data); }
     update(RiceCropInformation_id, OtherActivities_id, times, data) { return http.put(`/activityDetails/${RiceCropInformation_id}/${OtherActivities_id}/${times}`, data); }
     delete(RiceCropInformation_id, OtherActivities_id, times) { return http.delete(`/activityDetails/${RiceCropInformation_id}/${OtherActivities_id}/${times}`); }
     findByName(name) { return http.get(`/activityDetails?name=${name}`); }
}
export default new ActivityDetailsService();