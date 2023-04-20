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
        alias: "/RiceCropDetail/:id",
        name: "RiceCropDetail",
        component: () => import("../views/catalogManagementView/riceCropDetail.vue"),
    },

    {
        path: "/Activity",
        alias: "/Activity",
        name: "Activity",
        component: () => import("../views/catalogManagementView/activitiesManagement.vue"),

    },
    
    {
        path: "/FertilizerDetail/:id",
        alias: "/FertilizerDetail/:id",
        name: "FertilizerDetail",
        component: () => import("../views/catalogManagementView/fertilizerDetail.vue"),
    },

    {
        path: "/FertilizerTimes/:id",
        alias: "/FertilizerTimes/:id",
        name: "FertilizerTimes",
        component: () => import("../views/catalogManagementView/riceCropDetail/fertilizerTimes.vue"),
    },

    {
        path: "/SprayingTimes/:id",
        alias: "/SprayingTimes/:id",
        name: "SprayingTimes",
        component: () => import("../views/catalogManagementView/riceCropDetail/sprayingTimes.vue"),
    },

    {
        path: "/EpidemicTimes/:id",
        alias: "/EpidemicTimes/:id",
        name: "EpidemicTimes",
        component: () => import("../views/catalogManagementView/riceCropDetail/epidemicTimes.vue"),
    },
    {
        path: "/ImagesRiceCrop/:id",
        alias: "/ImagesRiceCrop/:id",
        name: "ImagesRiceCrop",
        component: () => import("../views/catalogManagementView/riceCropDetail/imagesRiceCrop.vue"),
    },
    {
        path: "/SupervisionRights/:id",
        alias: "/SupervisionRights/:id",
        name: "SupervisionRights",
        component: () => import("../views/catalogManagementView/riceCropDetail/monitor.vue"),
    },

    {
        path: "/Activities/:id",
        alias: "/Activities/:id",
        name: "Activities",
        component: () => import("../views/catalogManagementView/riceCropDetail/activityTimes.vue"),
    },
    
    {
        path: "/RiceYieldPredictionDetail",
        alias: "/RiceYieldPredictionDetail",
        name: "RiceYieldPredictionDetail",
        component: () => import("../views/catalogManagementView/riceYieldPredictionDetail.vue"),
    },

    {
        path: "/RiceCropHarvested",
        alias: "/RiceCropHarvested",
        name: "RiceCropHarvested",
        component: () => import("../views/catalogManagementView/finalPrediction.vue"),
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