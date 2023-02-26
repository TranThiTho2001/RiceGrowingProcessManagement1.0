import http from "../common/http";

class ImageService {
     getAll() { return http.get("/image"); }
     getByID(id) { return http.get(`/image/${id}`); }
     create(data) { 
          console.log(data);
          return http.post("/image", data); 
     }
     findByName(name) { return http.get(`/image?name=${name}`); }
}

export default new ImageService();