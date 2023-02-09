import http from "../common/http";
import { handle } from "../common/promise";

const state = {
   employee: {
        Employee_id: String,
        Employee_name: String,
        Employee_sex: String,
        Employee_major: String,
        Employee_phoneNumber: String,
        Employee_address: String,
        Employee_identityCardNumber: String,
        Role_id: String,
        Employee_password: String
    },

    status: {
        loggedIn: Boolean
    },
};
const mutations = {
    initEmployeeState(state) {
        state.employee = JSON.parse(localStorage.getItem("employee"));
        state.status.loggedIn = !!state.employee;
    },

    login(state, employee) {
        state.status.loggedIn = true;
        state.employee = employee;
        localStorage.setItem("employee", JSON.stringify(employee));
    },

    logout(state) {
        state.status.loggedIn = false;
        state.employee = null;
        localStorage.removeItem("employee");
    },

    clearLoginStatus(state) {
        state.status.loggedIn = false;
    }
};
const actions = {
    async login({ commit }, employee) {
        let [error, response] = await handle(
            http.post("/employee/signin", {
                id: employee.Employee_id,
                password: employee.Employee_password,
            })
        );
        if (error || !response.data.accessToken) {
            commit("logout");
            if (!error) {
                error = new Error("Whoops, no access token found!");
            }
            throw error;
        }
        commit("login", response.data);
        return response.data;
    },
};
const getters = {
    employeeLoggedIn(state) {
        return state.status.loggedIn;
    },
    loggedInEmployee(state) {
        return state.employee;
    },
};
export const user = {
    state,
    mutations,
    actions,
    getters
};
