import { createWebHistory, createRouter } from "vue-router";
import store from "../store";
const routes = [
    {
        path: "/",
        alias: "/loginform",
        name: "LoginForm", meta: { title: 'Skills - MyApp' },
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

    {
        path: "/Predition",
        alias: "/Predition",
        name: "Predition",
        component: () => import("../views/catalogManagementView/riceYieldPrediction.vue"),
    },

    {
        path: "/Statistical",
        alias: "/Statistical",
        name: "Statistical",
        component: () => import("../views/catalogManagementView/statisticalManagement.vue"),

    },

    {
        path: "/Statistical/StatisticsByRiceCrop",
        alias: "/StatisticsByRiceCrop",
        name: "StatisticsByRiceCrop",
        component: () => import("../views/catalogManagementView/statisticsByRiceCrop.vue"),

    },

    {
        path: "/Monitor",
        alias: "/Monitor",
        name: "Monitor",
        component: () => import("../views/catalogManagementView/riceCropManagement.vue"),

    },

    {
        path: "/MainForm",
        alias: "/mainForm",
        name: "OtherActivities",
        component: () => import("../views/MainForm.vue"),
    },

    {
        path: "/Seed",
        alias: "/Seed",
        name: "SeedManagement",
        component: () => import("../views/catalogManagementView/seedManagement.vue"),
    },


    {
        path: "/Fertilizer",
        alias: "/Fertilizer",
        name: "Fertilizer",
        component: () => import("../views/catalogManagementView/fertilizerManagement.vue"),
    },

    {
        path: "/Epidemic",
        alias: "/Epidemic",
        name: "Epidemic",
        component: () => import("../views/catalogManagementView/epidemicManagement.vue"),
    },

    {
        path: "/ArableLand",
        alias: "/ArableLand",
        name: "ArableLand",
        component: () => import("../views/catalogManagementView/arablelandManagement.vue"),
    },

    {
        path: "/Pesticide",
        alias: "/Pesticide",
        name: "Pesticide",
        component: () => import("../views/catalogManagementView/pesticideManagement.vue"),
    },

    {
        path: "/RiceCropDetail/:id",
        alias: "/RiceCropDetail",
        name: "RiceCropDetail",
        component: () => import("../views/catalogManagementView/riceCropDetail.vue"),
    },

    {
        path: "/Activity",
        alias: "/Activity",
        name: "Activity",
        component: () => import("../views/catalogManagementView/activitiesManagement.vue"),

    },
];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

router.beforeEach((to, from, next) => {
    const publicPages = ["/"];
    const authRequired = !publicPages.includes(to.path);
    const loggedIn = store.getters.employeeLoggedIn;
    if (authRequired && !loggedIn) {
        next("/");
    } else {
        next();
    }
});

export default router;