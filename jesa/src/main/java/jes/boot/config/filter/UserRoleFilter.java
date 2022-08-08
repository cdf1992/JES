package jes.boot.config.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.web.context.support.WebApplicationContextUtils;

import jes.pub.entity.User;
import jes.pub.runtime.JesConfig;
import jes.pub.runtime.Login;
import jes.pub.runtime.LoginManager;
import jes.subsystem.dao.LoginRegMapper;
import jes.subsystem.dao.UserMapper;
import jes.subsystem.s.ClusterService;
import jes.subsystem.s.LoginService;
import jes.utils.SSOHelper;
import jes.utils.StringUtil;
import jes.utils.third.DESEncrypter;

/**
 * 
 * @author CXF
 * 
 */
public class UserRoleFilter implements Filter {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(UserRoleFilter.class);

	private UserMapper userMapper = null;

	private ClusterService clusterService = null;

	private LoginRegMapper loginRegMapper = null;

	private LoginService loginService = null;

	private volatile String port = null;

	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;

		if (isOutterRequest(request, response)) {
			return;
		}
		String loginId = SSOHelper.getRequestValue(request, Login.LOGIN_ID);
		if (request.getSession(false) == null && loginId == null) {
			System.out.println("Session has been invalidated!");
			if (request.getHeader("x-requested-with") != null && "XMLHttpRequest".equalsIgnoreCase(request.getHeader("x-requested-with"))) {
				response.addHeader("sessionstatus", "timeout");
				return; // 如果此处不写return，则会报response has committed错误
			} else {
				gotoLogin(request, response);
				return;
			}
		}
		HttpSession session = request.getSession();
		if ("Y".equals(JesConfig.getConfigValue("BSYS_FORCE_LOGOFF", "N"))) {
			if (StringUtil.isY(JesConfig.getConfigValue("BSYS_LOGIN_INDB", "N"))) {
				if (loginRegMapper.selectByPrimaryKey(loginId) == null) {
					gotoLogin(request, response);
					return;
				}
			} else {
				if (!LoginService.hasLogin(loginId)) {
					if (loginRegMapper.selectByPrimaryKey(loginId) == null) {
						gotoLogin(request, response);
						return;
					}
				}
			}
		}

		Login login = (Login) session.getAttribute(LoginService.SESSION_LOGIN_LOGIN);

		if (null == login || null == login.getLoginId()
				|| (null != loginId && !Login.parseUserIdByLoginId(loginId).equals(Login.parseUserIdByLoginId(login.getLoginId())))) {
			if (!testSsoLogin(request, response)) {
				String uuid = SSOHelper.getRequestValue(request, "UUID");
				if(null==uuid){
					if (!testSsoLogin(request, response)) {
						// if (loginRegMapper.selectByPrimaryKey(loginId) == null) {
						gotoLogin(request, response);
						return;
						// }
					}
				}else{
					chain.doFilter(req, res);
					if (port == null) {
						port = String.valueOf(request.getLocalPort());
						clusterService.updateMyPort(StringUtil.makeIpv6toIpv4ForLocalhost(request.getLocalAddr()), port);
					}
				}
			}
		} else {
			LoginManager.setLogin(login);
		}
		chain.doFilter(req, res);
		if (port == null) {
			port = String.valueOf(request.getLocalPort());
			clusterService.updateMyPort(StringUtil.makeIpv6toIpv4ForLocalhost(request.getLocalAddr()), port);
		}
	}

	public static boolean isOutterRequest(HttpServletRequest request, HttpServletResponse response) {
		if (StringUtil.isY(JesConfig.getConfigValue("FORBIDDEN_OUTTER_LOGIN_REQUEST", "N"))) {
			String r = request.getHeader("Referer");
			String h = request.getHeader("Host");
			if (StringUtil.isEmpty(h)) {
				h = request.getLocalName();
			}
			if (StringUtil.isNotEmpty(r) && (r.indexOf(h) == -1 || r.indexOf(h) > "https://".length())) {
				logger.warn("非法用户通过[" + r + "],尝试登录本系统[" + h + "].");
				try {
					response.getWriter().println("Illegal users access denied!");
				} catch (IOException e) {
				}
				return true;
			}
		}
		return false;
	}

	private String getDebugInfo(HttpServletRequest request) {
		StringBuffer sb = new StringBuffer();
		sb.append("\r\n====ReuestInfo4Debug===BEGIN==============\r\n");
		sb.append("JesConfig-BSYS_FORCE_LOGOFF=").append(JesConfig.getConfigValue("BSYS_FORCE_LOGOFF")).append("\r\n");
		sb.append("JesConfig-BSYS_LOGIN_INDB=").append(JesConfig.getConfigValue("BSYS_LOGIN_INDB")).append("\r\n");
		sb.append("request.getParameter(loginId)=").append(request.getParameter("loginId")).append("\r\n");
		sb.append("SSOHelper.getCookieValue(request, 'loginId')=").append(SSOHelper.getCookieValue(request, "loginId")).append("\r\n");
		sb.append("request.clientIp=").append(SSOHelper.getRemoteAddr(request)).append("\r\n");
		sb.append("request.getSession().getAttribute(LoginService.SESSION_LOGIN_LOGIN)=")
				.append(request.getSession().getAttribute(LoginService.SESSION_LOGIN_LOGIN)).append("\r\n");
		sb.append("====requestInfo-by-appServer========\r\n");
		sb.append(request);
		sb.append("====ReuestInfo4Debug===END==============\r\n");
		return sb.toString();
	}

	private void gotoLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
		if (logger.isDebugEnabled()) {
			logger.debug(getDebugInfo(request));
		}
		String loginPage = JesConfig.getConfigValue("JES_SSO_LOGIN_PAGE", request.getContextPath() + "/login.html");
		if (!StringUtil.isEmpty(loginPage)) {
			response.sendRedirect(loginPage);
		} else {
			response.sendRedirect(request.getContextPath() + "/login.html");
		}
	}

	private boolean testSsoLogin(HttpServletRequest request, HttpServletResponse response) {
		String loginId = SSOHelper.getRequestValue(request, Login.LOGIN_ID);

		if (StringUtil.isY(JesConfig.getConfigValue("BSYS_USE_NOLOGIN", "N"))) {// 不登录也能使用本系统功能
			User user = new User();
			user.setUserId("nologin");
			user.setInstId("nologin_inst");
			Login login = new Login();
			login.initLogin(request);
			login.setUser(user);
			login.getLoginId();// init loginId
			login.setLogined(true);
			loginService.doAfterLogin(request, response, login);
			return true;
		}

		if (StringUtil.isY(JesConfig.getConfigValue("BSYS_LOGIN_INDB", "N"))) {
			if (loginRegMapper.selectByPrimaryKey(loginId) == null) {
				return false;
			}
		} else {
			if (!LoginService.hasLogin(loginId)) {
				return false;
			}
		}

		String loginIp = StringUtil.makeIpv6toIpv4ForLocalhost(DESEncrypter.decrypt(loginId).split("\t")[1]);
		String clientIp = StringUtil.makeIpv6toIpv4ForLocalhost(SSOHelper.getRemoteAddr(request));
		if (logger.isInfoEnabled()) {
			logger.info("sso filter---checkUser--loginIp,clientIp:" + loginIp + "," + clientIp);
		}
		// 当以localhost或者127.0.0.1访问系统时clientIp是对应不上的By TK
		if (loginIp.equals(clientIp)) { // loginController.login
			try {
				String userId = Login.parseUserIdByLoginId(loginId);
				User user = userMapper.selectByPrimaryKey(userId);
				Login login = new Login();
				login.setLoginId(loginId);
				login.setLogined(true);
				login.setUser(user);
				loginService.doAfterLogin(request, response, login);
				return true;
			} catch (Exception e) {

				logger.error("testSsoLogin(HttpServletRequest) - loginId=" + loginId, e); //$NON-NLS-1$

				return false;
			}
		} else {
			return false;
		}

	}

	public void destroy() {
		logger.info("destroy()");
	}

	@Override
	public void init(FilterConfig c) throws ServletException {
		if (logger.isInfoEnabled()) {
			logger.info("init(FilterConfig) - c=" + c); //$NON-NLS-1$
		}
		userMapper = WebApplicationContextUtils.getWebApplicationContext(c.getServletContext()).getBean(UserMapper.class);
		clusterService = WebApplicationContextUtils.getWebApplicationContext(c.getServletContext()).getBean(ClusterService.class);
		loginRegMapper = WebApplicationContextUtils.getWebApplicationContext(c.getServletContext()).getBean(LoginRegMapper.class);
		loginService = WebApplicationContextUtils.getWebApplicationContext(c.getServletContext()).getBean(LoginService.class);
	}
}
