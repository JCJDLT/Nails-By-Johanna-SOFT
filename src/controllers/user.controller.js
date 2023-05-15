import { pool } from "../database.js";
import { getFechaActual } from "../lib/helpers.js";

export const renderUserProfile = async (req, res, next) => {
  await pool.query("UPDATE appointment set id_state = 3 WHERE date < ? AND id_state = 1", [getFechaActual()]);
  const [rows] = await pool.query("SELECT a.id,u.fullname,a.date,a.start_time,n.name,n.price,ap.state FROM appointment a JOIN users u ON a.id_user = u.id JOIN nails n ON a.id_nails = n.id JOIN appointment_state ap ON a.id_state = ap.id WHERE ap.state = 'pendiente' AND a.id_user = ?", [req.user.id]);
  res.render("profile", {
    appointment: rows,
  });
};

export const renderRecords = async (req, res, next) => {
  const [rows] = await pool.query("SELECT a.id,u.fullname,a.date,a.start_time,n.name,n.price,ap.state FROM appointment a JOIN users u ON a.id_user = u.id JOIN nails n ON a.id_nails = n.id JOIN appointment_state ap ON a.id_state = ap.id WHERE ap.state = 'realizada' AND a.id_user = ?", [req.user.id]);
  res.render("appointment/records", {
    appointment: rows,
  });
};

export const renderStatisticsAdmin = async (req, res, next) => {
  const [acounts] = await pool.query("SELECT count(id) count FROM appointment WHERE id_state = 2");
  const [prices] = await pool.query("SELECT sum(price) price FROM appointment a JOIN nails n ON a.id_nails = n.id WHERE a.id_state = 2");
  const [users] = await pool.query("SELECT count(u.id) nUsers FROM users u WHERE u.id_rol = 2");

  const [rows] = await pool.query("SELECT MONTHNAME(date) as name, COUNT(*) as cantidad FROM appointment a WHERE a.id_state = 2 AND YEAR(a.date) = YEAR(CURDATE()) GROUP BY MONTHNAME(a.date)");
  const [rows2] = await pool.query("SELECT MONTHNAME(date) as name,sum(n.price) as cantidad FROM appointment a join nails n on a.id_nails = n.id WHERE a.id_state = 2 AND YEAR(a.date) = YEAR(CURDATE()) GROUP BY MONTHNAME(a.date)");
  const [rows3] = await pool.query("SELECT n.name as name, COUNT(*) as cantidad FROM appointment a join nails n on a.id_nails = n.id WHERE a.id_state = 2 AND YEAR(a.date) = YEAR(CURDATE()) GROUP BY n.name");
  const [rows4] = await pool.query("SELECT n.name, sum(n.price) as cantidad FROM appointment a join nails n on a.id_nails = n.id WHERE a.id_state = 2 AND YEAR(a.date) = YEAR(CURDATE()) GROUP BY n.name");

  const data1 = convertJSON(rows);
  const data2 = convertJSON(rows2);
  const data3 = convertJSON(rows3);
  const data4 = convertJSON(rows4);

  res.render("statistics", {
    count: acounts[0].count,
    price: prices[0].price,
    nUsers: users[0].nUsers,
    rows1: data1,
    rows2: data2,
    rows3: data3,
    rows4: data4,
  });
};

export const renderUserAdmin = async (req, res, next) => {
  const [rows] = await pool.query("SELECT id,name,price FROM nails");
  res.render("admin", {
    nails: rows,
  });
};

export const editPriceNails = async (req, res) => {
  const { id } = req.params;
  const { price } = req.body;
  await pool.query("UPDATE nails set price = ? WHERE id = ?", [price, id]);
  res.redirect("/admin");
}

export const renderListPqr = async (req, res, next) => {
  let rows;
  if (req.user.id_rol == 1) {
    [rows] = await pool.query('SELECT p.idpqr,p.tipo,p.descripcion,p.estado,p.fecha,u.fullname FROM pqr p join users u on p.id_user = u.id AND estado = "pendiente"')
    res.render("pqr/listapqradmin", {
      pqrs: rows,
    });
  } else {
    [rows] = await pool.query("SELECT p.idpqr,p.tipo,p.descripcion,p.estado,p.fecha,u.fullname FROM pqr p join users u on p.id_user = u.id WHERE p.id_user = ? AND estado = 'pendiente'", [req.user.id]);
    res.render("pqr/listapqr", {
      pqrs: rows,
    });
  }
};

export const renderCreatePqr = async (req, res, next) => {
  res.render("pqr/crearpqr");
};

export const donePqr = async (req, res, next) => {
  const { id } = req.params;
  await pool.query("UPDATE pqr set estado = 'revisada' WHERE idpqr = ?", [id]);
  res.redirect("/listpqr");
};

export const createPqr = async (req, res, next) => {
  const { tipo, descripcion } = req.body;
  const pqr = {
    descripcion,
    tipo,
  };

  if(tipo === "Abre este menu de selección" || descripcion == "") {
    req.flash("message", "Llena todos los campos");
    return res.redirect("/createpqr");
  }
  pqr.estado = "pendiente";
  pqr.id_user = req.user.id;
  pqr.fecha = getFechaActual();
  await pool.query("INSERT INTO pqr SET ? ", [pqr]);
  res.redirect("/listpqr");
};

export const convertJSON = (rows) => {
  const data = JSON.stringify(rows);
  return data;
}