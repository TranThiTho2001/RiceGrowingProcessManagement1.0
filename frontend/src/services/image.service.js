import http from "../common/http";

class ImageService {
     getByID(id) { return http.get(`/image/${id}`); }
     create(data) { 
          return http.post("/image", data); 
     }
}

export default new ImageService();