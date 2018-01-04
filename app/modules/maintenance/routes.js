var express = require('express');
var mainteRouter = express.Router();
var db = require('../../lib/database')();
var authMiddleware = require('../auth/middlewares/auth');
var counter = require('../auth/middlewares/SC');

mainteRouter.route('/')
    .get((req,res)=>{
        res.render('maintenance/views/maintenance');
    });

mainteRouter.route('/Accounts')
    .get((req,res)=>{
        res.render('maintenance/views/accounts');   
    });




mainteRouter.route('/Emp')
    .get((req,res)=>{
        db.query(`select * from tblemptype`,(err,results,field)=>{
            return res.render('maintenance/views/emp', {emps : results});
        });
    });
mainteRouter.route('/Emp/new')
    .get((req,res)=>{
        db.query(`SELECT max(strEmpTypeID) AS strEmpTypeID FROM tblemptype`,(err,results,field)=>{
            res.locals.ID = results[0].strEmpTypeID; 
            return res.render('maintenance/forms/empform');
        });
    })
    .post((req,res)=>{
        var newID = counter.smart(req.body.etid);
        db.query(`INSERT INTO tblemptype (strEmpTypeID,strEmpTypeDesc) VALUES ("${newID}","${req.body.etname}");`,(err,results,field)=>{
            if(err) throw err;
            return res.redirect('/maintenance/Emp');
        });
    })
mainteRouter.route('/Emp/:strEmpTypeID')
    .get((req,res)=>{
        db.query(`select * from tblemptype WHERE strEmpTypeID = "${req.params.strEmpTypeID}"`,(err,results,field)=>{
            if(err) throw err;
            if(results[0]==null) res.redirect('/maintenance/Emp');
            res.render('maintenance/forms/empform', {EmployeeType : results[0]});
        });
    })
    .put((req,res)=>{
        db.query(`UPDATE tblemptype SET
        strEmpTypeDesc = "${req.body.etname}"
        WHERE strEmpTypeID = "${req.params.strEmpTypeID}"`,(err,results,field)=>{
            if(err) throw err;
            res.redirect('/maintenance/Emp');
        });
    })
mainteRouter.get('/Emp/:strEmpTypeID/remove',(req,res)=>{
    db.query(`DELETE FROM tblemptype WHERE strEmpTypeID = "${req.params.strEmpTypeID}"`,(err,results,field)=>{
        if(err) throw err;
        res.redirect('/maintenance/Emp');
    });
});



mainteRouter.route('/Class')
    .get((req,res)=>{
        db.query(`select * from tblclass`,(err,results,field)=>{
            return res.render('maintenance/views/Class', {Classes : results});
        });
    });
mainteRouter.route('/Class/new')
    .get((req,res)=>{
        db.query(`SELECT max(strClassID) AS strClassID FROM tblclass`,(err,results,field)=>{
            res.locals.ID = results[0].strClassID; 
            return res.render('maintenance/forms/classform');
        });
    })
    .post((req,res)=>{
        var newID = counter.smart(req.body.etid);
        db.query(`INSERT INTO tblclass (strClassID,strClassName) VALUES ("${newID}","${req.body.etname}");`,(err,results,field)=>{
            if(err) throw err;
            return res.redirect('/maintenance/Class');
        });
    })
mainteRouter.route('/Class/:strClassID')
    .get((req,res)=>{
        db.query(`select * from tblclass WHERE strClassID = "${req.params.strClassID}"`,(err,results,field)=>{
            if(err) throw err;
            if(results[0]==null) res.redirect('/maintenance/Class');
            res.render('maintenance/forms/classform', {Class : results[0]});
        });
    })
    .put((req,res)=>{
        db.query(`UPDATE tblclass SET
        strClassName = "${req.body.etname}"
        WHERE strClassID = "${req.params.strClassID}"`,(err,results,field)=>{
            if(err) throw err;
            res.redirect('/maintenance/Class');
        });
    })
mainteRouter.get('/Class/:strClassID/remove',(req,res)=>{
    db.query(`DELETE FROM tblclass WHERE strClassID = "${req.params.strClassID}"`,(err,results,field)=>{
        if(err) throw err;
        res.redirect('/maintenance/Class');
    });
});




mainteRouter.route('/Rooms')
    .get((req,res)=>{
        db.query(`select * from tblrooms`,(err,results,field)=>{
            return res.render('maintenance/views/rooms', {rooms : results});
        });
    });
mainteRouter.route('/Rooms/new')
    .get((req,res)=>{
        db.query(`SELECT max(strRoomID) AS strRoomID FROM tblrooms`,(err,results,field)=>{
            res.locals.ID = results[0].strRoomID; 
            return res.render('maintenance/forms/roomform');
        });
    })
    .post((req,res)=>{
        var newID = counter.smart(req.body.etid);
        db.query(`INSERT INTO tblrooms (strRoomID,strRoomName) VALUES ("${newID}","${req.body.etname}");`,(err,results,field)=>{
            if(err) throw err;
            return res.redirect('/maintenance/Rooms');
        });
    })
mainteRouter.route('/Rooms/:strRoomID')
    .get((req,res)=>{
        db.query(`select * from tblrooms WHERE strRoomID = "${req.params.strRoomID}"`,(err,results,field)=>{
            if(err) throw err;
            if(results[0]==null) res.redirect('/maintenance/room');
            res.render('maintenance/forms/roomform', {Room : results[0]});
        });
    })
    .put((req,res)=>{
        db.query(`UPDATE tblrooms SET
        strRoomName = "${req.body.etname}"
        WHERE strRoomID = "${req.params.strRoomID}"`,(err,results,field)=>{
            if(err) throw err;
            res.redirect('/maintenance/Rooms');
        });
    })
mainteRouter.get('/Rooms/:strRoomID/remove',(req,res)=>{
    db.query(`DELETE FROM tblrooms WHERE strRoomID = "${req.params.strRoomID}"`,(err,results,field)=>{
        if(err) throw err;
        res.redirect('/maintenance/Rooms');
    });
});


    

mainteRouter.route('/Subjects')
    .get((req,res)=>{
        db.query(`SELECT * FROM tblsubjects`,(err,results,field)=>{
            return res.render('maintenance/views/subjects',{subjects : results});
        });
    });
mainteRouter.route('/Subjects/new')
    .get((req,res)=>{ 
            res.render('maintenance/forms/subjectform');
    })
    .post((req,res)=>{
        db.query(`INSERT INTO tblsubjects (strSubjectID,strSubjectDesc,intSubjUnits) VALUES ("${req.body.etid}","${req.body.etname}",${req.body.etunits});`,(err,results,field)=>{
            if(err) throw err;
            return res.redirect('/maintenance/Subjects');
        });
    })
mainteRouter.route('/Subjects/:strSubjectID')
    .get((req,res)=>{
        db.query(`select * from tblsubjects WHERE strSubjectID = "${req.params.strSubjectID}"`,(err,results,field)=>{
            if(err) throw err;
            if(results[0]==null) res.redirect('/maintenance/Subjects');
            res.render('maintenance/forms/subjectform', {Subject : results[0]});
        });
    })
    .put((req,res)=>{
        db.query(`UPDATE tblsubjects SET
        strSubjectID = "${req.body.etid}"
        strSubjectDesc = "${req.body.etname}"
        intSubjUnits = ${req.body.etunits}
        WHERE strSubjectID = "${req.params.strSubjectID}"`,(err,results,field)=>{
            if(err) throw err;
            res.redirect('/maintenance/Subjects');
        });
    })
mainteRouter.get('/Subjects/:strSubjectID/remove',(req,res)=>{
        db.query(`DELETE FROM tblsubjects WHERE strSubjectID = "${req.params.strSubjectID}"`,(err,results,field)=>{
            if(err) throw err;
            res.redirect('/maintenance/Subjects');
        });
    });




exports.maintenance = mainteRouter;