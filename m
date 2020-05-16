Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2B81D5D95
	for <lists+linux-api@lfdr.de>; Sat, 16 May 2020 03:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbgEPBVC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 15 May 2020 21:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgEPBVC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 15 May 2020 21:21:02 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A742C061A0C;
        Fri, 15 May 2020 18:21:01 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id z15so4702657pjb.0;
        Fri, 15 May 2020 18:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eD8nSEX9FeEfFYFcx1sY+GdGn8YPwFSgWFRNwl0px7U=;
        b=fwB8tR/Bt20pITmsd0QARLZNQnS8xckhvPsIJziPVT/Sn230jQib78WGwDeCpaW10Y
         KCgSDnjQvCRfC9RAI1OSumIjP9IDX5v11MmVPBvIUwmCKG7G9nvdV54UVIDrK6+oWfpL
         YlXxdYC8PgRRzD5a5iFtCxiDyXmMeta57/Bjqg64gcE3IP65HSbaslPzkWSwZi8n5fcx
         MG59wSAr7Wf0c0UVSildzKqkcTxViOIw8hi8joSpxdHAFmnpTGb462qrE2xl1PFGJ9do
         jBReA+yk0BAG5z7WXcCtGsIy43FMq+/LSOq//rLHmdkSmkRk8nZ65KkUmdq5XlsWTW58
         nrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=eD8nSEX9FeEfFYFcx1sY+GdGn8YPwFSgWFRNwl0px7U=;
        b=nKm+z6fBELgyOIjNV2vurhbUEGOpCu0R0Ea8Fv45qVRYsQGgJoPyoZ4LNvfJ7qI2eT
         i+3b1Pp0/C59DwhNvS4v5Qh87xjrxKpztqbSY/csKJ4mU7L03FdeBXXFaymsiT/9T2Iv
         ZEc2uWiXms66ivHt5EPXFYkehlzEdgkCkhAg+tDNqAh095bxA2XOqzcu0SGQ9wtklIwb
         RJiSIEy68VShHJ7mKZ/95vfFIi7NWPZL08H5rFPQPpfLB26p+tE7nEqSMfTvC6JN5QY+
         3p9wROOZmdbzTAPQF0r40tJUo7IFYQtEqHORlFX8uFK3Tv8AC6u30XhUkx0J0kTI2EZ6
         h4Mw==
X-Gm-Message-State: AOAM5319nNKHbzJc3G8GcHTVZRc/1bKevFol7vqQR3Qw8VtAsY0TwsPI
        UezVsU7srec5xuVxY2S0FBY=
X-Google-Smtp-Source: ABdhPJxaQ4eukrKWAZXgD0uhfLUXE8sPXxhov8YiL7z2w5J5Emj5+A0V94NHNrxEQhsUsDYmR1lKGQ==
X-Received: by 2002:a17:90b:1004:: with SMTP id gm4mr6722768pjb.35.1589592060414;
        Fri, 15 May 2020 18:21:00 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id ep10sm104530pjb.21.2020.05.15.18.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 18:20:59 -0700 (PDT)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com,
        SeongJae Park <sjpark@amazon.com>,
        David Rientjes <rientjes@google.com>,
        Arjun Roy <arjunroy@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH] mm: use only pidfd for process_madvise syscall
Date:   Fri, 15 May 2020 18:20:55 -0700
Message-Id: <20200516012055.126205-1-minchan@kernel.org>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Based on discussion[1], people didn't feel we need to support both
pid and pidfd for every new coming API[2] so this patch keeps only
pidfd. This patch also changes flags's type with "unsigned int".
So finally, the API is as follows,

      ssize_t process_madvise(int pidfd, const struct iovec *iovec,
      		unsigned long vlen, int advice, unsigned int flags);

    DESCRIPTION
      The process_madvise() system call is used to give advice or directions
      to the kernel about the address ranges from external process as well as
      local process. It provides the advice to address ranges of process
      described by iovec and vlen. The goal of such advice is to improve system
      or application performance.

      The pidfd selects the process referred to by the PID file descriptor
      specified in pidfd. (See pidofd_open(2) for further information)

      The pointer iovec points to an array of iovec structures, defined in
      <sys/uio.h> as:

        struct iovec {
            void *iov_base;         /* starting address */
            size_t iov_len;         /* number of bytes to be advised */
        };

      The iovec describes address ranges beginning at address(iov_base)
      and with size length of bytes(iov_len).

      The vlen represents the number of elements in iovec.

      The advice is indicated in the advice argument, which is one of the
      following at this moment if the target process specified by idtype and
      id is external.

        MADV_COLD
        MADV_PAGEOUT
        MADV_MERGEABLE
        MADV_UNMERGEABLE

      Permission to provide a hint to external process is governed by a
      ptrace access mode PTRACE_MODE_ATTACH_FSCREDS check; see ptrace(2).

      The process_madvise supports every advice madvise(2) has if target
      process is in same thread group with calling process so user could
      use process_madvise(2) to extend existing madvise(2) to support
      vector address ranges.

    RETURN VALUE
      On success, process_madvise() returns the number of bytes advised.
      This return value may be less than the total number of requested
      bytes, if an error occurred. The caller should check return value
      to determine whether a partial advice occurred.

[1] https://lore.kernel.org/linux-mm/20200509124817.xmrvsrq3mla6b76k@wittgenstein/
[2] https://lore.kernel.org/linux-mm/9d849087-3359-c4ab-fbec-859e8186c509@virtuozzo.com/
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/madvise.c | 42 +++++++++++++-----------------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index d3fbbe52d230..35c9b220146a 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1229,8 +1229,8 @@ static int process_madvise_vec(struct task_struct *target_task,
 	return ret;
 }
 
-static ssize_t do_process_madvise(int which, pid_t upid, struct iov_iter *iter,
-				       int behavior, unsigned long flags)
+static ssize_t do_process_madvise(int pidfd, struct iov_iter *iter,
+				int behavior, unsigned int flags)
 {
 	ssize_t ret;
 	struct pid *pid;
@@ -1241,26 +1241,12 @@ static ssize_t do_process_madvise(int which, pid_t upid, struct iov_iter *iter,
 	if (flags != 0)
 		return -EINVAL;
 
-	switch (which) {
-	case P_PID:
-		if (upid <= 0)
-			return -EINVAL;
-
-		pid = find_get_pid(upid);
-		if (!pid)
-			return -ESRCH;
-		break;
-	case P_PIDFD:
-		if (upid < 0)
-			return -EINVAL;
-
-		pid = pidfd_get_pid(upid);
-		if (IS_ERR(pid))
-			return PTR_ERR(pid);
-		break;
-	default:
+	if (pidfd < 0)
 		return -EINVAL;
-	}
+
+	pid = pidfd_get_pid(pidfd);
+	if (IS_ERR(pid))
+		return PTR_ERR(pid);
 
 	task = get_pid_task(pid, PIDTYPE_PID);
 	if (!task) {
@@ -1292,9 +1278,8 @@ static ssize_t do_process_madvise(int which, pid_t upid, struct iov_iter *iter,
 	return ret;
 }
 
-SYSCALL_DEFINE6(process_madvise, int, which, pid_t, upid,
-		const struct iovec __user *, vec, unsigned long, vlen,
-		int, behavior, unsigned long, flags)
+SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
+		unsigned long, vlen, int, behavior, unsigned int, flags)
 {
 	ssize_t ret;
 	struct iovec iovstack[UIO_FASTIOV];
@@ -1303,19 +1288,18 @@ SYSCALL_DEFINE6(process_madvise, int, which, pid_t, upid,
 
 	ret = import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
 	if (ret >= 0) {
-		ret = do_process_madvise(which, upid, &iter, behavior, flags);
+		ret = do_process_madvise(pidfd, &iter, behavior, flags);
 		kfree(iov);
 	}
 	return ret;
 }
 
 #ifdef CONFIG_COMPAT
-COMPAT_SYSCALL_DEFINE6(process_madvise, compat_int_t, which,
-			compat_pid_t, upid,
+COMPAT_SYSCALL_DEFINE5(process_madvise, compat_int_t, pidfd,
 			const struct compat_iovec __user *, vec,
 			compat_ulong_t, vlen,
 			compat_int_t, behavior,
-			compat_ulong_t, flags)
+			compat_int_t, flags)
 
 {
 	ssize_t ret;
@@ -1326,7 +1310,7 @@ COMPAT_SYSCALL_DEFINE6(process_madvise, compat_int_t, which,
 	ret = compat_import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack),
 				&iov, &iter);
 	if (ret >= 0) {
-		ret = do_process_madvise(which, upid, &iter, behavior, flags);
+		ret = do_process_madvise(pidfd, &iter, behavior, flags);
 		kfree(iov);
 	}
 	return ret;
-- 
2.26.2.761.g0e0b3e54be-goog

