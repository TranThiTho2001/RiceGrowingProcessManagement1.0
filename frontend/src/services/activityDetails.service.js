import http from "../common/http";
class ActivityDetailsService {
     getAll() { return http.get("/activityDetails"); }
     get(RiceCropInformation_id,OtherActivities_id) { return http.get(`/activityDetails/${RiceCropInformation_id}/${OtherActivities_id}`); }
     create(data) { return http.post("/activityDetails", data); }
     update(RiceCropInformation_id, OtherActivities_id, ActivityDetails_times, data) { return http.put(`/activityDetails/${RiceCropInformation_id}/${OtherActivities_id}/${ActivityDetails_times}`, data); }
     delete(RiceCropInformation_id, OtherActivities_id, ActivityDetails_times) { return http.delete(`/activityDetails/${RiceCropInformation_id}/${OtherActivities_id}/${ActivityDetails_times}`); }
     findByName(name) { return http.get(`/activityDetails?name=${name}`); }
     getByName(name,RiceCropInformation_id) { return http.get(`/activityDetails/findbyname/${RiceCropInformation_id}?name=${name}`); }
     findById(OtherActivities_id) { console.log(OtherActivities_id)
          return http.get(`/activityDetails/findbyId/${OtherActivities_id}`); }
}
export default new ActivityDetailsService();