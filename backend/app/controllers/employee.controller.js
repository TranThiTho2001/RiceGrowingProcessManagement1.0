const Employee = require("../models/employee.model");

// Show form create Todo
exports.create = (req, res) => {
    res.locals.status = req.query.status;
    res.render('employee/create');
}
// Create and Save a new Todo
exports.store = (req, res) => {
    // Validate request
    if (!req.body) {
        res.redirect('/employee/create?status=error')
    }

    // Create a Todo
    const employee = new Employee({
        name: req.body.name,
        sex: req.body.sex,
        major: req.body.major,
        role: req.body.roleId
    });
    // Save Todo in the database
    Employee.create(employee, (err, data) => {
        if (err)
            res.redirect('/employee/create?status=error')
        else res.redirect('/employee/create?status=success')
    });
};
// Retrieve all Todo from the database (with condition).
exports.findAll = (req, res) => {
    console.log("1")

    const name = req.query.name;

    Employee.getAll(name, (err, data) => {
        if (err)
            res.redirect('/500')
        else res.send(data);

    });

};

exports.find = (req, res) => {
    const id = req.params.id;
    Employee.findById(id, (err, data) => {
        if (err)
            res.redirect('/500')
        else res.send(data);
    })
};

// Find a single Todo with a id 
exports.edit = (req, res) => {
    res.locals.status = req.query.status;

    Employee.findById(req.params.id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.redirect('/404');
            } else {
                res.redirect('/500');
            }
        } else res.render('employee/edit', { employee: data });
    });
};
// Update a Todo identified by the id in the request
exports.update = (req, res) => {
    // Validate Request
    if (!req.body) {
        res.redirect('/employee/edit/' + req.params.id + '?status=error')
    }
    Employee.updateById(
        req.params.id,
        new Employee(req.body),
        (err, data) => {
            if (err) {
                if (err.kind === "not_found") {
                    res.redirect('/404');
                } else {
                    res.redirect('/500');
                }
            } else res.redirect('/employee/edit/' + req.params.id + '?status=success');
        }
    );
};
// Delete a Todo with the specified id in the request
exports.delete = (req, res) => {
    Employee.remove(req.params.id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.redirect('/404');
            } else {
                res.redirect('/500');
            }
        } else res.redirect('/employee?deleted=true')
    });
};
// Delete all Todo from the database.
exports.deleteAll = (req, res) => {
    Employee.removeAll((err, data) => {
        if (err)
            res.redirect('/500');
        else res.redirect('/employee?deleted=true')
    });
};

// // find all published Todo
// exports.findAllPublished = (req, res) => {
//     Todo.getAllPublished((err, data) => {
//         if (err)
//             res.redirect('/500')
//         else res.render('todo/index', { todo: data})
//     });
// };