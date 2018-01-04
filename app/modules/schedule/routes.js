var express = require('express');
var schedRouter = express.Router();
var db = require('../../lib/database')();
var authMiddleware = require('../auth/middlewares/auth');

schedRouter.route('/class')
    .get((req,res)=>{
        res.render('schedule/views/classF');
    });


schedRouter.route('/class/pick')
    .get((req,res)=>{
        res.render('schedule/views/class');
    });

schedRouter.route('/faculty')
    .get((req,res)=>{
        res.render('schedule/views/facultyf');
    });

schedRouter.route('/faculty/pick')
    .get((req,res)=>{
        res.render('schedule/views/faculty');
    });


exports.schedule = schedRouter;