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

    {
        path: "/HomePage",
        alias: "/HomePage",
        name: "HomePage",
        component: () => import("../views/catalogManagementView/HomePage.vue"),
        
    },

    {
        path: "/Monitor",
        alias: "/Monitor",
        name: "Monitor",
        component: () => import("../views/catalogManagementView/riceCropManagement.vue"),
        
    },

    // {
    //     path: "/OtherActivities",
    //     alias: "/OtherActivities",
    //     name: "OtherActivities",
    //     component: () => import("../views/catalogManagementView/OtherActivitiesManagement.vue"),
    // },
    
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

];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

export default router;