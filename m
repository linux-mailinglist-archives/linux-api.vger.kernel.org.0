Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3D41BF15C
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2020 09:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgD3H3c (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Apr 2020 03:29:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:51102 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbgD3H3b (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 30 Apr 2020 03:29:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0802CAD79;
        Thu, 30 Apr 2020 07:29:29 +0000 (UTC)
Subject: Re: [PATCH v3 7/7] n_tty: Provide an informational line on VSTATUS
 receipt
To:     Arseny Maslennikov <ar@cs.msu.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Landley <rob@landley.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Pavel Machek <pavel@ucw.cz>, linux-api@vger.kernel.org,
        "Vladimir D. Seleznev" <vseleznv@altlinux.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, mm <linux-mm@kvack.org>
References: <20200430064301.1099452-1-ar@cs.msu.ru>
 <20200430064301.1099452-8-ar@cs.msu.ru>
From:   Jiri Slaby <jslaby@suse.cz>
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e29068ce-0d28-5469-a31d-a86bc311cc9a@suse.cz>
Date:   Thu, 30 Apr 2020 09:29:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200430064301.1099452-8-ar@cs.msu.ru>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

General comments:
- care to CC scheduler and mm people?
- couldn't this share some code with fs/proc?
- I am not sure/convinced it is worth the hassle

On 30. 04. 20, 8:43, Arseny Maslennikov wrote:
> If the three termios local flags isig, icanon, iexten are enabled
> and the local flag nokerninfo is disabled for a tty governed
> by the n_tty line discipline, then on receiving the keyboard status
> character n_tty will generate a status message and write it out to
> the tty before sending SIGINFO to the tty's foreground process group.
> 
> This kerninfo line contains information about the current system load
> as well as some properties of "the most interesting" process in the
> tty's current foreground process group, namely:
>  - its PID as seen inside its deepest PID namespace;
>    * the whole process group ought to be in a single PID namespace,
>      so this is actually deterministic
>  - its saved command name truncated to 16 bytes (task_struct::comm);
>    * at the time of writing TASK_COMM_LEN == 16
>  - its state and some related bits, procps-style;
>  - for S and D: its symbolic wait channel, if available; or a short
>    description for other process states instead;
>  - its user, system and real rusage time values;
>  - its resident set size (as well as the high watermark) in kilobytes.
> 
> The "most interesting" process is chosen as follows:
>  - runnables over everything
>  - uninterruptibles over everything else
>  - among 2 runnables pick the biggest utime + stime
>  - any unresolved ties are decided in favour of greatest PID.
> 
> While the kerninfo line is not very useful for debugging the kernel
> itself, since we have much more powerful debugging tools, it still gives
> the user behind the terminal some meaningful feedback to a VSTATUS that
> works even if no processes respond.

Care to append an example output to the commit message?

> Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
...
> index f72a3fd4b..905cdd985 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -79,6 +80,8 @@
>  #define ECHO_BLOCK		256
>  #define ECHO_DISCARD_WATERMARK	N_TTY_BUF_SIZE - (ECHO_BLOCK + 32)
>  
> +#define STATUS_LINE_LEN (2 * KSYM_NAME_LEN)

It's too magic constant.

> @@ -2489,6 +2496,21 @@ static int n_tty_ioctl(struct tty_struct *tty, struct file *file,
>  	}
>  }
>  
> +static void n_tty_status_line(struct tty_struct *tty)
> +{
> +	struct n_tty_data *ldata = tty->disc_data;
> +	char *msg, *buf;
> +	msg = buf = kzalloc(STATUS_LINE_LEN, GFP_KERNEL);
> +	tty_sprint_status_line(tty, buf + 1, STATUS_LINE_LEN - 1);
> +	/* The only current caller of this takes output_lock for us. */

So add a lockdep assertion?

> +	if (ldata->column != 0)
> +		*msg = '\n';
> +	else
> +		msg++;
> +	do_n_tty_write(tty, NULL, msg, strlen(msg));
> +	kfree(buf);
> +}
> +
>  static struct tty_ldisc_ops n_tty_ops = {
>  	.magic           = TTY_LDISC_MAGIC,
>  	.name            = "n_tty",
> diff --git a/drivers/tty/n_tty_status.c b/drivers/tty/n_tty_status.c
> new file mode 100644
> index 000000000..d92261bbe
> --- /dev/null
> +++ b/drivers/tty/n_tty_status.c
> @@ -0,0 +1,338 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <linux/kallsyms.h>
> +#include <linux/pid.h>
> +#include <linux/sched.h>
> +#include <linux/sched/signal.h>
> +#include <linux/sched/loadavg.h>
> +#include <linux/sched/cputime.h>
> +#include <linux/sched/mm.h>
> +#include <linux/slab.h>
> +#include <linux/tty.h>
> +
> +#define BCOMPARE(lbool, rbool) ((lbool) << 1 | (rbool))
> +#define BCOMPARE_NONE 0
> +#define BCOMPARE_RIGHT 1
> +#define BCOMPARE_LEFT 2
> +#define BCOMPARE_BOTH (BCOMPARE_LEFT | BCOMPARE_RIGHT)
> +
> +/*
> + * Select the most interesting task of two.
> + *
> + * The implemented approach is simple for now:
> + * - pick runnable
> + * - if no runnables, pick uninterruptible
> + * - if tie between runnables, pick highest utime + stime
> + * - if a tie is not broken by the above, pick highest pid nr.
> + *
> + * For reference, here's the one used in FreeBSD:
> + * - pick runnables over anything
> + * - if both runnables, pick highest cpu utilization
> + * - if no runnables, pick shortest sleep time (the scheduler
> + *   actually takes care to maintain this statistic)
> + * - other ties are decided in favour of youngest process.
> + */
> +static struct task_struct *__better_proc_R(struct task_struct *a,

Why so weird name __better_proc_R?

> +		struct task_struct *b)
> +{
> +	unsigned long flags;
> +	u64 atime, btime, tgutime, tgstime;
> +	struct task_struct *ret;
> +
> +	if (!lock_task_sighand(a, &flags))
> +		goto out_a_unlocked;
> +	thread_group_cputime_adjusted(a, &tgutime, &tgstime);
> +	atime = tgutime + tgstime;
> +	unlock_task_sighand(a, &flags);
> +
> +	if (!lock_task_sighand(b, &flags))
> +		goto out_b_unlocked;
> +	thread_group_cputime_adjusted(b, &tgutime, &tgstime);
> +	btime = tgutime + tgstime;
> +	unlock_task_sighand(b, &flags);
> +
> +	ret = atime > btime ? a : b;
> +
> +	return ret;
> +
> +out_b_unlocked:
> +out_a_unlocked:
> +	return task_pid_vinr(a) > task_pid_vinr(b) ? a : b;
> +}
> +
> +static struct task_struct *__better_proc(struct task_struct *a,

Again, why "__" in the name?

> +		struct task_struct *b)
> +{
> +	if (!pid_alive(a))
> +		return b;
> +	if (!pid_alive(b))
> +		return a;
> +
> +	switch (BCOMPARE(a->state == TASK_RUNNING,
> +			b->state == TASK_RUNNING)) {
> +	case BCOMPARE_LEFT:
> +		return a;
> +	case BCOMPARE_RIGHT:
> +		return b;
> +	case BCOMPARE_BOTH:
> +		return __better_proc_R(a, b);
> +	}

Doesn't this look saner and better:

if (a->state == TASK_RUNNING && b->state == TASK_RUNNING)
  return __better_proc_R(a, b);
if (a->state == TASK_RUNNING)
  return a;
if (b->state == TASK_RUNNING)
  return b;

?

And one doesn't need to decrypt the defines.

> +	switch (BCOMPARE(a->state == TASK_UNINTERRUPTIBLE,
> +			b->state == TASK_UNINTERRUPTIBLE)) {
> +	case BCOMPARE_LEFT:
> +		return a;
> +	case BCOMPARE_RIGHT:
> +		return b;
> +	case BCOMPARE_BOTH:
> +		break;

dtto.

> +	}
> +
> +	/* TODO: Perhaps we should check something else... */
> +	return task_pid_vinr(a) > task_pid_vinr(b) ? a : b;
> +}
> +
> +/* Weed out NULLs. */
> +static inline struct task_struct *better_proc(struct task_struct *a,
> +		struct task_struct *b) {
> +	return a ? (b ? __better_proc(a, b) : a) : b;

This urgently calls for ifs and not ternany operators.

Actually you don't need this helper at all. Check a and b in the same if
as the respective !pid_alive above.

> +}
> +
> +static int scnprint_load(char *msgp, size_t size)
> +{
> +	unsigned long la[3];
> +
> +	get_avenrun(la, FIXED_1/200, 0);
> +	return scnprintf(msgp, size, "load: %lu.%02lu; ",
> +			LOAD_INT(la[0]), LOAD_FRAC(la[0]));
> +}
> +
> +static int scnprint_task(char *msgp, size_t size, struct task_struct *task)
> +{
> +	char commname[TASK_COMM_LEN];
> +
> +	get_task_comm(commname, task);
> +	return scnprintf(msgp, size, "%d/%s:", task_pid_vinr(task), commname);
> +}
> +
> +static int scnprint_rusage(char *msgp, ssize_t size,
> +		struct task_struct *task, struct mm_struct *mm)
> +{
> +	struct rusage ru;
> +	struct timespec64 utime, stime;
> +	struct timespec64 rtime;
> +	u64 now;
> +	int ret = 0;
> +	int psz = 0;
> +
> +	getrusage(task, RUSAGE_BOTH, &ru);
> +	now = ktime_get_ns();
> +
> +	utime.tv_sec = ru.ru_utime.tv_sec;
> +	utime.tv_nsec = ru.ru_utime.tv_usec * NSEC_PER_USEC;
> +	stime.tv_sec = ru.ru_stime.tv_sec;
> +	stime.tv_nsec = ru.ru_stime.tv_usec * NSEC_PER_USEC;
> +
> +	rtime = ns_to_timespec64(now - task->start_time);
> +
> +	psz = scnprintf(msgp, size,
> +			"%llu.%03lur %llu.%03luu %llu.%03lus",
> +			rtime.tv_sec, rtime.tv_nsec / NSEC_PER_MSEC,
> +			utime.tv_sec, utime.tv_nsec / NSEC_PER_MSEC,
> +			stime.tv_sec, stime.tv_nsec / NSEC_PER_MSEC);
> +	ret += psz;
> +	msgp += psz;
> +	size -= psz;
> +
> +	if (mm) {
> +		psz = scnprintf(msgp, size,
> +				" %luk/%luk",
> +				get_mm_rss(mm) * PAGE_SIZE / 1024,
> +				get_mm_hiwater_rss(mm) * PAGE_SIZE / 1024);
> +		ret += psz;
> +	}
> +	return ret;
> +}
> +
> +static int scnprint_state(char *msgp, ssize_t size,
> +		struct task_struct *task, struct mm_struct *mm)
> +{
> +	char stat[8] = {0};
> +	const char *state_descr = "";
> +	struct task_struct *parent = NULL;
> +	struct task_struct *real_parent = NULL;
> +	unsigned long wchan = 0;
> +	int psz = 0;
> +	char symname[KSYM_NAME_LEN];
> +
> +	stat[psz++] = task_state_to_char(task);
> +	if (task_nice(task) < 0)
> +		stat[psz++] = '<';
> +	else if (task_nice(task) > 0)
> +		stat[psz++] = 'N';
> +	if (mm && mm->locked_vm)
> +		stat[psz++] = 'L';
> +	if (get_nr_threads(task) > 1)
> +		stat[psz++] = 'l';
> +
> +	switch (stat[0]) {
> +	case 'R':
> +		if (task_curr(task))
> +			stat[psz++] = '!';
> +		break;
> +	case 'S':
> +	case 'D':
> +		wchan = get_wchan(task);
> +		if (!wchan)
> +			break;
> +		if (!lookup_symbol_name(wchan, symname))
> +			state_descr = symname;
> +		else
> +			/* get_wchan() returned something
> +			 * that looks like no kernel symbol.
> +			 */
> +			state_descr = "*unknown*";
> +		break;
> +	case 'T':
> +		state_descr = "stopped";
> +		break;
> +	case 't':
> +		state_descr = "traced";
> +		break;
> +	case 'Z':
> +		rcu_read_lock();
> +		real_parent = rcu_dereference(task->real_parent);
> +		parent = rcu_dereference(task->parent);
> +		psz = sprintf(symname, "zombie; ppid=%d",
> +			task_tgid_nr_ns(real_parent,
> +				ns_of_pid(task_pid(task))));
> +		if (parent != real_parent)
> +			sprintf(symname + psz, " reaper=%d",
> +				task_tgid_nr_ns(parent,
> +					ns_of_pid(task_pid(task))));
> +		rcu_read_unlock();
> +		state_descr = symname;
> +		break;
> +	case 'I':
> +		/* Can this even happen? */
> +		state_descr = "idle";
> +		break;
> +	default:
> +		state_descr = "unknown";
> +	}
> +
> +	psz = scnprintf(msgp, size, "%s", stat);
> +	msgp += psz;
> +	size -= psz;
> +	if (*state_descr)
> +		psz += scnprintf(msgp, size, wchan ? " [%s]" : " (%s)", state_descr);
> +
> +	return psz;
> +}
> +
> +/**
> + *	tty_sprint_status_line	-		produce kerninfo line
> + *	@tty: terminal device
> + *	@msg: preallocated memory buffer
> + *	@length: maximum line length
> + *
> + *	Reports state of foreground process group in a null-terminated string
> + *	located at @msg, @length bytes long. If @length is insufficient,
> + *	the line gets truncated.
> + */
> +void tty_sprint_status_line(struct tty_struct *t, char *msg, size_t length)
> +{
> +	struct task_struct *tsk = NULL, *mit = NULL;
> +	struct mm_struct *mm;
> +	struct pid *pgrp = NULL;
> +	char *msgp = msg;
> +	int psz = 0;
> +
> +	if (!length)
> +		return;
> +	length--; /* Make room for trailing '\n' */
> +
> +	psz = scnprint_load(msgp, length);
> +	if (psz > 0) {
> +		msgp += psz;
> +		length -= psz;
> +	}
> +	if (!length)
> +		goto finalize_message;
> +
> +	/* Not sure if session pid is protected by ctrl_lock
> +	 * or tasklist_lock...
> +	 */
> +	pgrp = t->session;
> +	if (pgrp == NULL) {
> +		psz = scnprintf(msgp, length, "not a controlling tty");
> +		if (psz > 0)
> +			msgp += psz;
> +		goto finalize_message;
> +	}
> +	pgrp = tty_get_pgrp(t);
> +	if (pgrp == NULL) {
> +		psz = scnprintf(msgp, length, "no foreground process group");
> +		if (psz > 0)
> +			msgp += psz;
> +		goto finalize_message;
> +	}
> +
> +	read_lock(&tasklist_lock);
> +	do_each_pid_task(pgrp, PIDTYPE_PGID, tsk)
> +	{
> +		/* Select the most interesting task. */
> +		if (tsk == better_proc(mit, tsk))
> +			mit = tsk;
> +	} while_each_pid_task(pgrp, PIDTYPE_PGID, tsk);
> +	read_unlock(&tasklist_lock);
> +
> +	if (!pid_alive(mit))
> +		goto finalize_message;
> +
> +	/* Gather intel on most interesting task. */
> +	/* Can the mm of a foreground process turn out to be NULL?
> +	 * Definitely; for example, if it is a zombie.
> +	 */
> +	mm = get_task_mm(mit);
> +
> +	psz = scnprint_task(msgp, length, mit);
> +	if (psz > 0) {
> +		msgp += psz;
> +		length -= psz;
> +	}
> +	if (!length)
> +		goto finalize_message;
> +	*msgp++ = ' ';
> +	length--;
> +
> +	psz = scnprint_state(msgp, length, mit, mm);
> +	if (psz > 0) {
> +		msgp += psz;
> +		length -= psz;
> +	}
> +	if (!length)
> +		goto finalize_message;
> +	*msgp++ = ' ';
> +	length--;
> +
> +	psz = scnprint_rusage(msgp, length, mit, mm);
> +	if (psz > 0) {
> +		msgp += psz;
> +		length -= psz;
> +	}
> +	if (!length)
> +		goto finalize_message;
> +	*msgp++ = ' ';
> +	length--;
> +
> +	if (!mm)
> +		goto finalize_message;
> +
> +	mmput(mm);
> +
> +finalize_message:
> +	*msgp++ = '\n';
> +	if (pgrp)
> +		put_pid(pgrp);
> +}
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 4418f5cb8..195abd47d 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1318,6 +1318,8 @@ static inline struct pid *task_pid(struct task_struct *task)
>   * task_xid_nr()     : global id, i.e. the id seen from the init namespace;
>   * task_xid_vnr()    : virtual id, i.e. the id seen from the pid namespace of
>   *                     current.
> + * task_xid_vinr()   : virtual inner id, i.e. the id seen from the namespace of
> + *                     the task itself;
>   * task_xid_nr_ns()  : id seen from the ns specified;
>   *
>   * see also pid_nr() etc in include/linux/pid.h
> @@ -1339,6 +1341,11 @@ static inline pid_t task_pid_vnr(struct task_struct *tsk)
>  	return __task_pid_nr_ns(tsk, PIDTYPE_PID, NULL);
>  }
>  
> +static inline pid_t task_pid_vinr(struct task_struct *tsk)
> +{
> +	return __task_pid_nr_ns(tsk, PIDTYPE_PID, ns_of_pid(task_pid(tsk)));
> +}
> +

This smells like it should be done in a separate patch.

>  static inline pid_t task_tgid_nr(struct task_struct *tsk)
>  {
> diff --git a/include/linux/tty.h b/include/linux/tty.h
> index 3499845ab..2023addaf 100644
> --- a/include/linux/tty.h
> +++ b/include/linux/tty.h
> @@ -727,6 +727,9 @@ extern void __init n_tty_init(void);
>  static inline void n_tty_init(void) { }
>  #endif
>  
> +/* n_tty_status.c */
> +extern void tty_sprint_status_line(struct tty_struct *tty, char *msg, size_t size);

No need for extern.

thanks,
-- 
js
suse labs
