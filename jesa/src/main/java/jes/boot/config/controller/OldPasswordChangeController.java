package jes.boot.config.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import jes.ioc.s.main.PasswordHistoryService;
import jes.pub.entity.User;
import jes.pub.model.EasyResult4FormSubmit;
import jes.pub.runtime.JesConfig;
import jes.subsystem.s.MessagesSupport;
import jes.subsystem.s.UserService;
import jes.utils.DateUtil;
import jes.utils.TextTemplateUtil;

/**
 * @作者 SUCH
 * @日期 2021年9月8日 下午6:24:11
 * @描述 老版本密码变更，将其切换到新版本的密码规则下
 */
@Controller
public class OldPasswordChangeController {

	public static Logger logger = Logger.getLogger(OldPasswordChangeController.class);

	@Autowired
	private UserService userService;
	@Autowired
	private PasswordHistoryService passwordHistoryService;

	@RequestMapping(value = "oldPasswordChange.do")
	public String oldPasswordChange(ModelMap modelMap, @RequestParam("userId") String userId) {
		Map<String, String> params = new HashMap<String, String>();
		params.put("userId", userId);
		modelMap.put("jsContent", TextTemplateUtil.mergingByClassPath("vm/sys/oldPasswordChange.js", params));
		return "nojsp4js";
	}

	@RequestMapping(value = "doOldPasswordChange.ajax")
	@ResponseBody
	public EasyResult4FormSubmit doOldPasswordChange(@RequestParam Map<String, String> params) {
		String userId = params.get("userId");
		String newPassword = params.get("newPassword");
		if (Integer.parseInt(JesConfig.getConfigValue("BSYS_PASSWORD_MIN_LENGTH", "2")) > newPassword.length()) {
			return new EasyResult4FormSubmit(false,
					MessagesSupport.getMessage("jes.WebContent.res.js.app.main.mmgd", null, "密码过短!", null));
		}
		if (20 < newPassword.length()) {
			return new EasyResult4FormSubmit(false,
					MessagesSupport.getMessage("jes.WebContent.res.js.app.main.mmgc", null, "密码过长!", null));
		}
		if (JesConfig.getConfigValue("JES_PASSWORD_REGX", "").length() != 0) {
			Pattern pattern = Pattern.compile(JesConfig.getConfigValue("JES_PASSWORD_REGX"));
			Matcher matcher = pattern.matcher(newPassword);
			if (!matcher.matches()) {
				return new EasyResult4FormSubmit(false,
						JesConfig.getConfigValue("JES_PWD_ERROR_MSG", MessagesSupport.getMessage("jes.WebContent.res.js.app.main.mmgsbzq", null, "密码设置需同时包含大小写英文，数字和特殊字符!", null)));
			}
		}
		if(newPassword.equals(userId)){
			return new EasyResult4FormSubmit(false,
					MessagesSupport.getMessage("jes.WebContent.res.js.app.main.pwsun", null, "密码不允许与用户名相同！", null));
		}
		if (passwordHistoryService.isValidPwd(userId, newPassword)) {
			return new EasyResult4FormSubmit(false,
					MessagesSupport.getMessage("jes.WebContent.res.js.app.main.cmmzlsjll", null, "此密码在历史记录里，不允许被使用！", null));
		}
		if (passwordHistoryService.pwdHistoryCountIsNotValid(userId, newPassword)) {
			return new EasyResult4FormSubmit(false,
					MessagesSupport.getMessage("jes.WebContent.res.js.app.main.pwinhcount", null, "密码不允许与最近几次使用的相同！", null));
		}
		try {
			User formUser = new User();
			formUser.setUserId(userId);
			formUser.setPassword(newPassword);
			formUser.encryptPassword();
			formUser.setLastLoginDate(DateUtil.getNowTime());
			boolean result = this.userService.changePwd(formUser);
			if (result) {
				this.passwordHistoryService.addPwdHis(userId, formUser.getPassword());
				return new EasyResult4FormSubmit(true,
						"修改密码成功...");
			} else {
				return new EasyResult4FormSubmit(false,
						MessagesSupport.getMessage("jes.WebContent.res.js.app.main.fwqfm", null, "服务器繁忙，密码修改失败...", null));
			}
		} catch (Exception e) {
			logger.error("密码修改时出现的异常：", e);
			return new EasyResult4FormSubmit(false,
					MessagesSupport.getMessage("jes.WebContent.res.js.app.main.fwqfm", null, "服务器繁忙，密码修改失败...", null));
		}
	}

}
