Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DA01BF10C
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2020 09:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgD3HQt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Apr 2020 03:16:49 -0400
Received: from mail.cs.msu.ru ([188.44.42.39]:50481 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbgD3HQs (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 30 Apr 2020 03:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=v1banPAUBgOAq/veMLD8uawoKUg4Jpp1YbeV0nvMHVc=; b=GzY/o8s9i6uem9NyV5tl/5W9Cq
        JuWUFcqHxophNOxWp6Z4ISN6qlZU5Sm/BXaUaCleolUR2HaJ1xkME5+jvOgX1SfHPn4CvnXt+LIMi
        AOHASQMeMlDJHRYB7dUVX2Uzq+fEeCh9eVyzcK3/9P3vgRo7Qbv4AiNyk+u7cZUi0didg9p08Vqty
        6CmB6rXru9rEBtwUtAzxKTJ3R6xwTPhgjt6WmnlLTnVQKYAmeTYelfNm455yUXy2hgP2f9eAFlf4W
        Se4rm9+7VqH1OW0rI3ZY53Xtg0l1pcwf9mT17+Ie71vaJjNX3WnViA/RCucoytKKR4YRO7sTIhbDb
        wfkrxy3A==;
Received: from [37.204.119.143] (port=42272 helo=localhost.localdomain)
        by mail.cs.msu.ru with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93.0.4 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1jU2uw-000B4I-9P; Thu, 30 Apr 2020 09:43:30 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Arseny Maslennikov <ar@cs.msu.ru>, Rob Landley <rob@landley.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Pavel Machek <pavel@ucw.cz>, linux-api@vger.kernel.org,
        "Vladimir D. Seleznev" <vseleznv@altlinux.org>
Date:   Thu, 30 Apr 2020 09:43:01 +0300
Message-Id: <20200430064301.1099452-8-ar@cs.msu.ru>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430064301.1099452-1-ar@cs.msu.ru>
References: <20200430064301.1099452-1-ar@cs.msu.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.cs.msu.ru
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_ADSP_ALL autolearn=no autolearn_force=no version=3.4.4
Subject: [PATCH v3 7/7] n_tty: Provide an informational line on VSTATUS receipt
X-SA-Exim-Version: 4.2.1
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

If the three termios local flags isig, icanon, iexten are enabled
and the local flag nokerninfo is disabled for a tty governed
by the n_tty line discipline, then on receiving the keyboard status
character n_tty will generate a status message and write it out to
the tty before sending SIGINFO to the tty's foreground process group.

This kerninfo line contains information about the current system load
as well as some properties of "the most interesting" process in the
tty's current foreground process group, namely:
 - its PID as seen inside its deepest PID namespace;
   * the whole process group ought to be in a single PID namespace,
     so this is actually deterministic
 - its saved command name truncated to 16 bytes (task_struct::comm);
   * at the time of writing TASK_COMM_LEN == 16
 - its state and some related bits, procps-style;
 - for S and D: its symbolic wait channel, if available; or a short
   description for other process states instead;
 - its user, system and real rusage time values;
 - its resident set size (as well as the high watermark) in kilobytes.

The "most interesting" process is chosen as follows:
 - runnables over everything
 - uninterruptibles over everything else
 - among 2 runnables pick the biggest utime + stime
 - any unresolved ties are decided in favour of greatest PID.

While the kerninfo line is not very useful for debugging the kernel
itself, since we have much more powerful debugging tools, it still gives
the user behind the terminal some meaningful feedback to a VSTATUS that
works even if no processes respond.

Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
---
 drivers/tty/Makefile       |   3 +-
 drivers/tty/n_tty.c        |  22 +++
 drivers/tty/n_tty_status.c | 338 +++++++++++++++++++++++++++++++++++++
 include/linux/sched.h      |   7 +
 include/linux/tty.h        |   3 +
 5 files changed, 372 insertions(+), 1 deletion(-)
 create mode 100644 drivers/tty/n_tty_status.c

diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index 020b1cd92..8bb5efb40 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_TTY)		+= tty_io.o n_tty.o tty_ioctl.o tty_ldisc.o \
+obj-$(CONFIG_TTY)		+= tty_io.o tty_ioctl.o tty_ldisc.o \
 				   tty_buffer.o tty_port.o tty_mutex.o \
 				   tty_ldsem.o tty_baudrate.o tty_jobctrl.o \
+				   n_tty.o n_tty_status.o \
 				   n_null.o
 obj-$(CONFIG_LEGACY_PTYS)	+= pty.o
 obj-$(CONFIG_UNIX98_PTYS)	+= pty.o
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index f72a3fd4b..905cdd985 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -34,6 +34,7 @@
 #include <linux/signal.h>
 #include <linux/fcntl.h>
 #include <linux/sched.h>
+#include <linux/kallsyms.h>
 #include <linux/interrupt.h>
 #include <linux/tty.h>
 #include <linux/timer.h>
@@ -79,6 +80,8 @@
 #define ECHO_BLOCK		256
 #define ECHO_DISCARD_WATERMARK	N_TTY_BUF_SIZE - (ECHO_BLOCK + 32)
 
+#define STATUS_LINE_LEN (2 * KSYM_NAME_LEN)
+
 #define SIG_FLUSHING_MASK ( \
 	rt_sigmask(SIGINT) | rt_sigmask(SIGQUIT) | \
 	rt_sigmask(SIGTSTP)			 )
@@ -158,6 +161,8 @@ static inline unsigned char *echo_buf_addr(struct n_tty_data *ldata, size_t i)
 	return &ldata->echo_buf[i & (N_TTY_BUF_SIZE - 1)];
 }
 
+static void n_tty_status_line(struct tty_struct *tty);
+
 /* If we are not echoing the data, perhaps this is a secret so erase it */
 static void zero_buffer(struct tty_struct *tty, u8 *buffer, int size)
 {
@@ -1300,6 +1305,8 @@ n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
 			n_tty_receive_signal_char(tty, SIGTSTP, c);
 			return 0;
 		} else if (c == STATUS_CHAR(tty)) {
+			if (!L_NOKERNINFO(tty))
+				n_tty_status_line(tty);
 			n_tty_receive_signal_char(tty, SIGINFO, c);
 			return 0;
 		}
@@ -2489,6 +2496,21 @@ static int n_tty_ioctl(struct tty_struct *tty, struct file *file,
 	}
 }
 
+static void n_tty_status_line(struct tty_struct *tty)
+{
+	struct n_tty_data *ldata = tty->disc_data;
+	char *msg, *buf;
+	msg = buf = kzalloc(STATUS_LINE_LEN, GFP_KERNEL);
+	tty_sprint_status_line(tty, buf + 1, STATUS_LINE_LEN - 1);
+	/* The only current caller of this takes output_lock for us. */
+	if (ldata->column != 0)
+		*msg = '\n';
+	else
+		msg++;
+	do_n_tty_write(tty, NULL, msg, strlen(msg));
+	kfree(buf);
+}
+
 static struct tty_ldisc_ops n_tty_ops = {
 	.magic           = TTY_LDISC_MAGIC,
 	.name            = "n_tty",
diff --git a/drivers/tty/n_tty_status.c b/drivers/tty/n_tty_status.c
new file mode 100644
index 000000000..d92261bbe
--- /dev/null
+++ b/drivers/tty/n_tty_status.c
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/kallsyms.h>
+#include <linux/pid.h>
+#include <linux/sched.h>
+#include <linux/sched/signal.h>
+#include <linux/sched/loadavg.h>
+#include <linux/sched/cputime.h>
+#include <linux/sched/mm.h>
+#include <linux/slab.h>
+#include <linux/tty.h>
+
+#define BCOMPARE(lbool, rbool) ((lbool) << 1 | (rbool))
+#define BCOMPARE_NONE 0
+#define BCOMPARE_RIGHT 1
+#define BCOMPARE_LEFT 2
+#define BCOMPARE_BOTH (BCOMPARE_LEFT | BCOMPARE_RIGHT)
+
+/*
+ * Select the most interesting task of two.
+ *
+ * The implemented approach is simple for now:
+ * - pick runnable
+ * - if no runnables, pick uninterruptible
+ * - if tie between runnables, pick highest utime + stime
+ * - if a tie is not broken by the above, pick highest pid nr.
+ *
+ * For reference, here's the one used in FreeBSD:
+ * - pick runnables over anything
+ * - if both runnables, pick highest cpu utilization
+ * - if no runnables, pick shortest sleep time (the scheduler
+ *   actually takes care to maintain this statistic)
+ * - other ties are decided in favour of youngest process.
+ */
+static struct task_struct *__better_proc_R(struct task_struct *a,
+		struct task_struct *b)
+{
+	unsigned long flags;
+	u64 atime, btime, tgutime, tgstime;
+	struct task_struct *ret;
+
+	if (!lock_task_sighand(a, &flags))
+		goto out_a_unlocked;
+	thread_group_cputime_adjusted(a, &tgutime, &tgstime);
+	atime = tgutime + tgstime;
+	unlock_task_sighand(a, &flags);
+
+	if (!lock_task_sighand(b, &flags))
+		goto out_b_unlocked;
+	thread_group_cputime_adjusted(b, &tgutime, &tgstime);
+	btime = tgutime + tgstime;
+	unlock_task_sighand(b, &flags);
+
+	ret = atime > btime ? a : b;
+
+	return ret;
+
+out_b_unlocked:
+out_a_unlocked:
+	return task_pid_vinr(a) > task_pid_vinr(b) ? a : b;
+}
+
+static struct task_struct *__better_proc(struct task_struct *a,
+		struct task_struct *b)
+{
+	if (!pid_alive(a))
+		return b;
+	if (!pid_alive(b))
+		return a;
+
+	switch (BCOMPARE(a->state == TASK_RUNNING,
+			b->state == TASK_RUNNING)) {
+	case BCOMPARE_LEFT:
+		return a;
+	case BCOMPARE_RIGHT:
+		return b;
+	case BCOMPARE_BOTH:
+		return __better_proc_R(a, b);
+	}
+
+	switch (BCOMPARE(a->state == TASK_UNINTERRUPTIBLE,
+			b->state == TASK_UNINTERRUPTIBLE)) {
+	case BCOMPARE_LEFT:
+		return a;
+	case BCOMPARE_RIGHT:
+		return b;
+	case BCOMPARE_BOTH:
+		break;
+	}
+
+	/* TODO: Perhaps we should check something else... */
+	return task_pid_vinr(a) > task_pid_vinr(b) ? a : b;
+}
+
+/* Weed out NULLs. */
+static inline struct task_struct *better_proc(struct task_struct *a,
+		struct task_struct *b) {
+	return a ? (b ? __better_proc(a, b) : a) : b;
+}
+
+static int scnprint_load(char *msgp, size_t size)
+{
+	unsigned long la[3];
+
+	get_avenrun(la, FIXED_1/200, 0);
+	return scnprintf(msgp, size, "load: %lu.%02lu; ",
+			LOAD_INT(la[0]), LOAD_FRAC(la[0]));
+}
+
+static int scnprint_task(char *msgp, size_t size, struct task_struct *task)
+{
+	char commname[TASK_COMM_LEN];
+
+	get_task_comm(commname, task);
+	return scnprintf(msgp, size, "%d/%s:", task_pid_vinr(task), commname);
+}
+
+static int scnprint_rusage(char *msgp, ssize_t size,
+		struct task_struct *task, struct mm_struct *mm)
+{
+	struct rusage ru;
+	struct timespec64 utime, stime;
+	struct timespec64 rtime;
+	u64 now;
+	int ret = 0;
+	int psz = 0;
+
+	getrusage(task, RUSAGE_BOTH, &ru);
+	now = ktime_get_ns();
+
+	utime.tv_sec = ru.ru_utime.tv_sec;
+	utime.tv_nsec = ru.ru_utime.tv_usec * NSEC_PER_USEC;
+	stime.tv_sec = ru.ru_stime.tv_sec;
+	stime.tv_nsec = ru.ru_stime.tv_usec * NSEC_PER_USEC;
+
+	rtime = ns_to_timespec64(now - task->start_time);
+
+	psz = scnprintf(msgp, size,
+			"%llu.%03lur %llu.%03luu %llu.%03lus",
+			rtime.tv_sec, rtime.tv_nsec / NSEC_PER_MSEC,
+			utime.tv_sec, utime.tv_nsec / NSEC_PER_MSEC,
+			stime.tv_sec, stime.tv_nsec / NSEC_PER_MSEC);
+	ret += psz;
+	msgp += psz;
+	size -= psz;
+
+	if (mm) {
+		psz = scnprintf(msgp, size,
+				" %luk/%luk",
+				get_mm_rss(mm) * PAGE_SIZE / 1024,
+				get_mm_hiwater_rss(mm) * PAGE_SIZE / 1024);
+		ret += psz;
+	}
+	return ret;
+}
+
+static int scnprint_state(char *msgp, ssize_t size,
+		struct task_struct *task, struct mm_struct *mm)
+{
+	char stat[8] = {0};
+	const char *state_descr = "";
+	struct task_struct *parent = NULL;
+	struct task_struct *real_parent = NULL;
+	unsigned long wchan = 0;
+	int psz = 0;
+	char symname[KSYM_NAME_LEN];
+
+	stat[psz++] = task_state_to_char(task);
+	if (task_nice(task) < 0)
+		stat[psz++] = '<';
+	else if (task_nice(task) > 0)
+		stat[psz++] = 'N';
+	if (mm && mm->locked_vm)
+		stat[psz++] = 'L';
+	if (get_nr_threads(task) > 1)
+		stat[psz++] = 'l';
+
+	switch (stat[0]) {
+	case 'R':
+		if (task_curr(task))
+			stat[psz++] = '!';
+		break;
+	case 'S':
+	case 'D':
+		wchan = get_wchan(task);
+		if (!wchan)
+			break;
+		if (!lookup_symbol_name(wchan, symname))
+			state_descr = symname;
+		else
+			/* get_wchan() returned something
+			 * that looks like no kernel symbol.
+			 */
+			state_descr = "*unknown*";
+		break;
+	case 'T':
+		state_descr = "stopped";
+		break;
+	case 't':
+		state_descr = "traced";
+		break;
+	case 'Z':
+		rcu_read_lock();
+		real_parent = rcu_dereference(task->real_parent);
+		parent = rcu_dereference(task->parent);
+		psz = sprintf(symname, "zombie; ppid=%d",
+			task_tgid_nr_ns(real_parent,
+				ns_of_pid(task_pid(task))));
+		if (parent != real_parent)
+			sprintf(symname + psz, " reaper=%d",
+				task_tgid_nr_ns(parent,
+					ns_of_pid(task_pid(task))));
+		rcu_read_unlock();
+		state_descr = symname;
+		break;
+	case 'I':
+		/* Can this even happen? */
+		state_descr = "idle";
+		break;
+	default:
+		state_descr = "unknown";
+	}
+
+	psz = scnprintf(msgp, size, "%s", stat);
+	msgp += psz;
+	size -= psz;
+	if (*state_descr)
+		psz += scnprintf(msgp, size, wchan ? " [%s]" : " (%s)", state_descr);
+
+	return psz;
+}
+
+/**
+ *	tty_sprint_status_line	-		produce kerninfo line
+ *	@tty: terminal device
+ *	@msg: preallocated memory buffer
+ *	@length: maximum line length
+ *
+ *	Reports state of foreground process group in a null-terminated string
+ *	located at @msg, @length bytes long. If @length is insufficient,
+ *	the line gets truncated.
+ */
+void tty_sprint_status_line(struct tty_struct *t, char *msg, size_t length)
+{
+	struct task_struct *tsk = NULL, *mit = NULL;
+	struct mm_struct *mm;
+	struct pid *pgrp = NULL;
+	char *msgp = msg;
+	int psz = 0;
+
+	if (!length)
+		return;
+	length--; /* Make room for trailing '\n' */
+
+	psz = scnprint_load(msgp, length);
+	if (psz > 0) {
+		msgp += psz;
+		length -= psz;
+	}
+	if (!length)
+		goto finalize_message;
+
+	/* Not sure if session pid is protected by ctrl_lock
+	 * or tasklist_lock...
+	 */
+	pgrp = t->session;
+	if (pgrp == NULL) {
+		psz = scnprintf(msgp, length, "not a controlling tty");
+		if (psz > 0)
+			msgp += psz;
+		goto finalize_message;
+	}
+	pgrp = tty_get_pgrp(t);
+	if (pgrp == NULL) {
+		psz = scnprintf(msgp, length, "no foreground process group");
+		if (psz > 0)
+			msgp += psz;
+		goto finalize_message;
+	}
+
+	read_lock(&tasklist_lock);
+	do_each_pid_task(pgrp, PIDTYPE_PGID, tsk)
+	{
+		/* Select the most interesting task. */
+		if (tsk == better_proc(mit, tsk))
+			mit = tsk;
+	} while_each_pid_task(pgrp, PIDTYPE_PGID, tsk);
+	read_unlock(&tasklist_lock);
+
+	if (!pid_alive(mit))
+		goto finalize_message;
+
+	/* Gather intel on most interesting task. */
+	/* Can the mm of a foreground process turn out to be NULL?
+	 * Definitely; for example, if it is a zombie.
+	 */
+	mm = get_task_mm(mit);
+
+	psz = scnprint_task(msgp, length, mit);
+	if (psz > 0) {
+		msgp += psz;
+		length -= psz;
+	}
+	if (!length)
+		goto finalize_message;
+	*msgp++ = ' ';
+	length--;
+
+	psz = scnprint_state(msgp, length, mit, mm);
+	if (psz > 0) {
+		msgp += psz;
+		length -= psz;
+	}
+	if (!length)
+		goto finalize_message;
+	*msgp++ = ' ';
+	length--;
+
+	psz = scnprint_rusage(msgp, length, mit, mm);
+	if (psz > 0) {
+		msgp += psz;
+		length -= psz;
+	}
+	if (!length)
+		goto finalize_message;
+	*msgp++ = ' ';
+	length--;
+
+	if (!mm)
+		goto finalize_message;
+
+	mmput(mm);
+
+finalize_message:
+	*msgp++ = '\n';
+	if (pgrp)
+		put_pid(pgrp);
+}
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4418f5cb8..195abd47d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1318,6 +1318,8 @@ static inline struct pid *task_pid(struct task_struct *task)
  * task_xid_nr()     : global id, i.e. the id seen from the init namespace;
  * task_xid_vnr()    : virtual id, i.e. the id seen from the pid namespace of
  *                     current.
+ * task_xid_vinr()   : virtual inner id, i.e. the id seen from the namespace of
+ *                     the task itself;
  * task_xid_nr_ns()  : id seen from the ns specified;
  *
  * see also pid_nr() etc in include/linux/pid.h
@@ -1339,6 +1341,11 @@ static inline pid_t task_pid_vnr(struct task_struct *tsk)
 	return __task_pid_nr_ns(tsk, PIDTYPE_PID, NULL);
 }
 
+static inline pid_t task_pid_vinr(struct task_struct *tsk)
+{
+	return __task_pid_nr_ns(tsk, PIDTYPE_PID, ns_of_pid(task_pid(tsk)));
+}
+
 
 static inline pid_t task_tgid_nr(struct task_struct *tsk)
 {
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 3499845ab..2023addaf 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -727,6 +727,9 @@ extern void __init n_tty_init(void);
 static inline void n_tty_init(void) { }
 #endif
 
+/* n_tty_status.c */
+extern void tty_sprint_status_line(struct tty_struct *tty, char *msg, size_t size);
+
 /* tty_audit.c */
 #ifdef CONFIG_AUDIT
 extern void tty_audit_add_data(struct tty_struct *tty, const void *data,
-- 
2.26.2

