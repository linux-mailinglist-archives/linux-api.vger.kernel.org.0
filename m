Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEC5423D53
	for <lists+linux-api@lfdr.de>; Wed,  6 Oct 2021 13:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238201AbhJFLwe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 6 Oct 2021 07:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238124AbhJFLwe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 6 Oct 2021 07:52:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43724C061749;
        Wed,  6 Oct 2021 04:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=uOB6uaGNFZT76GA5ScYxNmwIB9Oa1nEIp3TlgjOvyrg=; b=QoUas8fFCbSgdE+QVVYKaiUfYF
        C0lHBbxvQA7WMFELJMzmxsXqCMvFxQgdNXUts49FQ1kwWnm7I73Vfx8/on5oNFByzgYR2PVO2UxJU
        Ph98FQRUX8ERud4rWhPN+bzf5VsJj1OFNpLe1jtUQeYW3oiTGIv4Kk4J8TsjPOQ4FP1J8wkmv4Dbr
        3B2ALj3uAcs1WZZ+Bc+H+fk7u3tsA6h6IvV3aEXeU1IW8G0v0DEdl0B6oFIW/6ARkyzDBtS0VrMP1
        B4ZGZWVzovVeKS4PQXtyhZ2GTC6YYJ2O5tEdVDBW754AsDsBxPm1K4AkU1AfQGZSVnlJPX10RawKZ
        5QwmQUHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mY5RH-008Gls-Vc; Wed, 06 Oct 2021 11:50:24 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0AD5998623A; Wed,  6 Oct 2021 13:50:23 +0200 (CEST)
Date:   Wed, 6 Oct 2021 13:50:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, krisman@collabora.com,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        mtk.manpages@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 16/22] futex: Implement sys_futex_waitv()
Message-ID: <20211006115022.GH174703@worktop.programming.kicks-ass.net>
References: <20210923171111.300673-1-andrealmeid@collabora.com>
 <20210923171111.300673-17-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210923171111.300673-17-andrealmeid@collabora.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 23, 2021 at 02:11:05PM -0300, André Almeida wrote:
> Returns the array index of one of the awakened futexes. There’s no given
> information of how many were awakened, or any particular attribute of it
> (if it’s the first awakened, if it is of the smaller index...).

As per some native speakers on IRC, awaken isn't the right word. I've
changed it like the below.


--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -252,9 +252,9 @@ static int futex_parse_waitv(struct fute
  * needed. Flags for private futexes, sizes, etc. should be used on the
  * individual flags of each waiter.
  *
- * Returns the array index of one of the awaken futexes. There's no given
- * information of how many were awakened, or any particular attribute of it (if
- * it's the first awakened, if it is of the smaller index...).
+ * Returns the array index of one of the woken futexes. There's no given
+ * information of how many were woken, or any particular attribute of it (if
+ * it's the first woken, if it is of the smaller index...).
  */
 
 SYSCALL_DEFINE5(futex_waitv, struct futex_waitv __user *, waiters,
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -384,7 +384,7 @@ static int unqueue_multiple(struct futex
  * futex_wait_multiple_setup - Prepare to wait and enqueue multiple futexes
  * @vs:		The futex list to wait on
  * @count:	The size of the list
- * @awaken:	Index of the last awoken futex, if any. Used to notify the
+ * @woken:	Index of the last woken futex, if any. Used to notify the
  *		caller that it can return this index to userspace (return parameter)
  *
  * Prepare multiple futexes in a single step and enqueue them. This may fail if
@@ -392,11 +392,11 @@ static int unqueue_multiple(struct futex
  * task is ready to interruptible sleep.
  *
  * Return:
- *  -  1 - One of the futexes was awaken by another thread
+ *  -  1 - One of the futexes was woken by another thread
  *  -  0 - Success
  *  - <0 - -EFAULT, -EWOULDBLOCK or -EINVAL
  */
-static int futex_wait_multiple_setup(struct futex_vector *vs, int count, int *awaken)
+static int futex_wait_multiple_setup(struct futex_vector *vs, int count, int *woken)
 {
 	struct futex_hash_bucket *hb;
 	bool retry = false;
@@ -405,10 +405,10 @@ static int futex_wait_multiple_setup(str
 
 	/*
 	 * Enqueuing multiple futexes is tricky, because we need to enqueue
-	 * each futex in the list before dealing with the next one to avoid
+	 * each futex on the list before dealing with the next one to avoid
 	 * deadlocking on the hash bucket. But, before enqueuing, we need to
 	 * make sure that current->state is TASK_INTERRUPTIBLE, so we don't
-	 * absorb any awake events, which cannot be done before the
+	 * loose any wake events, which cannot be done before the
 	 * get_futex_key of the next key, because it calls get_user_pages,
 	 * which can sleep. Thus, we fetch the list of futexes keys in two
 	 * steps, by first pinning all the memory keys in the futex key, and
@@ -455,11 +455,11 @@ static int futex_wait_multiple_setup(str
 
 		/*
 		 * Even if something went wrong, if we find out that a futex
-		 * was awaken, we don't return error and return this index to
+		 * was woken, we don't return error and return this index to
 		 * userspace
 		 */
-		*awaken = unqueue_multiple(vs, i);
-		if (*awaken >= 0)
+		*woken = unqueue_multiple(vs, i);
+		if (*woken >= 0)
 			return 1;
 
 		if (ret) {
@@ -491,7 +491,7 @@ static int futex_wait_multiple_setup(str
  * @to:    Timeout
  *
  * Sleep if and only if the timeout hasn't expired and no futex on the list has
- * been awaken.
+ * been woken.
  */
 static void futex_sleep_multiple(struct futex_vector *vs, unsigned int count,
 				 struct hrtimer_sleeper *to)
@@ -533,7 +533,7 @@ int futex_wait_multiple(struct futex_vec
 		ret = futex_wait_multiple_setup(vs, count, &hint);
 		if (ret) {
 			if (ret > 0) {
-				/* A futex was awaken during setup */
+				/* A futex was woken during setup */
 				ret = hint;
 			}
 			return ret;
