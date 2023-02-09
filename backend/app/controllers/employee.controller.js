const Employee = require("../models/employee.model");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const config = require("../config");

// Create and Save a new Employee
exports.store = async (req, res) => {

    // Create a Employee
    const employee = new Employee({
        name: req.body.name,
        sex: req.body.sex,
        major: req.body.major,
        roleId: req.body.roleId,
        id: req.body.id,
        identityCardNumber: req.body.identityCardNumber,
        phoneNumber: req.body.phoneNumber,
        address: req.body.address,
        password: bcrypt.hashSync(req.body.password, 8),
    });
    // Save Employeein the database
    Employee.create(employee, (err, data) => {
        if (err)
            res.send("Đã xảy ra lỗi!!!");
        else res.send(data);
    });
};
// Retrieve all Employee from the database (with condition).
exports.findAll = async (req, res) => {
    const name = req.query.name;
    Employee.getAll(name, (err, data) => {
        if (err)
            res.send("Đã xảy ra lỗi trong quá trình tìm kiếm")
        else res.send(data);

    });

};

exports.find = async (req, res) => {
    const id = req.params.id;
    Employee.findById(id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send("Không tìm thấy nhân viên")
            } else {
                res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
            }
        } else res.send(data)
    })
};

// Update a Employee identified by the id in the request
exports.update = async (req, res) => {
    Employee.updateById(
        req.params.id,
        req.body,
        (err, data) => {
            if (err) {
                if (err.kind === "not_found") {
                    res.send("Không tìm thấy nhân viên")
                } else {
                    res.send("Khong the cap nhat thong tin nhan vien")
                }
            } else res.send(data)
        }
    );
};

// Delete a Employee with the specified id in the request
exports.delete = async (req, res) => {
    Employee.remove(req.params.id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send(`Không tìm thấy nhân viên có mã ${req.params.id}`)
            } else {
                res.redirect("Lỗi trong quá trình xóa nhân viên!!");
            }
        } else res.send(data);
    });
};

// Delete all Employee from the database.
exports.deleteAll = async (req, res) => {
    Employee.removeAll((err, data) => {
        if (err)
            res.redirect('/500');
        else res.redirect('/employee?deleted=true')
    });
};

exports.signin = async (req, res, next) => {
    console.log(req.body.id);
    const id = req.body.id;
    Employee.findById(id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send("Không tìm thấy nhân viên")
            } else {
                res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
            }
        } else {
            const passwordIsValid = bcrypt.compareSync(
                req.body.password,
                data.Employee_password,
            );
            console.log(passwordIsValid)
            if (passwordIsValid === false) {
                res.send("Mat khau sai");
            }
            else {
                const token = jwt.sign({ Employee_id: data.Employee_id }, config.jwt.secret, {
                    expiresIn: 86400, // 24 hours
                });
                res.status(200).send({
                    Employee_id: data.Employee_id,
                    Employee_name: data.Employee_name,
                    Employee_sex: data.Employee_sex,
                    Employee_major: data.Employee_major,
                    Employee_phoneNumber: data.Employee_phoneNumber,
                    Employee_address: data.Employee_address,
                    Employee_identityCardNumber: data.Employee_identityCardNumber,
                    Role_id: data.Role_id,
                    accessToken: token,
                });
            }
        }
    })
};

exports.changePassword = (req, res) => {
    const id = req.body.id;
    Employee.findById(id, (err, data1) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send("Không tìm thấy nhân viên")
            } else {
                res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
            }
        } else {
            // const passwordIsValid = bcrypt.compareSync(
            //     req.body.password,
            //     data1.Employee_password,
            // );
            // console.log(passwordIsValid)
            // if (!passwordIsValid) {
            //     return res.send("")
            // }
            newPassword = bcrypt.hashSync(req.body.password, 8)
            Employee.changePassword(req.params.id, newPassword, (err, data) => {
                if (err) {
                    if (err.kind === "not_found") {
                        res.send(`Không tìm thấy nhân viên có mã ${req.params.id}`)
                    } else {
                        res.redirect("Lỗi trong quá trình!!");
                    }
                } else res.send(data);
            });
        }
    }
    )
};
