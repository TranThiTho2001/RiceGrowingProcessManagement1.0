import http from "../common/http";

class ImageService {
     getAll() { return http.get("/images"); }
     getByID(id) { return http.get(`/images/${id}`); }
     create(data) { 
          console.log(data);
          return http.post("/images", data); 
     }
     findByName(name) { return http.get(`/images?name=${name}`); }
     update(id,data) { return http.put(`images/${id}`, data); }
}

export default new ImageService();