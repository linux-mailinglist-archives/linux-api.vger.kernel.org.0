Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23D41A387E
	for <lists+linux-api@lfdr.de>; Fri, 30 Aug 2019 15:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfH3N6x (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 30 Aug 2019 09:58:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39070 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727751AbfH3N6x (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 30 Aug 2019 09:58:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 785ED8D5BA6;
        Fri, 30 Aug 2019 13:58:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D771660F80;
        Fri, 30 Aug 2019 13:58:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 11/11] smack: Implement the watch_key and post_notification
 hooks [untested] [ver #7]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>, dhowells@redhat.com,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 30 Aug 2019 14:58:49 +0100
Message-ID: <156717352917.2204.17206219813087348132.stgit@warthog.procyon.org.uk>
In-Reply-To: <156717343223.2204.15875738850129174524.stgit@warthog.procyon.org.uk>
References: <156717343223.2204.15875738850129174524.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Fri, 30 Aug 2019 13:58:52 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Implement the watch_key security hook in Smack to make sure that a key
grants the caller Read permission in order to set a watch on a key.

Also implement the post_notification security hook to make sure that the
notification source is granted Write permission by the watch queue.

For the moment, the watch_devices security hook is left unimplemented as
it's not obvious what the object should be since the queue is global and
didn't previously exist.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/lsm_audit.h  |    1 +
 security/smack/smack_lsm.c |   82 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index 915330abf6e5..734d67889826 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -74,6 +74,7 @@ struct common_audit_data {
 #define LSM_AUDIT_DATA_FILE	12
 #define LSM_AUDIT_DATA_IBPKEY	13
 #define LSM_AUDIT_DATA_IBENDPORT 14
+#define LSM_AUDIT_DATA_NOTIFICATION 15
 	union 	{
 		struct path path;
 		struct dentry *dentry;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 4c5e5a438f8b..1c2a908c6446 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4274,7 +4274,7 @@ static int smack_key_permission(key_ref_t key_ref,
 	if (tkp == NULL)
 		return -EACCES;
 
-	if (smack_privileged_cred(CAP_MAC_OVERRIDE, cred))
+	if (smack_privileged(CAP_MAC_OVERRIDE))
 		return 0;
 
 #ifdef CONFIG_AUDIT
@@ -4320,8 +4320,81 @@ static int smack_key_getsecurity(struct key *key, char **_buffer)
 	return length;
 }
 
+
+#ifdef CONFIG_KEY_NOTIFICATIONS
+/**
+ * smack_watch_key - Smack access to watch a key for notifications.
+ * @key: The key to be watched
+ *
+ * Return 0 if the @watch->cred has permission to read from the key object and
+ * an error otherwise.
+ */
+static int smack_watch_key(struct key *key)
+{
+	struct smk_audit_info ad;
+	struct smack_known *tkp = smk_of_current();
+	int rc;
+
+	if (key == NULL)
+		return -EINVAL;
+	/*
+	 * If the key hasn't been initialized give it access so that
+	 * it may do so.
+	 */
+	if (key->security == NULL)
+		return 0;
+	/*
+	 * This should not occur
+	 */
+	if (tkp == NULL)
+		return -EACCES;
+
+	if (smack_privileged_cred(CAP_MAC_OVERRIDE, current_cred()))
+		return 0;
+
+#ifdef CONFIG_AUDIT
+	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_KEY);
+	ad.a.u.key_struct.key = key->serial;
+	ad.a.u.key_struct.key_desc = key->description;
+#endif
+	rc = smk_access(tkp, key->security, MAY_READ, &ad);
+	rc = smk_bu_note("key watch", tkp, key->security, MAY_READ, rc);
+	return rc;
+}
+#endif /* CONFIG_KEY_NOTIFICATIONS */
 #endif /* CONFIG_KEYS */
 
+#ifdef CONFIG_WATCH_QUEUE
+/**
+ * smack_post_notification - Smack access to post a notification to a queue
+ * @w_cred: The credentials of the watcher.
+ * @cred: The credentials of the event source (may be NULL).
+ * @n: The notification message to be posted.
+ */
+static int smack_post_notification(const struct cred *w_cred,
+				   const struct cred *cred,
+				   struct watch_notification *n)
+{
+	struct smk_audit_info ad;
+	struct smack_known *subj, *obj;
+	int rc;
+
+	/* Always let maintenance notifications through. */
+	if (n->type == WATCH_TYPE_META)
+		return 0;
+
+	if (!cred)
+		return 0;
+	subj = smk_of_task(smack_cred(cred));
+	obj = smk_of_task(smack_cred(w_cred));
+
+	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_NOTIFICATION);
+	rc = smk_access(subj, obj, MAY_WRITE, &ad);
+	rc = smk_bu_note("notification", subj, obj, MAY_WRITE, rc);
+	return rc;
+}
+#endif /* CONFIG_WATCH_QUEUE */
+
 /*
  * Smack Audit hooks
  *
@@ -4710,8 +4783,15 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(key_free, smack_key_free),
 	LSM_HOOK_INIT(key_permission, smack_key_permission),
 	LSM_HOOK_INIT(key_getsecurity, smack_key_getsecurity),
+#ifdef CONFIG_KEY_NOTIFICATIONS
+	LSM_HOOK_INIT(watch_key, smack_watch_key),
+#endif
 #endif /* CONFIG_KEYS */
 
+#ifdef CONFIG_WATCH_QUEUE
+	LSM_HOOK_INIT(post_notification, smack_post_notification),
+#endif
+
  /* Audit hooks */
 #ifdef CONFIG_AUDIT
 	LSM_HOOK_INIT(audit_rule_init, smack_audit_rule_init),

