Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA947292F1F
	for <lists+linux-api@lfdr.de>; Mon, 19 Oct 2020 22:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgJSUHN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 19 Oct 2020 16:07:13 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:50132 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgJSUHM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Oct 2020 16:07:12 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kUbQf-004jiG-DV; Mon, 19 Oct 2020 14:06:49 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kUbQe-0001VE-Ec; Mon, 19 Oct 2020 14:06:49 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     "Enrico Weigelt\, metux IT consult" <lkml@metux.net>,
        containers@lists.linux-foundation.org,
        Alexander Mihalicyn <alexander@mihalicyn.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Joseph Christopher Sible <jcsible@cert.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@amacapital.net>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Wat Lim <watl@google.com>, Mrunal Patel <mpatel@redhat.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, <linux-api@vger.kernel.org>
References: <20200830143959.rhosiunyz5yqbr35@wittgenstein>
        <cb6c6f1a-89ee-1762-3eec-4f69bd7739b1@metux.net>
        <874kmsdcdx.fsf@x220.int.ebiederm.org>
        <20201018102026.34jtxfheygowgejp@wittgenstein>
        <87h7qradml.fsf_-_@x220.int.ebiederm.org>
        <87o8kz840w.fsf@x220.int.ebiederm.org>
Date:   Mon, 19 Oct 2020 15:07:02 -0500
In-Reply-To: <87o8kz840w.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Sun, 18 Oct 2020 19:15:27 -0500")
Message-ID: <878sc27zfd.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kUbQe-0001VE-Ec;;;mid=<878sc27zfd.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+/iJvwJfeGhmPSjNCGhZOTGA5b3+idEOE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,XMSubLong,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 616 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.8 (0.6%), b_tie_ro: 2.6 (0.4%), parse: 1.01
        (0.2%), extract_message_metadata: 11 (1.8%), get_uri_detail_list: 2.8
        (0.5%), tests_pri_-1000: 11 (1.8%), tests_pri_-950: 1.00 (0.2%),
        tests_pri_-900: 0.88 (0.1%), tests_pri_-90: 103 (16.8%), check_bayes:
        102 (16.6%), b_tokenize: 12 (1.9%), b_tok_get_all: 11 (1.7%),
        b_comp_prob: 2.1 (0.3%), b_tok_touch_all: 75 (12.2%), b_finish: 0.62
        (0.1%), tests_pri_0: 474 (77.0%), check_dkim_signature: 0.48 (0.1%),
        check_dkim_adsp: 2.2 (0.4%), poll_dns_idle: 0.81 (0.1%), tests_pri_10:
        1.71 (0.3%), tests_pri_500: 6 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: [RFC][PATCH] userns: Limit process in a user namespace to what the creator is allowed
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


Ordinary unix permissions and posix acls have the ability to
expression that processes show uid or gid match have fewer permissions
than processes without matches that use the other permissions.

The fact a root user in a user namespace can call setgroups and setuid
allows these restrictive permissions to be avoided.  To limit the problems
this can cause populationg the the set of uids that can be switched to,
and the set of gids that can be switched to is an operation that requires
priviliege outside of the user namespace.

This restriction is currently being reexamined as it appears that
there is a way to implement uids and gids that do not map outside of
the user namespace.  Such uids and gids would not require privilege
from outside of the usernamespace to use.  So it becomes important to
find a way to allow calling setuid and setgroups in a user namespace
without allowing processes in a user namespace to do more than the
creator of the user namespace.

To that end capture the groups set with setgroups of the creator of a
user_namespace.  Update the affected permission checks to notice when
something is being allowed with other permissions and only allow the
operation if the creator of the user namespace does not have a user or
group match that would disallow the operation.

The goal is to ensure that creating a user namespace and allowing
the user namespace root to setuid and setgroups does not result
in being permitted to do more than before the user namespace was
created, while still supporting explicitly specified users and
groups to have fewer permissions.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

So far only generic_permission is covered, but I think this demonstrates
that the goal is achievable.  Preserving negative acls while allowing
setuid and setgroups.

 fs/namei.c                     |  7 +++++
 fs/posix_acl.c                 | 51 ++++++++++++++++++++++++++++++++++
 include/linux/user_namespace.h | 16 +++++++++++
 kernel/user_namespace.c        | 29 +++++++++++++++++++
 4 files changed, 103 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index e99e2a9da0f7..ca06bd81d4e4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -322,6 +322,13 @@ static int acl_permission_check(struct inode *inode, int mask)
 	if (mask & (mode ^ (mode >> 3))) {
 		if (in_group_p(inode->i_gid))
 			mode >>= 3;
+		/*
+		 * Only allow the intersection of what the creator of
+		 * the user namespace is allowed and what everyone is
+		 * allowed.
+		 */
+		else if (userns_in_group_p(inode->i_sb->s_user_ns, inode->i_gid))
+			mode &= (mode >> 3);
 	}
 
 	/* Bits in 'mode' clear that we require? */
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 95882b3f5f62..525803f8f70c 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -340,6 +340,53 @@ posix_acl_from_mode(umode_t mode, gfp_t flags)
 }
 EXPORT_SYMBOL(posix_acl_from_mode);
 
+static bool userns_creator_allowed(struct inode *inode,
+				   const struct posix_acl *acl, int want)
+{
+	/* Don't allow access the creator of the user namespace does not have */
+	struct user_namespace *ns = inode->i_sb->s_user_ns;
+	const struct posix_acl_entry *pa, *pe;
+	unsigned short min_perm;
+	bool found = false;
+
+	min_perm = MAY_READ | MAY_WRITE | MAY_EXEC;
+	FOREACH_ACL_ENTRY(pa, acl, pe) {
+                switch(pa->e_tag) {
+                        case ACL_USER_OBJ:
+				/* No need to limit the owner of a file */
+                                break;
+                        case ACL_USER:
+				if (is_userns_creator(ns, pa->e_uid)) {
+					found = true;
+					min_perm &= pa->e_perm;
+				}
+				break;
+                        case ACL_GROUP_OBJ:
+				if (userns_in_group_p(ns, inode->i_gid)) {
+					found = true;
+					min_perm &= pa->e_perm;
+				}
+				break;
+                        case ACL_GROUP:
+				if (userns_in_group_p(ns, pa->e_gid)) {
+					found = true;
+					min_perm &= pa->e_perm;
+				}
+                                break;
+                        case ACL_MASK:
+				if (found)
+					min_perm &= pa->e_perm;
+                                break;
+                        case ACL_OTHER:
+				if (found &&
+				    ((pa->e_perm & want & min_perm) != want))
+					return false;
+				return true;
+                }
+        }
+	return false;
+}
+
 /*
  * Return 0 if current is granted want access to the inode
  * by the acl. Returns -E... otherwise.
@@ -382,6 +429,10 @@ posix_acl_permission(struct inode *inode, const struct posix_acl *acl, int want)
                         case ACL_OTHER:
 				if (found)
 					return -EACCES;
+				else if ((current_user_ns() != inode->i_sb->s_user_ns) &&
+					 ((pa->e_perm & want) == want) &&
+					 userns_creator_allowed(inode, acl, want))
+					return 0;
 				else
 					goto check_perm;
 			default:
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 6ef1c7109fc4..b4bcb49bed7a 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -62,6 +62,7 @@ struct user_namespace {
 	int			level;
 	kuid_t			owner;
 	kgid_t			group;
+	struct group_info 	*groups;
 	struct ns_common	ns;
 	unsigned long		flags;
 
@@ -137,6 +138,10 @@ extern bool in_userns(const struct user_namespace *ancestor,
 		       const struct user_namespace *child);
 extern bool current_in_userns(const struct user_namespace *target_ns);
 struct ns_common *ns_get_owner(struct ns_common *ns);
+
+bool is_userns_creator(struct user_namespace *ns, kuid_t uid);
+bool userns_in_group_p(struct user_namespace *ns, kgid_t group);
+
 #else
 
 static inline struct user_namespace *get_user_ns(struct user_namespace *ns)
@@ -181,6 +186,17 @@ static inline struct ns_common *ns_get_owner(struct ns_common *ns)
 {
 	return ERR_PTR(-EPERM);
 }
+
+static inline bool is_userns_creator(struct user_namespace *ns, kuid_t uid)
+{
+	return false;
+}
+
+static inline bool userns_in_group_p(struct user_namespace *ns, kgid_t group)
+{
+	return false;
+}
+
 #endif
 
 #endif /* _LINUX_USER_H */
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 87804e0371fe..8a4949a32e36 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -117,6 +117,7 @@ int create_user_ns(struct cred *new)
 	ns->level = parent_ns->level + 1;
 	ns->owner = owner;
 	ns->group = group;
+	ns->groups = get_group_info(new->group_info);
 	INIT_WORK(&ns->work, free_user_ns);
 	for (i = 0; i < UCOUNT_COUNTS; i++) {
 		ns->ucount_max[i] = INT_MAX;
@@ -143,6 +144,7 @@ int create_user_ns(struct cred *new)
 	key_put(ns->persistent_keyring_register);
 #endif
 	ns_free_inum(&ns->ns);
+	put_group_info(ns->groups);
 fail_free:
 	kmem_cache_free(user_ns_cachep, ns);
 fail_dec:
@@ -194,6 +196,7 @@ static void free_user_ns(struct work_struct *work)
 		retire_userns_sysctls(ns);
 		key_free_user_ns(ns);
 		ns_free_inum(&ns->ns);
+		put_group_info(ns->groups);
 		kmem_cache_free(user_ns_cachep, ns);
 		dec_user_namespaces(ucounts);
 		ns = parent;
@@ -1317,6 +1320,32 @@ const struct proc_ns_operations userns_operations = {
 	.get_parent	= ns_get_owner,
 };
 
+bool is_userns_creator(struct user_namespace *target_ns, kuid_t uid)
+{
+	struct user_namespace *user_ns = current_user_ns();
+
+	for (user_ns = current_user_ns();
+	     (user_ns != target_ns) && user_ns;
+	     user_ns = user_ns->parent) {
+		if (uid_eq(uid, user_ns->owner))
+			return true;
+	}
+	return false;
+}
+
+bool userns_in_group_p(struct user_namespace *target_ns, kgid_t group)
+{
+	struct user_namespace *user_ns;
+
+	for (user_ns = current_user_ns();
+	     (user_ns != target_ns) && user_ns;
+	     user_ns = user_ns->parent) {
+		if (groups_search(user_ns->groups, group))
+			return true;
+	}
+	return false;
+}
+
 static __init int user_namespaces_init(void)
 {
 	user_ns_cachep = KMEM_CACHE(user_namespace, SLAB_PANIC);
-- 
2.20.1


