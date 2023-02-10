import http from "../common/http";
class OtherActivitiesService {
     getAll() { return http.get("/otherActivities"); }
     get(id) { return http.get(`/otherActivities/${id}`); }
     create(data) { return http.post("/otherActivities", data); }
     update(id, data) { return http.put(`/otherActivities/${id}`, data); }
     delete(id) { return http.delete(`/otherActivities/${id}`); }
     findByName(name) { return http.get(`/otherActivities?name=${name}`); }
}
export default new OtherActivitiesService();