package com.cossche.controller;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.cos.model.CosDAO;
import com.cossche.model.CosscheDAO;
import com.cossche.model.CosscheVO;

public class ScheServlet2 extends HttpServlet{    
    Timer timer ; 
    int count = 0;  
    CosscheDAO dao = new CosscheDAO();
    public void destroy(){
        timer.cancel();
    }
    
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
    }
            
    public void init(){        
        timer = new Timer();
        Calendar cal = new GregorianCalendar(2021, Calendar.FEBRUARY, 1, 0, 0, 0);        
        TimerTask task = new TimerTask(){
                   
            public void run(){
                System.out.println("This is Task"+ count);
                System.out.println("工作排定的時間 = " + new Date(scheduledExecutionTime()));
                System.out.println("工作執行的時間 = " + new Date() + "\n");                
                count++;
                dao.updateCosStatusWhenApplyStart();
                dao.updateCosStatusWhenApplyOver();
                
            }
        };
        timer.scheduleAtFixedRate(task, cal.getTime(), 24*60*60*1000); 
    }
}

