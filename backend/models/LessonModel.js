import conn from '../config/database.js'

export const getLessons = (result) => {
    conn.query("SELECT * FROM lessons ", (err, results) => {
        if (err) {
            result(err, null)
        } else {
            result(null, results)
        }
    })
}

export const getLessonById = (id, result) => {
    conn.query("SELECT * FROM lessons WHERE id = ?", [id], (err, results) => {
        if (err) {
            result(err, null)
        } else {
            result(null, results[0])
        }
    })
}

export const insertLesson = (data, result) => {
    conn.query("INSERT INTO lessons (id, id_plan, name) VALUES (NULL, ?, ?)", [data.idPlan, data.name], (err, results) => {
        if (err) {
            console.log(err)
            result(err, null)
        } else {
            console.log(results)
            result(null, results)
        }
    })
}

export const updateLessonById = (data, id, result) => {
    conn.query("UPDATE lessons SET id_plan = ?, name = ?  WHERE id = ?", [data.idPlan, data.name, id], (err, results) => {
        if (err) {
            result(err, null)
        } else {
            result(null, results)
        }
    })
}

export const deleteLessonById = (id, result) => {
    conn.query("DELETE FROM lessons WHERE id =?", [id], (err, results) => {
        if(err) {
            result(err, null)
        } else {
            result(null, results)
        }
    })
}

