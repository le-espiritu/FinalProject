package com.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@ServerEndpoint(value = "/ws") //ws��� �̸����� Ws��� Ŭ������ ����ϰڴ�.
public class Ws {

	private static final List<Session> sessionList = new ArrayList<Session>();; //List -> ���ÿ� �������� ���������� ������ �������鿡 ���� ������ List�� ��ڴ�. List�� ��� �������� ���ôٹ������� �޽����� �Ѹ��� ���ؼ�

	public Ws() {
		// TODO Auto-generated constructor stub
		System.out.println("������(����) ��ü����");
	}

	@RequestMapping(value = "/webNotification.mc")
	@ResponseBody
	public void getData(HttpServletRequest request) { // ������ ������(������ �޹̸� ��������) 
		String P_id = request.getParameter("P_id");
		String askHelp = request.getParameter("askHelp");
		System.out.println("getData:" + P_id+askHelp);
		sendAllMessage("���� ��û�� ���� ������ :" + P_id+"\n��û���� :"+askHelp); // �޼����� �ѷ��ְ� ���� 
	}

	private void sendAllMessage(String message) {
		System.out.println("������(����) sendAllMessage");
		try {
			for (Session session : Ws.sessionList) {
					session.getBasicRemote().sendText(message);
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
	}

	@OnOpen
	public void onOpen(Session session) { //���������� ���������� ������ ��û�ϰ� �Ǹ� �ڵ����� Onopen��û�� ��.
		System.out.println("Open session id:" + session.getId());  //���ӵ� ������ ���̵� �������ܴ�.

		try {
			final Basic basic = session.getBasicRemote();  
			//basic.sendText("Connection Established--------------------");
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
		sessionList.add(session); // ��̸���Ʈ�� ������ ������ �������� ����.
	}

	/*
	 * ��� ����ڿ��� �޽����� �����Ѵ�.
	 * 
	 * @param self
	 * 
	 * @param message
	 */
	private void sendAllSessionToMessage(Session self, String message) { // �� �ڽ��� �����ϰ� ������� �޼����� ����̿��� �����ض�.
		System.out.println("������(����) sendAllSessionToMessage");
		try {
			for (Session session : Ws.sessionList) {
				if (!self.getId().equals(session.getId())) {
					session.getBasicRemote().sendText(message);
				}
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

	@OnMessage
	public void onMessage(String message, Session session) { // ���������� �޽����� �ö���� �ڵ����� onMessage�� �ڵ����� ȣ��� 
		System.out.println("������(����) onMessage");
		System.out.println("Message From " + message);
		try {
			final Basic basic = session.getBasicRemote();
			basic.sendText("sent Messge : " + message); // �������� �ٽ� �޼����� ����
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		sendAllSessionToMessage(session, message); 
	}

	@OnError
	public void onError(Throwable e, Session session) {

	}

	@OnClose
	public void onClose(Session session) {
		System.out.println("������(����) onClose");
		sessionList.remove(session);
	}
}