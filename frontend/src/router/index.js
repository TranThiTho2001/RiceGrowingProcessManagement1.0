import { createWebHistory, createRouter } from "vue-router";
const routes = [
     {
          path: "/",
          alias: "/employee",
          name: "Employee",
          component: () => import("../views/Employee"),
     },
];
const router = createRouter({
     history: createWebHistory(),
     routes,
});
export default router;