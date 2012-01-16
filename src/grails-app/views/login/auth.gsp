<html>
<head>
	<meta name='layout' content='clay'/>
</head>

<body>
<div id='login'>
	<div class='inner'>
		<form action='${postUrl}' method='POST' id='loginForm' class='cssform' autocomplete='off'>
			<p>
				<label class="formLabel" for='username'><g:message code="springSecurity.login.username.label"/>:</label>
				<input type='text' class='formLabel' name='j_username' id='username'/>
			</p>

			<p>
				<label class="formLabel" for='password'><g:message code="springSecurity.login.password.label"/>:</label>
				<input type='password' class='formInput' name='j_password' id='password'/>
			</p>

			<p id="remember_me_holder">
                <label class="formLabel"></label>
				<input type='checkbox' class='chk' name='${rememberMeParameter}' id='remember_me' <g:if test='${hasCookie}'>checked='checked'</g:if>/>
				<label class="formLabel" for='remember_me'><g:message code="springSecurity.login.remember.me.label"/></label>
			</p>

			<p>
                <label for="submit" class="formLabel"></label>
				<input type='submit' id="submit" value='${message(code: "springSecurity.login.button")}'/>
			</p>
		</form>
	</div>
</div>
<script type='text/javascript'>
	<!--
	(function() {
		document.forms['loginForm'].elements['j_username'].focus();
	})();
	// -->
</script>
</body>
</html>
