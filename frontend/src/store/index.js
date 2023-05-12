import { createStore } from "vuex";
import { user } from "./employee.module";

const store = createStore({
    modules: {
        employee: user,
    },
});

export default store;