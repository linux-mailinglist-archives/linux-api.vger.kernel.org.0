Return-Path: <linux-api+bounces-3341-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13988A44AC6
	for <lists+linux-api@lfdr.de>; Tue, 25 Feb 2025 19:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E631B3A4634
	for <lists+linux-api@lfdr.de>; Tue, 25 Feb 2025 18:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABEF1A01CC;
	Tue, 25 Feb 2025 18:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="pcefXTgq"
X-Original-To: linux-api@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B49118E34A;
	Tue, 25 Feb 2025 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740508572; cv=none; b=mTlBfRhzXrYol7kUvdfKIyDGZ0sGHl0doYyZUrEc/tlCpaWzMk+ArYYetxTCsAXLrdIuzmF/0F2Nt8E0heWc1gMA0+RKQ3thkq6eYlAXCzEEHpSOce8krUn/lyyR4EriBo0gDhnzjIuxhrnnMRsfCddgae7sC7fZ8Y4EAbjhFX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740508572; c=relaxed/simple;
	bh=FBm4oUcbXFtTEDZ7FDmVHPI2qkkxttQ4wonvfbj3Ujk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WO4wFbxCmlmVG1HHUBdmGnc3qjAQhrZ4kZTKG8hm/aWX5jjyqq+UT1fKD57b82VATWEkVJQIqlY1ihcjhiSu8lrDMmwSF1V0TkM1eGbPU/+TwFltVPxZ16eJ4JXy7edFIRTeZDtk1WqM1drMzGbPK4qR/5SChT2/5bp22GaFQww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=pcefXTgq; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=sft+T4Fu+5ncTC4aZbVc33XxpCTJMgxMtgqsT/dZoSI=; b=pcefXTgqcJecgqrtf3kiYdmEjv
	0hDns2PRtXTxOs5U7Mho/c/b58VYp7GSWDz4hVMXfUkpQTqnhG/iNh2pcPTE12V8uPMrxJbj+ISNO
	PQPabcnjKbPTsWQ/k5phEiClW2r2+HNqTapX+Akfz6vBuSksLckiVW7OOTMoVqPxlkGiUtjWwtg0o
	dg7TECgMm7lo0mzDDWw4+FffDnYjhMu5AbB2hMDiVeSyWwH/B2QAvNry2adz2dQQmuFVTHTPfJZ/X
	knrbgSaIeJMRNkEunPumciel9nFGjJaYyu7wsgIgiRRZXyP2awJ+xXyGd22CsScXIMVMRPI3SA9UW
	9kah/TxQ==;
Received: from [191.204.194.148] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tmzmW-000WtH-7o; Tue, 25 Feb 2025 19:35:54 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Arnd Bergmann <arnd@arndb.de>,
	sonicadvance1@gmail.com
Cc: linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	linux-api@vger.kernel.org,
	Vinicius Peixoto <vpeixoto@lkcamp.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v4 4/5] futex: Remove the limit of elements for sys_set_robust_list2 lists
Date: Tue, 25 Feb 2025 15:35:30 -0300
Message-ID: <20250225183531.682556-5-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225183531.682556-1-andrealmeid@igalia.com>
References: <20250225183531.682556-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove the limit of ROBUST_LIST_LIMIT elements that a robust list can
have, for the ones created with the new interface. This is done by
overwritten the list as it's proceeded in a way that we avoid circular
lists.

For the old interface, we keep the limited behavior to avoid changing
the API.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 kernel/futex/core.c | 50 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 07a7e5e9bc8d..bfd4443208ea 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -777,7 +777,8 @@ static inline int fetch_robust_entry(struct robust_list __user **entry,
  * We silently return on any sign of list-walking problem.
  */
 static void exit_robust_list64(struct task_struct *curr,
-			       struct robust_list_head __user *head)
+			       struct robust_list_head __user *head,
+			       bool destroyable)
 {
 	struct robust_list __user *entry, *next_entry, *pending;
 	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
@@ -821,13 +822,17 @@ static void exit_robust_list64(struct task_struct *curr,
 		}
 		if (rc)
 			return;
-		entry = next_entry;
-		pi = next_pi;
+
 		/*
 		 * Avoid excessively long or circular lists:
 		 */
-		if (!--limit)
+		if (!destroyable && !--limit)
 			break;
+		else
+			put_user(&head->list, &entry->next);
+
+		entry = next_entry;
+		pi = next_pi;
 
 		cond_resched();
 	}
@@ -839,7 +844,8 @@ static void exit_robust_list64(struct task_struct *curr,
 }
 #else
 static void exit_robust_list64(struct task_struct *curr,
-			      struct robust_list_head __user *head)
+			      struct robust_list_head __user *head,
+			      bool destroyable)
 {
 	pr_warn("32bit kernel should not allow ROBUST_LIST_64BIT");
 }
@@ -877,7 +883,8 @@ fetch_robust_entry32(u32 *uentry, struct robust_list __user **entry,
  * We silently return on any sign of list-walking problem.
  */
 static void exit_robust_list32(struct task_struct *curr,
-			       struct robust_list_head32 __user *head)
+			       struct robust_list_head32 __user *head,
+			       bool destroyable)
 {
 	struct robust_list __user *entry, *next_entry, *pending;
 	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
@@ -926,14 +933,17 @@ static void exit_robust_list32(struct task_struct *curr,
 		}
 		if (rc)
 			return;
-		uentry = next_uentry;
-		entry = next_entry;
-		pi = next_pi;
 		/*
 		 * Avoid excessively long or circular lists:
 		 */
-		if (!--limit)
+		if (!destroyable && !--limit)
 			break;
+		else
+			put_user((struct robust_list __user *) &head->list, &entry->next);
+
+		uentry = next_uentry;
+		entry = next_entry;
+		pi = next_pi;
 
 		cond_resched();
 	}
@@ -1087,26 +1097,38 @@ static void exit_pi_state_list(struct task_struct *curr)
 static inline void exit_pi_state_list(struct task_struct *curr) { }
 #endif
 
+/*
+ * futex_cleanup - After the task exists, process the robust lists
+ *
+ * Walk through the linked list, parsing robust lists and freeing the
+ * allocated lists. Lists created with the set_robust_list2 don't have a limit
+ * for sizing and can be destroyed while we walk on it to avoid circular list.
+ */
 static void futex_cleanup(struct task_struct *tsk)
 {
 	struct robust_list2_entry *curr, *n;
 	struct list_head *list2 = &tsk->robust_list2;
+	bool destroyable = true;
+	int i = 0;
 
 	/*
-	 * Walk through the linked list, parsing robust lists and freeing the
-	 * allocated lists
 	 */
 	if (unlikely(!list_empty(list2))) {
 		list_for_each_entry_safe(curr, n, list2, list) {
+			destroyable = true;
+			if (tsk->robust_list_index == i)
+				destroyable = false;
+
 			if (curr->head != NULL) {
 				if (curr->list_type == ROBUST_LIST_64BIT)
-					exit_robust_list64(tsk, curr->head);
+					exit_robust_list64(tsk, curr->head, destroyable);
 				else if (curr->list_type == ROBUST_LIST_32BIT)
-					exit_robust_list32(tsk, curr->head);
+					exit_robust_list32(tsk, curr->head, destroyable);
 				curr->head = NULL;
 			}
 			list_del_init(&curr->list);
 			kfree(curr);
+			i++;
 		}
 	}
 
-- 
2.48.1


