Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DE91BF3D1
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2020 11:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgD3JIW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Apr 2020 05:08:22 -0400
Received: from mail.cs.msu.ru ([188.44.42.39]:47081 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbgD3JIW (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 30 Apr 2020 05:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IU4cJGFup5HbhwCXY8RtgrIwLjxd4NI3lBi9hEBjTbA=; b=iITjRVA8stqTdNSXerJhrrgkR7
        9E7FCTODAZYI0Dzpx9FQAadBrC0gnsE6mf9e+NA4vsQnNo2uJ7eAOL5Sb9TH7dbcfn1aRvC9cm8xs
        rUtwdNnLmFp5g94YAzWc/zBooGFHZLQ0cbSMdbnCmOI9V4pFY/oj0CcHUmIulnOa3reWS9JMl6DIC
        AU46UuyrwqbPbe3ZcolWZflFmZ4vDUXtNNZIo/MdXfDxDLAf45vj61l4ii+tsiV4rz/mqPPZkCOSn
        rT1FZBXRyq25FMwTxlgk5nrr2Kaoj86Tzalz0rVm7PgVvXo7/XH/7gLVsLbh3KIGNJki/dZnl1YtW
        Kebn7PkQ==;
Received: from [37.204.119.143] (port=48580 helo=cello)
        by mail.cs.msu.ru with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93.0.4 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1jU5At-0002gC-AM; Thu, 30 Apr 2020 12:08:08 +0300
Date:   Thu, 30 Apr 2020 12:08:05 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Landley <rob@landley.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Pavel Machek <pavel@ucw.cz>, linux-api@vger.kernel.org,
        "Vladimir D. Seleznev" <vseleznv@altlinux.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, mm <linux-mm@kvack.org>
Message-ID: <20200430090805.GJ43805@cello>
References: <20200430064301.1099452-1-ar@cs.msu.ru>
 <20200430064301.1099452-8-ar@cs.msu.ru>
 <e29068ce-0d28-5469-a31d-a86bc311cc9a@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="07FIeBX8hApXX6Bi"
Content-Disposition: inline
In-Reply-To: <e29068ce-0d28-5469-a31d-a86bc311cc9a@suse.cz>
OpenPGP: url=http://grep.cs.msu.ru/~ar/pgp-key.asc
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.cs.msu.ru
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_ADSP_ALL autolearn=no autolearn_force=no version=3.4.4
Subject: Re: [PATCH v3 7/7] n_tty: Provide an informational line on VSTATUS
 receipt
X-SA-Exim-Version: 4.2.1
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--07FIeBX8hApXX6Bi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2020 at 09:29:28AM +0200, Jiri Slaby wrote:
> General comments:
> - care to CC scheduler and mm people?

I did in v1, but dropped those CCs in v2 and on, being afraid to
over-cc.
I'm sorry if I did the wrong thing.

> - couldn't this share some code with fs/proc?

We can't use the proc handlers directly, since they are often written to
output to the proc seqfile interface, and we can't use that.

This shares code with proc at a lower level by using the same
primitives to obtain info from.

> - I am not sure/convinced it is worth the hassle
>=20
> On 30. 04. 20, 8:43, Arseny Maslennikov wrote:
> > If the three termios local flags isig, icanon, iexten are enabled
> > and the local flag nokerninfo is disabled for a tty governed
> > by the n_tty line discipline, then on receiving the keyboard status
> > character n_tty will generate a status message and write it out to
> > the tty before sending SIGINFO to the tty's foreground process group.
> >=20
> > This kerninfo line contains information about the current system load
> > as well as some properties of "the most interesting" process in the
> > tty's current foreground process group, namely:
> >  - its PID as seen inside its deepest PID namespace;
> >    * the whole process group ought to be in a single PID namespace,
> >      so this is actually deterministic
> >  - its saved command name truncated to 16 bytes (task_struct::comm);
> >    * at the time of writing TASK_COMM_LEN =3D=3D 16
> >  - its state and some related bits, procps-style;
> >  - for S and D: its symbolic wait channel, if available; or a short
> >    description for other process states instead;
> >  - its user, system and real rusage time values;
> >  - its resident set size (as well as the high watermark) in kilobytes.
> >=20
> > The "most interesting" process is chosen as follows:
> >  - runnables over everything
> >  - uninterruptibles over everything else
> >  - among 2 runnables pick the biggest utime + stime
> >  - any unresolved ties are decided in favour of greatest PID.
> >=20
> > While the kerninfo line is not very useful for debugging the kernel
> > itself, since we have much more powerful debugging tools, it still gives
> > the user behind the terminal some meaningful feedback to a VSTATUS that
> > works even if no processes respond.
>=20
> Care to append an example output to the commit message?

$ cat
load: 0.32; 1108279/cat: S 0.524r 0.000u 0.000s 700k/700k=20
load: 0.32; 1108279/cat: S 1.873r 0.000u 0.000s 700k/700k=20
$ sha256sum /dev/zero
load: 0.32; 1108298/sha256sum: R! 1.302r 1.274u 0.015s 700k/700k=20
load: 0.32; 1108298/sha256sum: R! 2.445r 2.378u 0.055s 700k/700k=20
load: 0.32; 1108298/sha256sum: R! 3.309r 3.226u 0.071s 700k/700k=20
load: 0.42; 1108298/sha256sum: R! 14.547r 14.340u 0.195s 700k/700k=20
^C

Here I pressed ^T 2 times before supplying EOF to cat and 4 times before
interrupting sha256sum.

An example with a patched sleep:
% sleep 8
load: 0.04; 66573/sleep: S [hrtimer_nanosleep] 0.92r 0.00u 0.00s 1544k/1544k
sleep: about 7 second(s) left out of the original 8
load: 0.04; 66573/sleep: S [hrtimer_nanosleep] 2.61r 0.00u 0.00s 1552k/1552k
sleep: about 5 second(s) left out of the original 8
load: 0.04; 66573/sleep: S [hrtimer_nanosleep] 3.44r 0.00u 0.00s 1552k/1552k
sleep: about 4 second(s) left out of the original 8
load: 0.04; 66573/sleep: S [hrtimer_nanosleep] 3.65r 0.00u 0.00s 1552k/1552k
sleep: about 4 second(s) left out of the original 8
load: 0.04; 66573/sleep: S [hrtimer_nanosleep] 4.30r 0.00u 0.00s 1552k/1552k
sleep: about 3 second(s) left out of the original 8
load: 0.04; 66573/sleep: S [hrtimer_nanosleep] 4.72r 0.00u 0.00s 1552k/1552k
sleep: about 3 second(s) left out of the original 8
load: 0.04; 66573/sleep: S [hrtimer_nanosleep] 5.44r 0.00u 0.00s 1552k/1552k
sleep: about 2 second(s) left out of the original 8
load: 0.04; 66573/sleep: S [hrtimer_nanosleep] 5.57r 0.00u 0.00s 1552k/1552k
sleep: about 2 second(s) left out of the original 8
load: 0.04; 66573/sleep: S [hrtimer_nanosleep] 6.02r 0.00u 0.00s 1552k/1552k
sleep: about 1 second(s) left out of the original 8
load: 0.04; 66573/sleep: S [hrtimer_nanosleep] 6.15r 0.00u 0.00s 1552k/1552k
sleep: about 1 second(s) left out of the original 8
load: 0.04; 66573/sleep: S [hrtimer_nanosleep] 6.23r 0.00u 0.00s 1552k/1552k
sleep: about 1 second(s) left out of the original 8
load: 0.04; 66573/sleep: S [hrtimer_nanosleep] 7.20r 0.00u 0.00s 1552k/1552k
sleep: about 0 second(s) left out of the original 8

Another short example:

$ cat <<EOX zombospawner.c
#include <unistd.h>
#include <stdio.h>
#include <error.h>
#include <errno.h>

int main(int argc, char* argv[]) {
        char* prog;
        int e;

        if (argc <=3D 1) return -1;

        fprintf(stderr, "[my pid is %d]\n", getpid());
        e =3D fork();
        if (e)
                for (;;) sleep(4);

        fprintf(stderr, "[and my pid is %d. Will i become a Z?]\n", getpid(=
));
        e =3D execv(argv[1], argv+1);
        error(e, errno, "oops");
 }
EOX
$ gcc zombospawner.c -o zombospawner
$ ./zombospawner xx
[my pid is 1109004]
[and my pid is 1109005. Will i become a Z?]
=2E/zombospawner: oops: No such file or directory
load: 1.35; 1109005/zombospawner: Z (zombie; ppid=3D1109004) 3.443r 0.000u =
0.000s=20
load: 1.35; 1109005/zombospawner: Z (zombie; ppid=3D1109004) 3.743r 0.000u =
0.000s=20
load: 1.32; 1109005/zombospawner: Z (zombie; ppid=3D1109004) 5.175r 0.000u =
0.000s=20
^C

But you're right, this should be in the commit message, since it makes
little sense to me to devote to this its own Documentation/ page.

>=20
> > Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
> ...
> > index f72a3fd4b..905cdd985 100644
> > --- a/drivers/tty/n_tty.c
> > +++ b/drivers/tty/n_tty.c
> > @@ -79,6 +80,8 @@
> >  #define ECHO_BLOCK		256
> >  #define ECHO_DISCARD_WATERMARK	N_TTY_BUF_SIZE - (ECHO_BLOCK + 32)
> > =20
> > +#define STATUS_LINE_LEN (2 * KSYM_NAME_LEN)
>=20
> It's too magic constant.

The line to be constructed can optionally contain a kernel symbol name,
which is not longer than KSYM_NAME_LEN, and the effective size of all
the other characters together is also less than KSYM_NAME_LEN =E2=80=94 that
includes:
* "load: ", which is 6 bytes;
* the load average and the ';', which takes from 5 bytes if LA < 10 to
  13 bytes for a billion CPU cores (huh!) and scales logarithmically;
* the decimal PID nr, which is not longer than 9 bytes;
* the comm, which is not longer than TASK_COMM_LEN;
* the ": S ", which is 4 bytes;
* the rusage values, each of those 3 is at least 7 bytes and scales
  at most logarithmically with seconds elapsed.
6 + 13 + 9 + 16 (comm) + 4 + 51 is 99 < 128, and this assumes close-to
worst case for 10-char-long decimals for all the times and the PID.

Instead of a kernel symbol name, the middle "wchan" field can show
things like "zombie; ppid=3D123456 reaper=3D98765", which generally take
much less space than KSYM_NAME_LEN (most kernel symbol names that
processes sleep at also take less space).

So realistically we're not hitting the specified generous limit, which
is 256 bytes. Another reason for that number is, since the memory chunk
is short-lived, it makes little sense to kmalloc less.

If some time later we miraculously do hit the 256 char limit, the line
will just get truncated.

>=20
> > @@ -2489,6 +2496,21 @@ static int n_tty_ioctl(struct tty_struct *tty, s=
truct file *file,
> >  	}
> >  }
> > =20
> > +static void n_tty_status_line(struct tty_struct *tty)
> > +{
> > +	struct n_tty_data *ldata =3D tty->disc_data;
> > +	char *msg, *buf;
> > +	msg =3D buf =3D kzalloc(STATUS_LINE_LEN, GFP_KERNEL);
> > +	tty_sprint_status_line(tty, buf + 1, STATUS_LINE_LEN - 1);
> > +	/* The only current caller of this takes output_lock for us. */
>=20
> So add a lockdep assertion?

Yes, this is a good idea. I added an assertion in a similar situation in
6/7, but hesitated here.

>=20
> > +	if (ldata->column !=3D 0)
> > +		*msg =3D '\n';
> > +	else
> > +		msg++;
> > +	do_n_tty_write(tty, NULL, msg, strlen(msg));
> > +	kfree(buf);
> > +}
> > +
> >  static struct tty_ldisc_ops n_tty_ops =3D {
> >  	.magic           =3D TTY_LDISC_MAGIC,
> >  	.name            =3D "n_tty",
> > diff --git a/drivers/tty/n_tty_status.c b/drivers/tty/n_tty_status.c
> > new file mode 100644
> > index 000000000..d92261bbe
> > --- /dev/null
> > +++ b/drivers/tty/n_tty_status.c
> > @@ -0,0 +1,338 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> > +#include <linux/kallsyms.h>
> > +#include <linux/pid.h>
> > +#include <linux/sched.h>
> > +#include <linux/sched/signal.h>
> > +#include <linux/sched/loadavg.h>
> > +#include <linux/sched/cputime.h>
> > +#include <linux/sched/mm.h>
> > +#include <linux/slab.h>
> > +#include <linux/tty.h>
> > +
> > +#define BCOMPARE(lbool, rbool) ((lbool) << 1 | (rbool))
> > +#define BCOMPARE_NONE 0
> > +#define BCOMPARE_RIGHT 1
> > +#define BCOMPARE_LEFT 2
> > +#define BCOMPARE_BOTH (BCOMPARE_LEFT | BCOMPARE_RIGHT)
> > +
> > +/*
> > + * Select the most interesting task of two.
> > + *
> > + * The implemented approach is simple for now:
> > + * - pick runnable
> > + * - if no runnables, pick uninterruptible
> > + * - if tie between runnables, pick highest utime + stime
> > + * - if a tie is not broken by the above, pick highest pid nr.
> > + *
> > + * For reference, here's the one used in FreeBSD:
> > + * - pick runnables over anything
> > + * - if both runnables, pick highest cpu utilization
> > + * - if no runnables, pick shortest sleep time (the scheduler
> > + *   actually takes care to maintain this statistic)
> > + * - other ties are decided in favour of youngest process.
> > + */
> > +static struct task_struct *__better_proc_R(struct task_struct *a,
>=20
> Why so weird name __better_proc_R?
>=20

Please see below.

> > +		struct task_struct *b)
> > +{
> > +	unsigned long flags;
> > +	u64 atime, btime, tgutime, tgstime;
> > +	struct task_struct *ret;
> > +
> > +	if (!lock_task_sighand(a, &flags))
> > +		goto out_a_unlocked;
> > +	thread_group_cputime_adjusted(a, &tgutime, &tgstime);
> > +	atime =3D tgutime + tgstime;
> > +	unlock_task_sighand(a, &flags);
> > +
> > +	if (!lock_task_sighand(b, &flags))
> > +		goto out_b_unlocked;
> > +	thread_group_cputime_adjusted(b, &tgutime, &tgstime);
> > +	btime =3D tgutime + tgstime;
> > +	unlock_task_sighand(b, &flags);
> > +
> > +	ret =3D atime > btime ? a : b;
> > +
> > +	return ret;
> > +
> > +out_b_unlocked:
> > +out_a_unlocked:
> > +	return task_pid_vinr(a) > task_pid_vinr(b) ? a : b;
> > +}
> > +
> > +static struct task_struct *__better_proc(struct task_struct *a,
>=20
> Again, why "__" in the name?

Does the prefix __ have a very special meaning so it cannot be used
here, in a static symbol?
I'm sorry if it does, Documentation/process/coding-style.rst does not
warn against it.
I used it to generally mean "wrapped implementation detail".


>=20
> > +		struct task_struct *b)
> > +{
> > +	if (!pid_alive(a))
> > +		return b;
> > +	if (!pid_alive(b))
> > +		return a;
> > +
> > +	switch (BCOMPARE(a->state =3D=3D TASK_RUNNING,
> > +			b->state =3D=3D TASK_RUNNING)) {
> > +	case BCOMPARE_LEFT:
> > +		return a;
> > +	case BCOMPARE_RIGHT:
> > +		return b;
> > +	case BCOMPARE_BOTH:
> > +		return __better_proc_R(a, b);
> > +	}
>=20
> Doesn't this look saner and better:
>=20
> if (a->state =3D=3D TASK_RUNNING && b->state =3D=3D TASK_RUNNING)
>   return __better_proc_R(a, b);
> if (a->state =3D=3D TASK_RUNNING)
>   return a;
> if (b->state =3D=3D TASK_RUNNING)
>   return b;
>=20
> ?
>=20
> And one doesn't need to decrypt the defines.

I felt like the version with ifs would read worse.
No problem changing this.

>=20
> > +	switch (BCOMPARE(a->state =3D=3D TASK_UNINTERRUPTIBLE,
> > +			b->state =3D=3D TASK_UNINTERRUPTIBLE)) {
> > +	case BCOMPARE_LEFT:
> > +		return a;
> > +	case BCOMPARE_RIGHT:
> > +		return b;
> > +	case BCOMPARE_BOTH:
> > +		break;
>=20
> dtto.
>=20
> > +	}
> > +
> > +	/* TODO: Perhaps we should check something else... */
> > +	return task_pid_vinr(a) > task_pid_vinr(b) ? a : b;
> > +}
> > +
> > +/* Weed out NULLs. */
> > +static inline struct task_struct *better_proc(struct task_struct *a,
> > +		struct task_struct *b) {
> > +	return a ? (b ? __better_proc(a, b) : a) : b;
>=20
> This urgently calls for ifs and not ternany operators.
>=20
> Actually you don't need this helper at all. Check a and b in the same if
> as the respective !pid_alive above.
>=20
> > +}
> > +
> > +static int scnprint_load(char *msgp, size_t size)
> > +{
> > +	unsigned long la[3];
> > +
> > +	get_avenrun(la, FIXED_1/200, 0);
> > +	return scnprintf(msgp, size, "load: %lu.%02lu; ",
> > +			LOAD_INT(la[0]), LOAD_FRAC(la[0]));
> > +}
> > +
> > +static int scnprint_task(char *msgp, size_t size, struct task_struct *=
task)
> > +{
> > +	char commname[TASK_COMM_LEN];
> > +
> > +	get_task_comm(commname, task);
> > +	return scnprintf(msgp, size, "%d/%s:", task_pid_vinr(task), commname);
> > +}
> > +
> > +static int scnprint_rusage(char *msgp, ssize_t size,
> > +		struct task_struct *task, struct mm_struct *mm)
> > +{
> > +	struct rusage ru;
> > +	struct timespec64 utime, stime;
> > +	struct timespec64 rtime;
> > +	u64 now;
> > +	int ret =3D 0;
> > +	int psz =3D 0;
> > +
> > +	getrusage(task, RUSAGE_BOTH, &ru);
> > +	now =3D ktime_get_ns();
> > +
> > +	utime.tv_sec =3D ru.ru_utime.tv_sec;
> > +	utime.tv_nsec =3D ru.ru_utime.tv_usec * NSEC_PER_USEC;
> > +	stime.tv_sec =3D ru.ru_stime.tv_sec;
> > +	stime.tv_nsec =3D ru.ru_stime.tv_usec * NSEC_PER_USEC;
> > +
> > +	rtime =3D ns_to_timespec64(now - task->start_time);
> > +
> > +	psz =3D scnprintf(msgp, size,
> > +			"%llu.%03lur %llu.%03luu %llu.%03lus",
> > +			rtime.tv_sec, rtime.tv_nsec / NSEC_PER_MSEC,
> > +			utime.tv_sec, utime.tv_nsec / NSEC_PER_MSEC,
> > +			stime.tv_sec, stime.tv_nsec / NSEC_PER_MSEC);
> > +	ret +=3D psz;
> > +	msgp +=3D psz;
> > +	size -=3D psz;
> > +
> > +	if (mm) {
> > +		psz =3D scnprintf(msgp, size,
> > +				" %luk/%luk",
> > +				get_mm_rss(mm) * PAGE_SIZE / 1024,
> > +				get_mm_hiwater_rss(mm) * PAGE_SIZE / 1024);
> > +		ret +=3D psz;
> > +	}
> > +	return ret;
> > +}
> > +
> > +static int scnprint_state(char *msgp, ssize_t size,
> > +		struct task_struct *task, struct mm_struct *mm)
> > +{
> > +	char stat[8] =3D {0};
> > +	const char *state_descr =3D "";
> > +	struct task_struct *parent =3D NULL;
> > +	struct task_struct *real_parent =3D NULL;
> > +	unsigned long wchan =3D 0;
> > +	int psz =3D 0;
> > +	char symname[KSYM_NAME_LEN];
> > +
> > +	stat[psz++] =3D task_state_to_char(task);
> > +	if (task_nice(task) < 0)
> > +		stat[psz++] =3D '<';
> > +	else if (task_nice(task) > 0)
> > +		stat[psz++] =3D 'N';
> > +	if (mm && mm->locked_vm)
> > +		stat[psz++] =3D 'L';
> > +	if (get_nr_threads(task) > 1)
> > +		stat[psz++] =3D 'l';
> > +
> > +	switch (stat[0]) {
> > +	case 'R':
> > +		if (task_curr(task))
> > +			stat[psz++] =3D '!';
> > +		break;
> > +	case 'S':
> > +	case 'D':
> > +		wchan =3D get_wchan(task);
> > +		if (!wchan)
> > +			break;
> > +		if (!lookup_symbol_name(wchan, symname))
> > +			state_descr =3D symname;
> > +		else
> > +			/* get_wchan() returned something
> > +			 * that looks like no kernel symbol.
> > +			 */
> > +			state_descr =3D "*unknown*";
> > +		break;
> > +	case 'T':
> > +		state_descr =3D "stopped";
> > +		break;
> > +	case 't':
> > +		state_descr =3D "traced";
> > +		break;
> > +	case 'Z':
> > +		rcu_read_lock();
> > +		real_parent =3D rcu_dereference(task->real_parent);
> > +		parent =3D rcu_dereference(task->parent);
> > +		psz =3D sprintf(symname, "zombie; ppid=3D%d",
> > +			task_tgid_nr_ns(real_parent,
> > +				ns_of_pid(task_pid(task))));
> > +		if (parent !=3D real_parent)
> > +			sprintf(symname + psz, " reaper=3D%d",
> > +				task_tgid_nr_ns(parent,
> > +					ns_of_pid(task_pid(task))));
> > +		rcu_read_unlock();
> > +		state_descr =3D symname;
> > +		break;
> > +	case 'I':
> > +		/* Can this even happen? */
> > +		state_descr =3D "idle";
> > +		break;
> > +	default:
> > +		state_descr =3D "unknown";
> > +	}
> > +
> > +	psz =3D scnprintf(msgp, size, "%s", stat);
> > +	msgp +=3D psz;
> > +	size -=3D psz;
> > +	if (*state_descr)
> > +		psz +=3D scnprintf(msgp, size, wchan ? " [%s]" : " (%s)", state_desc=
r);
> > +
> > +	return psz;
> > +}
> > +
> > +/**
> > + *	tty_sprint_status_line	-		produce kerninfo line
> > + *	@tty: terminal device
> > + *	@msg: preallocated memory buffer
> > + *	@length: maximum line length
> > + *
> > + *	Reports state of foreground process group in a null-terminated stri=
ng
> > + *	located at @msg, @length bytes long. If @length is insufficient,
> > + *	the line gets truncated.
> > + */
> > +void tty_sprint_status_line(struct tty_struct *t, char *msg, size_t le=
ngth)
> > +{
> > +	struct task_struct *tsk =3D NULL, *mit =3D NULL;
> > +	struct mm_struct *mm;
> > +	struct pid *pgrp =3D NULL;
> > +	char *msgp =3D msg;
> > +	int psz =3D 0;
> > +
> > +	if (!length)
> > +		return;
> > +	length--; /* Make room for trailing '\n' */
> > +
> > +	psz =3D scnprint_load(msgp, length);
> > +	if (psz > 0) {
> > +		msgp +=3D psz;
> > +		length -=3D psz;
> > +	}
> > +	if (!length)
> > +		goto finalize_message;
> > +
> > +	/* Not sure if session pid is protected by ctrl_lock
> > +	 * or tasklist_lock...
> > +	 */
> > +	pgrp =3D t->session;
> > +	if (pgrp =3D=3D NULL) {
> > +		psz =3D scnprintf(msgp, length, "not a controlling tty");
> > +		if (psz > 0)
> > +			msgp +=3D psz;
> > +		goto finalize_message;
> > +	}
> > +	pgrp =3D tty_get_pgrp(t);
> > +	if (pgrp =3D=3D NULL) {
> > +		psz =3D scnprintf(msgp, length, "no foreground process group");
> > +		if (psz > 0)
> > +			msgp +=3D psz;
> > +		goto finalize_message;
> > +	}
> > +
> > +	read_lock(&tasklist_lock);
> > +	do_each_pid_task(pgrp, PIDTYPE_PGID, tsk)
> > +	{
> > +		/* Select the most interesting task. */
> > +		if (tsk =3D=3D better_proc(mit, tsk))
> > +			mit =3D tsk;
> > +	} while_each_pid_task(pgrp, PIDTYPE_PGID, tsk);
> > +	read_unlock(&tasklist_lock);
> > +
> > +	if (!pid_alive(mit))
> > +		goto finalize_message;
> > +
> > +	/* Gather intel on most interesting task. */
> > +	/* Can the mm of a foreground process turn out to be NULL?
> > +	 * Definitely; for example, if it is a zombie.
> > +	 */
> > +	mm =3D get_task_mm(mit);
> > +
> > +	psz =3D scnprint_task(msgp, length, mit);
> > +	if (psz > 0) {
> > +		msgp +=3D psz;
> > +		length -=3D psz;
> > +	}
> > +	if (!length)
> > +		goto finalize_message;
> > +	*msgp++ =3D ' ';
> > +	length--;
> > +
> > +	psz =3D scnprint_state(msgp, length, mit, mm);
> > +	if (psz > 0) {
> > +		msgp +=3D psz;
> > +		length -=3D psz;
> > +	}
> > +	if (!length)
> > +		goto finalize_message;
> > +	*msgp++ =3D ' ';
> > +	length--;
> > +
> > +	psz =3D scnprint_rusage(msgp, length, mit, mm);
> > +	if (psz > 0) {
> > +		msgp +=3D psz;
> > +		length -=3D psz;
> > +	}
> > +	if (!length)
> > +		goto finalize_message;
> > +	*msgp++ =3D ' ';
> > +	length--;
> > +
> > +	if (!mm)
> > +		goto finalize_message;
> > +
> > +	mmput(mm);
> > +
> > +finalize_message:
> > +	*msgp++ =3D '\n';
> > +	if (pgrp)
> > +		put_pid(pgrp);
> > +}
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 4418f5cb8..195abd47d 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1318,6 +1318,8 @@ static inline struct pid *task_pid(struct task_st=
ruct *task)
> >   * task_xid_nr()     : global id, i.e. the id seen from the init names=
pace;
> >   * task_xid_vnr()    : virtual id, i.e. the id seen from the pid names=
pace of
> >   *                     current.
> > + * task_xid_vinr()   : virtual inner id, i.e. the id seen from the nam=
espace of
> > + *                     the task itself;
> >   * task_xid_nr_ns()  : id seen from the ns specified;
> >   *
> >   * see also pid_nr() etc in include/linux/pid.h
> > @@ -1339,6 +1341,11 @@ static inline pid_t task_pid_vnr(struct task_str=
uct *tsk)
> >  	return __task_pid_nr_ns(tsk, PIDTYPE_PID, NULL);
> >  }
> > =20
> > +static inline pid_t task_pid_vinr(struct task_struct *tsk)
> > +{
> > +	return __task_pid_nr_ns(tsk, PIDTYPE_PID, ns_of_pid(task_pid(tsk)));
> > +}
> > +
>=20
> This smells like it should be done in a separate patch.

OK, no problem.
This also solves the over-cc consideration mentioned above.

>=20
> >  static inline pid_t task_tgid_nr(struct task_struct *tsk)
> >  {
> > diff --git a/include/linux/tty.h b/include/linux/tty.h
> > index 3499845ab..2023addaf 100644
> > --- a/include/linux/tty.h
> > +++ b/include/linux/tty.h
> > @@ -727,6 +727,9 @@ extern void __init n_tty_init(void);
> >  static inline void n_tty_init(void) { }
> >  #endif
> > =20
> > +/* n_tty_status.c */
> > +extern void tty_sprint_status_line(struct tty_struct *tty, char *msg, =
size_t size);
>=20
> No need for extern.

Will fix, thanks.

>=20
> thanks,
> --=20
> js
> suse labs

--07FIeBX8hApXX6Bi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE56JD3UKTLEu/ddrm9dQjyAYL01AFAl6qlXAACgkQ9dQjyAYL
01DeYQ/+NAlkhTyfiDh2PiaPNM1ts1e9pve+VKoJprITe+zQWlkU87gDMx8cmVz/
EB6sgGobYchsWtiUHTlnZ00bunWirRgc/1Jh2PqYhy6rMJK976yI4L0oj6tjA+iO
MRNHdcOsuAzhNW1pwXOll0nY+KO+voN00PZ4ywLIRFPL0qjHu2gIb8Bgq/c8ZFdt
QX2wOY4/W4j8FEgWoViQcd2Yag5s9XdvV780AcFAYwtYF53Fi5+BUvydfgGTJDK1
05y6IAyIolNzfch+J4wqukMZShEVFqluXLEfhmrqwx17dhwofPhyk53LKnT0uMn9
N3g+Xz4WQl4Zlcg+5/4NQXY/BkPiYnCKTbYki1AZDyb7WF5EEQPrUksZ97oexY+z
BNLa3o9Q2A0HQBGBTQ4LbwbsIAruXSTba1ZdRS7lsNCfRdMkrwrU6USgb1BYHdan
Q0EOeljr6scyLI44Z3LRHiQMDwo6AW1V6GTkk5AerUwoIsNl5kg2t76zvylwjK96
/bfKta7ez1tBDna1FCJglBAprpTZdGq2LSSVzwpaMEcQtR5J4EWYwpmh50ITFFee
ZtEfxIOxvDZbsBB7SedAHGYnM/Wzpsfs9/m1Or/vA1I+3J4Orr99LSVNo+pUDKii
xhOEEOgpkpsyWBq20e4S7VwIJgLNUCZj+z6WqEBCJ+rdC6SWPO4=
=5oWZ
-----END PGP SIGNATURE-----

--07FIeBX8hApXX6Bi--
