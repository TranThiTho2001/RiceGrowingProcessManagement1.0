const Employee = require("../models/employee.model");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const config = require("../config");
exports.store = async (req, res) => {


    // Create a Employee
    const employee = new Employee({
        name: req.body.Employee_name,
        sex: req.body.Employee_sex,
        major: req.body.Employee_major,
        roleId: req.body.Role_id,
        id: req.body.Employee_id,
        identityCardNumber: req.body.Employee_identityCardNumber,
        phoneNumber: req.body.Employee_phoneNumber,
        address: req.body.Employee_address,
        email: req.body.Employee_email,
        birthDate: req.body.Employee_birthDate,
        password: bcrypt.hashSync(req.body.Employee_password, 8),
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
    const id = req.body.Employee_id;
    Employee.findById(id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send("Không tìm thấy nhân viên")
            } else {
                res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
            }
        } else {
            const passwordIsValid = bcrypt.compareSync(
                req.body.Employee_password,
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
                console.log("Dang nhap thanh cong");
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
    const id = req.body.Employee_id;
    Employee.findById(id, (err, data1) => {
        if (err) {
            if (err.kind === "not_found") {
                res.send("Không tìm thấy nhân viên")
            } else {
                res.send("Lỗi trong quá trình tìm kiếm. Vui lòng thử lại sau!!!!")
            }
        } else {
            // const passwordIsValid = bcrypt.compareSync(
            //     req.body.Employee_password,
            //     data1.Employee_password,
            // );
            // console.log(passwordIsValid)
            // if (!passwordIsValid) {
            //     return res.send("")
            // }
            newPassword = bcrypt.hashSync(req.body.Employee_password, 8)
            Employee.changePassword(req.params.Employee_id, newPassword, (err, data) => {
                if (err) {
                    if (err.kind === "not_found") {
                        res.send(`Không tìm thấy nhân viên có mã ${req.params.Employee_password}`)
                    } else {
                        res.redirect("Lỗi trong quá trình!!");
                    }
                } else res.send(data);
            });
        }
    }
    )
};
