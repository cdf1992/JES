package jes.boot.config.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.Order;
import jes.pub.entity.User;
import jes.subsystem.s.UserService;
import jes.utils.HexUtils;

/**
 * @作者 SUCH
 * @日期 2021年9月8日 下午6:24:11
 * @描述 老版本密码变更，将其切换到新版本的密码规则下
 */
@Order(10)
@WebFilter(filterName = "OldPasswordChangeFilter", urlPatterns = "/login.html")
public class OldPasswordChangeFilter implements Filter {

	@Autowired
	private UserService userService;

	public void init(FilterConfig config) throws ServletException {
	}

	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;

		String method = request.getMethod();
		if ("POST".equals(method)) {
			String userId = request.getParameter("userId");
			String password = request.getParameter("password"); // sm3 编码，可以通过 JES_PASSWORD_HASH 关闭登录编码
			User user = this.userService.selectByPrimaryKey(userId);
			String oldPassword = user.getPassword(); // sha1 编码
			String passwordInited = user.getPasswordInited();
			// C 老版本迁移指定值
			if ("C".equals(passwordInited) && HexUtils.shaHex(password).equals(oldPassword)) {
				// 指定值为 OC 且老密码匹配正确，跳转到密码修改页面
				request.getRequestDispatcher("oldPasswordChange.do").forward(request, response);
				return;
			}
		}
		chain.doFilter(servletRequest, servletResponse);
 	 }

	public void destroy() {
	}

}
