import { createWebHistory, createRouter } from "vue-router";
const routes = [
    {
        path: "/",
        alias: "/loginform",
        name: "LoginForm",meta: { title: 'Skills - MyApp' },
        component: () => import("../views/LoginForm.vue"),
        
    },

    {
        path: "/SystemManagement",
        alias: "/SystemManagement",
        name: "SystemManagement",
        component: () => import("../views/administratorsView/SystemManagement.vue"),
        
    },

    {
        path: "/EmployeeManager",
        alias: "/EmployeeManager",
        name: "EmployeeManager",
        component: () => import("../views/administratorsView/EmployeeManager.vue"),
        
    },

    {
        path: "/CreateNewEmployee",
        alias: "/createNewEmployee",
        name: "createNewEmployee",
        component: () => import("../views/administratorsView/createNewEmployee.vue"),
        
    },

    {
        path: "/UpdateEmployee",
        alias: "/UpdateEmployee",
        name: "UpdateEmployee",
        component: () => import("../views/administratorsView/updateEmployee.vue"),
        
    },

];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

export default router;