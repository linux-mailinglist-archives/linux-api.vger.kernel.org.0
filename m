Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098712BB771
	for <lists+linux-api@lfdr.de>; Fri, 20 Nov 2020 21:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731667AbgKTUjk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Nov 2020 15:39:40 -0500
Received: from sonic305-28.consmr.mail.ne1.yahoo.com ([66.163.185.154]:38150
        "EHLO sonic305-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731662AbgKTUjk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Nov 2020 15:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605904778; bh=jsWpO9P6VghqO1+djzVHv/WzKTYjeGKpCHVDspDMBXo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=LFapbIR6NUGs5GmW9VnK+FKDh72W6v4PFHMtaPTtyAKSibmuBAyWh2yoCS/joMCkarp+RNzwFWo+xUAsRjrHm7tiDfds7S4TkdKclEXGgqpiNc/kTqTnH5e4QUmKXHydPdIjyPB8L3WbEvlV5wv1wqqNKeeSTghQ3D5UfbYRxophSu3LYPScskhzPY6JtYxi7cGqhh6oIEahjo/hA/AFuTK1KhUQtLgz4BlyqN6L/JauuPjniJwWr1X72gVrcYjAuvLZnKIO10zFi/TUnGVeNTZIXHQJJyTC7LkkgsIFvuKk51S734Vq3SQmPJGUTiDk6pNCR36nHp0JSehC90oPLA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605904778; bh=DbkJBENiaO+XOQhl9cwItYGLtYlkESO/82MNeqC35Xo=; h=From:To:Subject:Date:From:Subject; b=j/zEAdXIlxWz1u4goJskentVAmhOVuCVhg9pYmDI9emrXUTtNNIRQuc7gry7gPhdkQQHLGIJl11PULb4hiogFqnA+FY39uNhqCA6S2wxNnprNQ7YDqcu2MdoujFBrGNRE7PfAJj04M5/Druq8jB4HqxKhjqzVr4Lt3GH6hK/RMk4zN09l1ftx5qvVLanv+54J3XscDHqEPIXnING/cqFuXAAFj0Ln1rjkLXe6g7Z+r50QdwcVW+NcOTjTl3NyEpVFSd5GzJzPlkTpE8YT6tv9dJFl+DVkrhGejpRgjyZpO2DMvVqWLfBP9TbFlBYqifZ1cUxE7zFn+9EM5GOlrmiaQ==
X-YMail-OSG: KKh6eHkVM1lG5F3iKI_yS.Tym20S6_v5C3Q5RhPKE5DJgogg4UX80ZehOO9_MxH
 IXgZmxiL6GOvAYYssrypP3EftvvWOF94ug._3v3H5yuu_Aw.SDRyT8..R3Wp7TA_ATyH9inDRgSg
 EjvZIlJXcRrRD6HDh_MYEVaeXlw4BxLqgNRNq7H7shuIYea90i0nXW3mWzbJLbEtqFS1F_MN5pvl
 c9YtRC266FlgqhjyBiGyZnLw5zcOglp9ghtRHHfFbuoznjFFPyiXtHvAeICArbll3J8y0oQpnLM.
 wrnB8T7p.H7BMnJTIG61Wuz9xDeHk4s.REiYsa15xeEhDkOf_mS0nNb6OcFV5anZT5Uy7kb0FsjX
 eyz1ftqt5daiBl2EBKccqZl89nKTlNFafvufjT4pTip.9Pl7A7Nfi6q3wenTSLp06ZOir7RkHVI2
 jC8YD_pihpbC9HjFVqreLH6xk56ctjImfmEkanY7SirfVqV030JntJiTM3XHoeInsiJO2X1RLvZF
 ccnA_DyLw6cW_vgbZlRYUDOJlugkELD48K.Kj2xNOH2_esz7HfN5jxlRZwFSOS5Kx37GnXNryNK8
 CKgERGKNFlpFUctA6ZHoccK92sAsk6uwDi4IXMs4JlDnkP0ESP.TsBZtsMsfx0bqrMrOCUAqKlXS
 IpmdeVliRFmo4kc8QJUL_ALNnsTplWKylM3W0VTyr1vWoZlzmz4QyZtBveU5o.2wVlE2oC3nFLiu
 9pbYyptCgW..yU9uToZhnkZnRx8Yf4RvQxU3.SuMEiXvFUNjOFjSN6o9qz5s0Ff0JKKfoDkHieHN
 azHndSwhed.LWEpfC8uGy4ZuFA1bHiLzlmkBdPm5VwXqKXcQT3z_ejjqda4SuL8u.vpoXpO2XAdU
 RqG8OcdwATtZh5E45Kau9Qnls3Fh_RPn.QTx7yWYiwbA0NhH5uwPW1kmV4Z8KqQFusLjph6pQPMT
 2npd_62oZVvv_u981lJaDzdR6SvnAxvHHs9rBvdRKeK4Bw3579iuVU._oIP8AlZtYDsVAcyvWDL_
 mcM07SeYMfv2YQIKAeQ2xhE2TF2dIB18jlk.B6Vco.n_FPO76jBKKnPXt1r7qOCJjgilJaahSDIh
 NGxoSgx4RLiDOZvn91enRPyn45i.GtDMxMT_Ov5TctYXPBUjtf42l94Zr1nt58vS.BpXa0thzIg0
 .HjrljvHJx8uNLuxLQ1_hr8ooXC9EoZN9MqHsiXEMsV.c4hiH1TZ_nLlaGAaZZEtpv9YpbCfc2W9
 IxrGHTasxMXg22X7sOOzoo72lxol4qAfKPbeb83FCLU8izjoLf8Wjl6S_QP6RwSSD2_cn7Rk3Rvm
 YDUT2b_P_5.gKEx9NG34OhbTf_IL4KvGBLR_J83a7jBJZcWnX1.HfVMiRVAf4B7UmKzLecLrcELD
 XANBFMbn6GX9N8VXOY6M.eQvvzsVnxDWF4DFXt2Y7yuW9mbKTqPYEylSraLbShI7e7jICdael9.V
 MhykdMYySslZneiIYXFucE4q.IT3tnW0lLQv39b3v4AinCqnLORkDq6zEbFQpaUIBEtJD6cR6zDd
 oamps5uJRQORjgWBqV.lF1qoseq.Huq4fjjAoOuSjXJwku8KW7He4dXyNhUrHq5mqMCWERD1UGSW
 gt37C81ZCOUxJvADHOixMq29HVXu2b4HYga6ZUhiPrQ53W5Jtor5sMuypcY9nOnSy72PuTSkWNYx
 73RyTbvyu.1EWH9R9V_queYoW4l_XLYEOZNo8FEEYwKFc1UCntW2iI0furGQyvp_GbeZzgVeGK_t
 WTYNxAYsYC3LHwnCbFRBkSQZ0khbIuzP8TYFFX26m6P4TImCd7b71gR8frzOOk8T4IYEF0Eh1IwT
 F_jNCq5Mjo6.fWpTGPS_J4muYoWPwj7eh8yO7CZ0ZjkJtcB0u_e8HEox0UilA6Ts2Lx29FhSpaMd
 dQ1.UWC8N2kWu2spZ8wQTVp51Rn1MIsRfrTZGYN8t0H2sBIrC01fxsLi2SxBEnicy6BK5iHaXlPs
 jq3OmjsiFhUKsqKT3PNeT8aO2h4oKFnyU2WIWkMgGnx8y.s7f5q2fmQ4HfNdBrX9fiCNJWC.yDYJ
 qZKcyGqzu78g4ZhoefSfVq1k3WwpglUgnVT4d8JbuG9XyD_j7ATplPnlTRNUTp1HiZBvKi6feXN3
 cBBgidVDybu79M5BenldVM1YXM6lfmpvtgNT7ghr1u6FbFElYQSyvYNYDVBF7NB2GFk5uLilAF7b
 9dC_5ACgGOVbFztpZQXpLOIhYwjJecuc.6c6q2udxw_wxHfy.0mm_Y4SvZxDKTIooW4iJq3Nm4Ap
 0EZEFOT9c.wwmAbHICcpOtV6tKAvc4VslSi.DZYouFvwtFtxYBKms6nIbpfdTUXEuy_ksmNenQzM
 AvmqFG8NFz7WXpj9QYIrFqNKOkl0ooIkdsUrD8.7M87COzl_yYWSW0XmOcGjApktTpWjgEblh1sl
 tSGn0cmu2kblgq5UNmGSWGeJpX2XZFF9g7RtLKwtqPJVRGkNSy4a289gTP1TaSP4H5ow3NL9i7Ow
 m_SgY7kd5WANv_Dy5ZC69GQWA0jdSOs4batssE_R8m.vUwsEJCtquuwvAGOPMvyediJIWkqdO0ud
 3W_gMesexuGMGfIhe.n81rWCvf7MOVQIVupdNXAZl4bBXEC4N9T9ryYrD.qiVfhXrekMaJAuzRKg
 O6kM23XAjsdjoKXoFeYWIVmPuSqtXG626s7D6TxvGDQeAUqSNpCu_UBS_PbINc0QYHdhqYudFqiu
 2afpg_UaHEB8TmkEbdjUaYxH51x93fxXttM.P1Ts5ckaMiwby55.LQhMVuTx5Y_PuK.H3iBiIBk1
 ieknjM0KQgbz3Uwkk0rCy_fnYW1nfXUHaB.ven2X1yCOpL5iiWjPJmxZ408E4tqFOAgbScrxe.im
 oYBNc1MQTjPqwExMCWf6hcnLDykqGzUsOHUxqn7wtYta3_8kund4HD6VJdw2DjOOWOhhJktaHIfu
 f1KV9BQmW7KUSd9rv2nHzuRRk5DUUlSBWX0zEfcckbbgDwgDON_HASWMLE3gXlBwFSRgfXvzNhcJ
 _FPUBtWzz4C1eEEjd8SrZq5g5OHKjNpxG5FOHTgQHyJ9FydZtDUtY0Z3g7Sesz.ajfMn6Y_sM3Nh
 Gt0QvUgltcJb3PKxm5t0zQvJc46eYvvUvkJccn92xqFqzGZ9F9WjQfe1_r.2S4FLfrSrHP2wpagR
 6Bqq6PaIZ1dUy0MMb_dh174iqvDGbet3.SgFAu86zCbyhsQSHAs0nfaULgNCFO37tyOjYSaawFME
 KvVMJ6N_5qJB_j2UhXvJuIdOB_wOzmeckNW1G1VlMUpkDkdg_urWaZJv.tPPKBBSC.SIUXmwgoCz
 cGNbAIGMdGfZrQ25VHYoHCsfH10uEZ57W7DNPVO6DWAEP30IlGx4nCm22XHoNrBLlkntwwOvkfoH
 vf2x4XXwVTqAgiKW9m_8xJudxzkMX3aW0vP8P.AKeOtQyw3RwOeLKZMjKhc5h_w--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 20 Nov 2020 20:39:38 +0000
Received: by smtp423.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID dfb5d2063e3f15266d7c7e78835f2c19;
          Fri, 20 Nov 2020 20:39:36 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v23 22/23] LSM: Add /proc attr entry for full LSM context
Date:   Fri, 20 Nov 2020 12:15:06 -0800
Message-Id: <20201120201507.11993-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201120201507.11993-1-casey@schaufler-ca.com>
References: <20201120201507.11993-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add an entry /proc/.../attr/context which displays the full
process security "context" in compound format:
        lsm1\0value\0lsm2\0value\0...
This entry is not writable.

A security module may decide that its policy does not allow
this information to be displayed. In this case none of the
information will be displayed.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-api@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
 Documentation/ABI/testing/procfs-attr-context | 14 ++++
 Documentation/security/lsm.rst                | 14 ++++
 fs/proc/base.c                                |  1 +
 include/linux/lsm_hooks.h                     |  6 ++
 security/apparmor/include/procattr.h          |  2 +-
 security/apparmor/lsm.c                       |  8 +-
 security/apparmor/procattr.c                  | 22 +++---
 security/security.c                           | 79 +++++++++++++++++++
 security/selinux/hooks.c                      |  2 +-
 security/smack/smack_lsm.c                    |  2 +-
 10 files changed, 135 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/ABI/testing/procfs-attr-context

diff --git a/Documentation/ABI/testing/procfs-attr-context b/Documentation/ABI/testing/procfs-attr-context
new file mode 100644
index 000000000000..4c0462136aac
--- /dev/null
+++ b/Documentation/ABI/testing/procfs-attr-context
@@ -0,0 +1,14 @@
+What:		/proc/*/attr/context
+Contact:	linux-security-module@vger.kernel.org,
+Description:	The current security information used by all Linux
+		security module (LSMs) that are active on the system. 
+		The details of permissions required to read from
+		this interface and hence obtain the security state
+		of the task identified is dependent on the LSMs that
+		are active on the system.
+		A process cannot write to this interface.
+		The data provided by this interface will have the form:
+			lsm_name\0lsm_data\0[lsm_name\0lsm_data\0]...
+		where lsm_name is the name of the LSM and the following
+		lsm_data is the process data for that LSM.
+Users:		LSM user-space
diff --git a/Documentation/security/lsm.rst b/Documentation/security/lsm.rst
index b77b4a540391..070225ae6ceb 100644
--- a/Documentation/security/lsm.rst
+++ b/Documentation/security/lsm.rst
@@ -143,3 +143,17 @@ separated list of the active security modules.
 The file ``/proc/pid/attr/interface_lsm`` contains the name of the security
 module for which the ``/proc/pid/attr/current`` interface will
 apply. This interface can be written to.
+
+The infrastructure does provide an interface for the special
+case where multiple security modules provide a process context.
+This is provided in compound context format.
+
+-  `lsm\0value\0lsm\0value\0`
+
+The `lsm` and `value` fields are NUL-terminated bytestrings.
+Each field may contain whitespace or non-printable characters.
+The NUL bytes are included in the size of a compound context.
+The context ``Bell\0Secret\0Biba\0Loose\0`` has a size of 23.
+
+The file ``/proc/pid/attr/context`` provides the security
+context of the identified process.
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 214a0503589d..e8b079d15194 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2809,6 +2809,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
 	ATTR(NULL, "interface_lsm",	0666),
+	ATTR(NULL, "context",		0444),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index e19393b2b8b7..32a266d22c0c 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1372,6 +1372,12 @@
  *	@pages contains the number of pages.
  *	Return 0 if permission is granted.
  *
+ * @getprocattr:
+ *	Provide the named process attribute for display in special files in
+ *	the /proc/.../attr directory.  Attribute naming and the data displayed
+ *	is at the discretion of the security modules.  The exception is the
+ *	"context" attribute, which will contain the security context of the
+ *	task as a nul terminated text string without trailing whitespace.
  * @ismaclabel:
  *	Check if the extended attribute specified by @name
  *	represents a MAC label. Returns 1 if name is a MAC
diff --git a/security/apparmor/include/procattr.h b/security/apparmor/include/procattr.h
index 31689437e0e1..03dbfdb2f2c0 100644
--- a/security/apparmor/include/procattr.h
+++ b/security/apparmor/include/procattr.h
@@ -11,7 +11,7 @@
 #ifndef __AA_PROCATTR_H
 #define __AA_PROCATTR_H
 
-int aa_getprocattr(struct aa_label *label, char **string);
+int aa_getprocattr(struct aa_label *label, char **string, bool newline);
 int aa_setprocattr_changehat(char *args, size_t size, int flags);
 
 #endif /* __AA_PROCATTR_H */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 0ef5d0b2dbdb..36be7bdc917b 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -593,6 +593,7 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
 	const struct cred *cred = get_task_cred(task);
 	struct aa_task_ctx *ctx = task_ctx(current);
 	struct aa_label *label = NULL;
+	bool newline = true;
 
 	if (strcmp(name, "current") == 0)
 		label = aa_get_newest_label(cred_label(cred));
@@ -600,11 +601,14 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
 		label = aa_get_newest_label(ctx->previous);
 	else if (strcmp(name, "exec") == 0 && ctx->onexec)
 		label = aa_get_newest_label(ctx->onexec);
-	else
+	else if (strcmp(name, "context") == 0) {
+		label = aa_get_newest_label(cred_label(cred));
+		newline = false;
+	} else
 		error = -EINVAL;
 
 	if (label)
-		error = aa_getprocattr(label, value);
+		error = aa_getprocattr(label, value, newline);
 
 	aa_put_label(label);
 	put_cred(cred);
diff --git a/security/apparmor/procattr.c b/security/apparmor/procattr.c
index c929bf4a3df1..be3b083d9b74 100644
--- a/security/apparmor/procattr.c
+++ b/security/apparmor/procattr.c
@@ -20,6 +20,7 @@
  * aa_getprocattr - Return the profile information for @profile
  * @profile: the profile to print profile info about  (NOT NULL)
  * @string: Returns - string containing the profile info (NOT NULL)
+ * @newline: Should a newline be added to @string.
  *
  * Returns: length of @string on success else error on failure
  *
@@ -30,20 +31,21 @@
  *
  * Returns: size of string placed in @string else error code on failure
  */
-int aa_getprocattr(struct aa_label *label, char **string)
+int aa_getprocattr(struct aa_label *label, char **string, bool newline)
 {
 	struct aa_ns *ns = labels_ns(label);
 	struct aa_ns *current_ns = aa_get_current_ns();
+	int flags = FLAG_VIEW_SUBNS | FLAG_HIDDEN_UNCONFINED;
 	int len;
 
 	if (!aa_ns_visible(current_ns, ns, true)) {
 		aa_put_ns(current_ns);
 		return -EACCES;
 	}
+	if (newline)
+		flags |= FLAG_SHOW_MODE;
 
-	len = aa_label_snxprint(NULL, 0, current_ns, label,
-				FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
-				FLAG_HIDDEN_UNCONFINED);
+	len = aa_label_snxprint(NULL, 0, current_ns, label, flags);
 	AA_BUG(len < 0);
 
 	*string = kmalloc(len + 2, GFP_KERNEL);
@@ -52,19 +54,19 @@ int aa_getprocattr(struct aa_label *label, char **string)
 		return -ENOMEM;
 	}
 
-	len = aa_label_snxprint(*string, len + 2, current_ns, label,
-				FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
-				FLAG_HIDDEN_UNCONFINED);
+	len = aa_label_snxprint(*string, len + 2, current_ns, label, flags);
 	if (len < 0) {
 		aa_put_ns(current_ns);
 		return len;
 	}
 
-	(*string)[len] = '\n';
-	(*string)[len + 1] = 0;
+	if (newline) {
+		(*string)[len] = '\n';
+		(*string)[++len] = 0;
+	}
 
 	aa_put_ns(current_ns);
-	return len + 1;
+	return len;
 }
 
 /**
diff --git a/security/security.c b/security/security.c
index cef9c20ce0aa..e33c8ccc06a0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -757,6 +757,57 @@ static void __init lsm_early_task(struct task_struct *task)
 		panic("%s: Early task alloc failed.\n", __func__);
 }
 
+/**
+ * append_ctx - append a lsm/context pair to a compound context
+ * @ctx: the existing compound context
+ * @ctxlen: size of the old context, including terminating nul byte
+ * @lsm: new lsm name, nul terminated
+ * @new: new context, possibly nul terminated
+ * @newlen: maximum size of @new
+ *
+ * replace @ctx with a new compound context, appending @newlsm and @new
+ * to @ctx. On exit the new data replaces the old, which is freed.
+ * @ctxlen is set to the new size, which includes a trailing nul byte.
+ *
+ * Returns 0 on success, -ENOMEM if no memory is available.
+ */
+static int append_ctx(char **ctx, int *ctxlen, const char *lsm, char *new,
+		      int newlen)
+{
+	char *final;
+	size_t llen;
+	size_t nlen;
+	size_t flen;
+
+	llen = strlen(lsm) + 1;
+	/*
+	 * A security module may or may not provide a trailing nul on
+	 * when returning a security context. There is no definition
+	 * of which it should be, and there are modules that do it
+	 * each way.
+	 */
+	nlen = strnlen(new, newlen);
+
+	flen = *ctxlen + llen + nlen + 1;
+	final = kzalloc(flen, GFP_KERNEL);
+
+	if (final == NULL)
+		return -ENOMEM;
+
+	if (*ctxlen)
+		memcpy(final, *ctx, *ctxlen);
+
+	memcpy(final + *ctxlen, lsm, llen);
+	memcpy(final + *ctxlen + llen, new, nlen);
+
+	kfree(*ctx);
+
+	*ctx = final;
+	*ctxlen = flen;
+
+	return 0;
+}
+
 /*
  * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
  * can be accessed with:
@@ -2142,6 +2193,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	char *final = NULL;
+	char *cp;
+	int rc = 0;
+	int finallen = 0;
 	int ilsm = lsm_task_ilsm(current);
 	int slot = 0;
 
@@ -2169,6 +2224,30 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 		return -ENOMEM;
 	}
 
+	if (!strcmp(name, "context")) {
+		hlist_for_each_entry(hp, &security_hook_heads.getprocattr,
+				     list) {
+			rc = hp->hook.getprocattr(p, "context", &cp);
+			if (rc == -EINVAL)
+				continue;
+			if (rc < 0) {
+				kfree(final);
+				return rc;
+			}
+			rc = append_ctx(&final, &finallen, hp->lsmid->lsm,
+					cp, rc);
+			kfree(cp);
+			if (rc < 0) {
+				kfree(final);
+				return rc;
+			}
+		}
+		if (final == NULL)
+			return -EINVAL;
+		*value = final;
+		return finallen;
+	}
+
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
 		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c670eb0a9515..5fd738c73449 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6292,7 +6292,7 @@ static int selinux_getprocattr(struct task_struct *p,
 			goto bad;
 	}
 
-	if (!strcmp(name, "current"))
+	if (!strcmp(name, "current") || !strcmp(name, "context"))
 		sid = __tsec->sid;
 	else if (!strcmp(name, "prev"))
 		sid = __tsec->osid;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 06629441b663..8da72353e94e 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3478,7 +3478,7 @@ static int smack_getprocattr(struct task_struct *p, char *name, char **value)
 	char *cp;
 	int slen;
 
-	if (strcmp(name, "current") != 0)
+	if (strcmp(name, "current") != 0 && strcmp(name, "context") != 0)
 		return -EINVAL;
 
 	cp = kstrdup(skp->smk_known, GFP_KERNEL);
-- 
2.24.1

