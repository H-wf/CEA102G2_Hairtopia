<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.chat.model.*"%>
<%@ page import="com.member.model.*"%>

<% 
	ChatService chatSvc = new ChatService();
	MemService memSvc = new MemService();
	List<ChatVO> list = chatSvc.getAll();
	MemVO friend = memSvc.getOneMem(4);
	MemVO userSession = memSvc.getOneMem(2);
	pageContext.setAttribute("friend", friend);
	pageContext.setAttribute("userSession", userSession);
	pageContext.setAttribute("list", list);
	request.setAttribute("userName", "Tommy");
%>

<!DOCTYPE html>
<html>


<head>
    <meta charset="UTF-8">
<!--     <meta http-equiv="X-UA-Compatible" content="IE=edge"> -->
<!--     <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
<!--     <title>Document</title> -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resource/web-fonts-with-css/css/fontawesome-all.min.css">
	<script src="<%=request.getContextPath()%>/dist/js/jquery.min.js"></script>
    

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        .chatbox-holder {
            position: fixed;
            right: 0;
            bottom: 0;
            display: flex;
            align-items: flex-end;
            height: 0;
            z-index: 1000;
        }

        .chatbox {
            width: 300px;
            height: 400px;
            margin: 0 20px 0 0;
            position: relative;
            box-shadow: 0 0 5px 0 rgba(0, 0, 0, .2);
            display: flex;
            flex-flow: column;
            border-radius: 10px 10px 0 0;
            background: white;
            bottom: 0;
            transition: .1s ease-out;
        }

        .chatbox-top {
            position: relative;
            display: flex;
            padding: 10px 0;
            border-radius: 10px 10px 0 0;
            background: rgba(0, 0, 0, .05);
        }

        .chatbox-icons {
            padding: 0 10px 0 0;
            display: flex;
            position: relative;
        }

        .chatbox-icons .fa {
            background: rgba(217, 191, 119, .5);
            padding: 3px 5px;
            margin: 0 0 0 3px;
            color: white;
            border-radius: 0 5px 0 5px;
            transition: 0.3s;
        }

        .chatbox-icons .fa:hover {
            border-radius: 5px 0 5px 0;
            background: rgb(217, 191, 119);
        }

        .chatbox-icons a,
        .chatbox-icons a:link,
        .chatbox-icons a:visited {
            color: white;
        }

        .chat-partner-name,
        .chat-group-name {
            flex: 1;
            padding: 5px 0 0 60px;
            font-size: 15px;
            font-weight: bold;
            color: #30649c;
            transition: .1s ease-out;
        }

        .status {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            display: inline-block;
            box-shadow: inset 0 0 3px 0 rgba(0, 0, 0, 0.2);
            border: 1px solid rgba(0, 0, 0, 0.15);
            background: #cacaca;
            margin: 0 3px 0 0;
        }

        /* .online {
            background: #b7fb00;
        }

        .away {
            background: #ffae00;
        }

        .donot-disturb {
            background: #ff4343;
        } */

        .chatbox-avatar {
            width: 40px;
            height: 40px;
            overflow: hidden;
            border-radius: 50%;
            background: white;
            padding: 3px;
            box-shadow: 0 0 5px 0 rgba(0, 0, 0, .2);
            position: absolute;
            transition: .1s ease-out;
            bottom: 0;
            left: 6px;
        }

        .chatbox-avatar img {
            width: 100%;
            height: 100%;
            border-radius: 50%;
        }

        .chat-messages {
            border-top: 1px solid rgba(0, 0, 0, .05);
            padding: 10px;
            overflow: auto;
            display: flex;
            flex-flow: row wrap;
            align-content: flex-start;
            flex: 1;
        }

        .message-box-holder {
            width: 100%;
            margin: 0 0 15px;
            display: flex;
            flex-flow: column;
            align-items: flex-end;
        }

        .message-sender {
            font-size: 12px;
            margin: 0 0 15px;
            color: #30649c;
            align-self: flex-start;
        }

        .message-sender a,
        .message-sender a:link,
        .message-sender a:visited,
        .chat-partner-name a,
        .chat-partner-name a:link,
        .chat-partner-name a:visited {
            color: #30649c;
            text-decoration: none;
        }

        .message-box {
            padding: 6px 10px;
            border-radius: 6px 0 6px 0;
            position: relative;
            background: rgba(100, 170, 0, .1);
            border: 2px solid rgba(100, 170, 0, .1);
            color: #6c6c6c;
            font-size: 12px;
        }

        .message-box:after {
            content: "  ";
            position: absolute;
            border: 10px solid transparent;
            border-top: 10px solid rgba(100, 170, 0, .2);
            border-right: none;
            bottom: -22px;
            right: 10px;
        }

        .message-partner {
            background: rgba(0, 114, 135, .1);
            border: 2px solid rgba(0, 114, 135, .1);
            align-self: flex-start;
        }

        .message-partner:after {
            right: auto;
            bottom: auto;
            top: -22px;
            left: 9px;
            border: 10px solid transparent;
            border-bottom: 10px solid rgba(0, 114, 135, .2);
            border-left: none;
        }

        .chat-input-holder {
            background: rgba(0, 0, 0, .05);
            display: flex;
            border-top: 1px solid rgba(0, 0, 0, .1);
        }


        .chat-input {
            resize: none;
            /* padding: 5px 10px; */
            height: 30px;
            font-family: 'Lato', sans-serif;
            font-size: 14px;
            color: #000;
            flex: 1;
            /* right: ; */
            border: none;
            background: rgba(0, 0, 0, .05);
            border-bottom: 1px solid rgba(0, 0, 0, .05);
        }

        .chat-input:focus,
        .message-send:focus {
            outline: none;
        }

        .message-send::-moz-focus-inner {
            border: 0;
            padding: 0;
        }

        .message-send {
            -webkit-appearance: none;
            background: #999;
            color: white;
            font-size: 12px;
            padding: 0 15px;
            border: none;
            border-radius:10px;
            text-shadow: 1px 1px 0 rgba(0, 0, 0, 0.3);
        }
        .message-send:hover{
        	cursor:pointer;
        	background: #888;
        }

        .chat-input-icons {
            font-size: 20px;
            margin: 4px 5px 0px 5px;
        }
        .chat-input-icons a{
            text-decoration:none;
        }

        .attachment-panel {
            padding: 3px 10px;
            text-align: right;
        }

        .attachment-panel a,
        .attachment-panel a:link,
        .attachment-panel a:visited {
            margin: 0 0 0 7px;
            text-decoration: none;
            color: rgba(0, 0, 0, 0.5);
        }

        .chatbox-min {
            margin-bottom: -362px;
        }

        .chatbox-min .chatbox-avatar {
            width: 40px;
            height: 40px;
        }

        .chatbox-min .chat-partner-name,
        .chatbox-min .chat-group-name {
            padding: 0 0 0 75px;
        }
        
        #uploadImage{
        	display: none;
        }
    </style>
</head>

<body>
	
	<div>
<!-- 		<button class="chatbtn">打開視窗</button> -->
	</div>

    <div class="chatbox-holder">
    
		<!--第一區塊 -->
		<!--第一區塊 -->
		<!--第一區塊 -->
        <div class="chatbox firstChatbox" style="z-index: 1000;">
            <div class="chatbox-top">
                <div class="chatbox-avatar">
                    <img
                        src="<%=request.getContextPath()%>/showImges.do?tableName=member&picColumn=memPic&pkColumn=memNo&memNo=${friend.memNo}" />
                </div>
                <div class="chat-partner-name" id="chatPartnerName">
                    <!-- <span class="status online"></span> -->
<!--                     <a target="_blank" href="#personal page"> -->
                    ${friend.memName}
<!--                     </a> -->
                </div>
                <div class="chatbox-icons">
                    <a href="javascript:void(0);"><i class="fa fas fa-minus"></i></a>
                    <a href="javascript:void(0);"><i class="fa fas fa-times"></i></a>
                </div>
            </div>

			
			<!--聊天內容方格 -->
            <div id="chat-messages" class="chat-messages">
	            <c:forEach var="chatVO" items="${list}">
					<!--會員端內容 -->
					<c:if test="${chatVO.chatSender == friend.memNo}">
						<c:if test="${chatVO.chatReceiver == userSession.memNo}">
							<div class="message-box-holder">
		                    	<div class="message-box">
		                        	${chatVO.chatText}
		                    	</div>
		                	</div>
						</c:if >
					</c:if >
					<!--對象端內容 -->
					<c:if test="${chatVO.chatReceiver == friend.memNo}">
						<c:if test="${chatVO.chatSender == userSession.memNo}">
							<div class="message-box-holder">
<!-- 		                    	<div class="message-sender"> -->
<%-- 			                        ${friend.memName} --%>
<!-- 			                </div> -->
			                
		                    <div class="message-box message-partner">
		                        ${chatVO.chatText}
		                    </div>
	                		</div>
					
						</c:if>
					</c:if>
				</c:forEach>
            
            
            </div>

            <div class="chat-input-holder">
                <div class="chat-input-icons">
                	<input type="file" id="uploadImage" accept="image/*">
                    <a href="javascript:void(0);" id="upload_link"><i class="fas fa-image"></i></a>
                </div>
                <input type="text" class="chat-input" id="message" onkeydown="if (event.keyCode == 13) sendMessage();" autocomplete="off">
				<div class="chat-input-icons">
                    <a href="javascript:void(0);"><i class="fas fa-reply"></i></a>
                </div>

            </div>
        </div>



    </div>
    <script>
        ////改成登入時,塞進session的memVO
	    var MyPoint = "/FriendWS/${userSession.memName}";
		var host = window.location.host;
		var path = window.location.pathname;
		var webCtx = path.substring(0, path.indexOf('/', 1));
		var endPointURL = "ws://" + host + webCtx + MyPoint;
		var chatPartnerName = document.getElementById("chatPartnerName");
		var messagesArea = document.getElementsByClassName("chat-messages")[0];

        //改成登入時,塞進session的memVO
		var self = '${userSession.memName}';
		var webSocket;
        
    
        $(document).ready(function () {
            $('.fa-minus').click(function () {
                $(this).closest('.chatbox').toggleClass('chatbox-min');
            });
            $('.fa-times').click(function () {
                $(this).closest('.chatbox').hide();
                disconnect();
                
            });
            
            $('.chatbtn').click(function(){
            	$('.firstChatbox').toggle();
            	// $('.secondChatbox').toggle();
            	connect();
            });
            
            $('.fa-reply').click(sendMessage);
            
            $("#upload_link").on('click', function(e){
                e.preventDefault();
                $("#uploadImage:hidden").trigger('click');
            });
            
            $("#uploadImage").change(function(e){	
            	console.log("Trigger");
                sendImage(e);

            });
            
        });
        
        	
        
        
        
        function connect() {
    		// create a websocket
    		<%
//     			System.out.println(1234);
    		%>
    		webSocket = new WebSocket(endPointURL);
    		webSocket.binaryType = "arraybuffer";
    		
    		webSocket.onopen = function(event) {
    			console.log("Connect Success!");
    			getHistory();
    			console.log(chatPartnerName.textContent.trim());
    		};

    		webSocket.onmessage = function(event) {
    			var jsonObj = JSON.parse(event.data);
    			console.log(jsonObj);
    			if ("open" === jsonObj.type) {
    				console.log("open");
    			} else if ("history" === jsonObj.type) {   				
    				messagesArea.innerHTML = '';
    				
    				// 這行的jsonObj.message是從redis撈出跟好友的歷史訊息，再parse成JSON格式處理
    				var messages = JSON.parse(jsonObj.message);
    				for (var i = 0; i < messages.length; i++) {
    					//轉換JSON物件
    					var historyData = JSON.parse(messages[i]);
    					var showMsg = historyData.message;
    					console.log(historyData.type);
    					//建立訊息方塊
    					var boxHolder = document.createElement('div');
    					boxHolder.classList.add('message-box-holder');
        				var box = document.createElement('div');
        				box.classList.add('message-box');	
        				
    					// 根據發送者是自己還是對方來給予不同的class名, 以達到訊息左右區分
    					if(historyData.sender !== self) {box.classList.add('message-partner');}
    					
    					//塞入訊息
    					box.textContent = showMsg;
    					//塞入方塊區
    					boxHolder.appendChild(box);
    					messagesArea.appendChild(boxHolder);
    					
    				}
    				//將視窗拉到底部顯示
    				messagesArea.scrollTop = messagesArea.scrollHeight;
    			} else if ("chat" === jsonObj.type) {
    				//建立訊息方塊
					var boxHolder = document.createElement('div');
					boxHolder.classList.add('message-box-holder');
    				var box = document.createElement('div');
    				box.classList.add('message-box');	
    				
    				// 根據發送者是自己還是對方來給予不同的class名, 以達到訊息左右區分
					if(jsonObj.sender !== self) {box.classList.add('message-partner');}
    				
					//塞入訊息
					box.textContent = jsonObj.message;
					
    				console.log(box);
    				
    				//塞入方塊區
					boxHolder.appendChild(box);
					messagesArea.appendChild(boxHolder);
					//將視窗拉到底部顯示
    				messagesArea.scrollTop = messagesArea.scrollHeight;
    			} else if ("image" === jsonObj.type){
                    console.log(jsonObj.message);

                }else if ("close" === jsonObj.type) {
    				refreshFriendList(jsonObj);
    			}
    			
    		};

    		webSocket.onclose = function(event) {
    			console.log("Disconnected!");
    		};
    	}
        
    	function getHistory() {
    		var container = document.getElementById("row");
            //要改成抓hidden傳送要交談的對象,可以先傳到session存起來(VO 或 單純朋友名字)
   			var friend = "${friend.memName}";
   			var jsonObj = {
   					"type" : "history",
   					"sender" : self,
   					"receiver" : friend,
   					"message" : ""
   				};
    			webSocket.send(JSON.stringify(jsonObj));
    	}
        
    	function sendMessage(){
//     		var inputMessage = document.getElementById("message");

            //要改成抓hidden傳送要交談的對象,可以先傳到session存起來(VO 或 單純朋友名字)
    		var friend = "${friend.memName}";
    		var message = $('#message').val().trim();

    		if (message !== "") {
    			var jsonObj = {
        				"type" : "chat",
        				"sender" : self,
        				"receiver" : friend,
        				"message" : message
        			};
        		webSocket.send(JSON.stringify(jsonObj));
//         		inputMessage.value = "";
				$('#message').val("");
				$('#message').focus();
    		}
        }

        function sendImage(e){
            let imageURL = new Float64Array(evt.data);;
            let files = e.target.files;
            if (files) {
                    // 取出files物件的第一個
                let file = files[0];
                    // 判斷file.type的型別是否包含'image'
                if (file.type.indexOf('image') > -1) {
                        // 填入檔名
                        // filename.value = file.name;
                        // new a FileReader
                        let reader = new FileReader();
                        // 在FileReader物件上註冊load事件 - 載入檔案的意思
                        reader.addEventListener('load', function(e) {
                            // 取得結果 提示：從e.target.result取得讀取到結果
                            imageURL = e.target.result;
                            console.log('Start');
                             //要改成抓hidden傳送要交談的對象,可以先傳到session存起來(VO 或 單純朋友名字)
                            var friend = "${friend.memName}";
    		                var message = imageURL;
                            console.log("start send image");
                            var jsonObj = {
                                "type" : "image",
                                "sender" : self,
                                "receiver" : friend,
                                "message" : "123"
                            };  
                            webSocket.send(JSON.stringify(jsonObj));
                            console.log("finished send image");
                        });
                        // 使用FileReader物件上的 readAsDataURL(file) 的方法，傳入要讀取的檔案，並開始進行讀取
                        reader.readAsDataURL(file);
                        
    		            
                } else {
                    // 彈出警告視窗 alert('請上傳圖片！');
                    alert('請上傳圖片！');
                }
            }  		
    	}
        
        function disconnect() {
    		webSocket.close();
    	}
        
        
        

    </script>
</body>

</html>