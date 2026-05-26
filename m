Return-Path: <linux-api+bounces-6416-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLa+HnYnFmqUiQcAu9opvQ
	(envelope-from <linux-api+bounces-6416-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 01:06:30 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B97DE5DD6BF
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 01:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEF0230421CE
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2026 23:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2471F3BB661;
	Tue, 26 May 2026 23:06:08 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7B93B1EC7;
	Tue, 26 May 2026 23:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779836768; cv=none; b=ZoAqO480LLW0bROpN7oN5Y9w/7jSqa3wzY1zYfj8ifJFdPZBcvnjorQnqE3QLwBqCeUC487X/eiKMpo/nfCcVRI5+3as0fPBNG70sdwTLBVLAzFiRbdnXt2KsMQjUEEeTjjfFbUTq4LiczbaoZQYxlNBE1JxdUjgCLrH0xJIlZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779836768; c=relaxed/simple;
	bh=87DTCckQTeX8m0zm3QQ0HMv6E4WeYxHqYEIyHzvamVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gCZ/FwPT8guEp4029z+tHf94PWMsq8eV2bNLDhhH68X2yT33HtKQUvU4aZgXlAsD9y/KNDqaLfCcvFAQi9iC3ubuTl93DFegRJEjgTSoQftQjGZ/1tCaG6RJPvgxQlqOePzDZWovcaU7+EPlroXB5Z4BOutQDu+8X2LWEy3Jkb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 4B8391C17AE;
	Tue, 26 May 2026 23:05:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 406AE42;
	Tue, 26 May 2026 23:05:53 +0000 (UTC)
Date: Tue, 26 May 2026 19:06:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>, Shuah
 Khan <shuah@kernel.org>, willy@infradead.org,
 mathieu.desnoyers@efficios.com, David Laight
 <david.laight.linux@gmail.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, akpm@linux-foundation.org, Yafang Shao
 <laoar.shao@gmail.com>, andrii.nakryiko@gmail.com, arnaldo.melo@gmail.com,
 Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, linux-mm@kvack.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v2 3/6] treewide: Replace memcpy(..., current->comm)
 with strscpy()
Message-ID: <20260526190625.3f4aca0a@gandalf.local.home>
In-Reply-To: <20260524-tonyk-long_name-v2-3-332f6bd041c4@igalia.com>
References: <20260524-tonyk-long_name-v2-0-332f6bd041c4@igalia.com>
	<20260524-tonyk-long_name-v2-3-332f6bd041c4@igalia.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: 7kge4d87g167zqmt9heo8s65kuus59x7
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX198cU+0hhRKHgHKCMGLiBRPea5RXN7Pa8Q=
X-HE-Tag: 1779836753-129925
X-HE-Meta: U2FsdGVkX1/HAlOe/gblRw+FZXAPz9aej4jZ5+qyN3IcF8eNqN8XtKUl9dtjJYbiVCa9qB8xOz8RSl8BKxIfrBXXKl/53pbAujRrubHFyvoWaOSh+p8/OxEHMlfhY5WwQXXNzez9ODxnM6sxMlxKWtVhL/tCJWEldrcmI/rkr4XcYdSBP1rAdLVNIJfU582Ivbj7bDwVXcIOHZfPO5PF/GOJK5xl1kt1mKnH7FyxI6TKS812kwImkYcBfg86KS476A18d1wmpRLaXGvV0+APnu4B2VPcH3FoAXiZo4wLr8+GEjEHbihz/oNlHHHqWNzWzilqWNFWKqNgKVxZHfbbJFHYJkVtpbMXcYQsAJxBOYgmrQC0U4pfYk/nW318yKL/
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[goodmis.org : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6416-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,linaro.org,kernel.org,efficios.com,gmail.com,linux-foundation.org,suse.com,vger.kernel.org,igalia.com,kvack.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@goodmis.org,linux-api@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[linux-api];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B97DE5DD6BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 24 May 2026 19:38:53 -0300
Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:

> In order to increase the size of current->comm[] and to avoid breaking any
> existing code, replace memcpy() with strscpy(). The later function makes
> sure that the copy is NUL terminated. This is crucial given that the
> source buffer might be larger than the destination buffer and could
> truncate the NUL character out of it.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
> Changes from v2:
>  - New patch, dropped strtostr() from last version
> ---
>  include/linux/coredump.h        |  2 +-
>  include/linux/tracepoint.h      |  4 ++--
>  include/trace/events/block.h    | 10 +++++-----
>  include/trace/events/coredump.h |  2 +-
>  include/trace/events/f2fs.h     |  4 ++--
>  include/trace/events/oom.h      |  2 +-
>  include/trace/events/osnoise.h  |  2 +-
>  include/trace/events/sched.h    | 10 +++++-----
>  include/trace/events/signal.h   |  2 +-
>  include/trace/events/task.h     |  4 ++--
>  kernel/printk/nbcon.c           |  2 +-
>  kernel/printk/printk.c          |  2 +-
>  12 files changed, 23 insertions(+), 23 deletions(-)
>=20

So I was curious to what impact this would have on tracing. I decided to
run the following:

    perf stat -r 100 ./hackbench 50

To see how it affects things. Hackbench is a bit of a microbenchmark but it
stresses the scheduler and thus, scheduler trace events.

I first ran the above and put the output into "stat.baseline", then I enabl=
ed
all scheduler trace events:

   trace-cmd start -e sched

and ran it again and put the output into "stat.before".

I applied the patch and ran it again before enabling tracing (just to see
the variance) and put that into "stat.baseline2". I then enabled tracing
and ran it again and put the output into "stat.after".

Here's the results:

stat.baseline:

 Performance counter stats for '/work/c/hackbench 50' (100 runs):

            53,165      context-switches                 #  11002.2 cs/sec =
 cs_per_second       ( +-  1.33% )
             8,010      cpu-migrations                   #   1657.6 migrati=
ons/sec  migrations_per_second  ( +-  0.90% )
            53,936      page-faults                      #  11161.7 faults/=
sec  page_faults_per_second  ( +-  0.50% )
          4,832.24 msec task-clock                       #      6.0 CPUs  C=
PUs_utilized         ( +-  0.12% )
        18,787,710      branch-misses                    #      1.2 %  bran=
ch_miss_rate         ( +-  0.17% )  (38.88%)
     1,452,653,496      branches                         #    300.6 M/sec  =
branch_frequency     ( +-  0.14% )  (61.55%)
    15,607,564,080      cpu-cycles                       #      3.2 GHz  cy=
cles_frequency       ( +-  0.15% )  (56.21%)
     7,648,608,518      instructions                     #      0.5 instruc=
tions  insn_per_cycle  ( +-  0.11% )  (55.82%)
    12,025,223,911      stalled-cycles-frontend          #     0.77 fronten=
d_cycles_idle        ( +-  0.14% )  (56.26%)

       0.808204663 +- 0.001059873 seconds time elapsed  ( +-  0.13% )

stat.before:

 Performance counter stats for '/work/c/hackbench 50' (100 runs):

            54,722      context-switches                 #  11041.0 cs/sec =
 cs_per_second       ( +-  1.35% )
             8,170      cpu-migrations                   #   1648.4 migrati=
ons/sec  migrations_per_second  ( +-  1.08% )
            54,295      page-faults                      #  10954.8 faults/=
sec  page_faults_per_second  ( +-  0.53% )
          4,956.27 msec task-clock                       #      6.0 CPUs  C=
PUs_utilized         ( +-  0.14% )
        19,304,657      branch-misses                    #      1.2 %  bran=
ch_miss_rate         ( +-  0.20% )  (37.27%)
     1,497,794,368      branches                         #    302.2 M/sec  =
branch_frequency     ( +-  0.17% )  (60.74%)
    16,037,658,236      cpu-cycles                       #      3.2 GHz  cy=
cles_frequency       ( +-  0.16% )  (57.72%)
     7,875,024,533      instructions                     #      0.5 instruc=
tions  insn_per_cycle  ( +-  0.13% )  (57.83%)
    12,344,722,147      stalled-cycles-frontend          #     0.77 fronten=
d_cycles_idle        ( +-  0.17% )  (55.77%)

       0.827636161 +- 0.001027531 seconds time elapsed  ( +-  0.12% )


stat.baseline2:

 Performance counter stats for '/work/c/hackbench 50' (100 runs):

            52,590      context-switches                 #  10837.7 cs/sec =
 cs_per_second       ( +-  1.18% )
             7,958      cpu-migrations                   #   1640.0 migrati=
ons/sec  migrations_per_second  ( +-  0.99% )
            53,819      page-faults                      #  11090.9 faults/=
sec  page_faults_per_second  ( +-  0.48% )
          4,852.52 msec task-clock                       #      6.0 CPUs  C=
PUs_utilized         ( +-  0.11% )
        18,933,395      branch-misses                    #      1.2 %  bran=
ch_miss_rate         ( +-  0.18% )  (37.13%)
     1,451,361,950      branches                         #    299.1 M/sec  =
branch_frequency     ( +-  0.13% )  (60.09%)
    15,683,586,735      cpu-cycles                       #      3.2 GHz  cy=
cles_frequency       ( +-  0.13% )  (56.05%)
     7,628,894,710      instructions                     #      0.5 instruc=
tions  insn_per_cycle  ( +-  0.10% )  (57.22%)
    12,063,750,082      stalled-cycles-frontend          #     0.77 fronten=
d_cycles_idle        ( +-  0.14% )  (57.11%)

       0.811536383 +- 0.001337259 seconds time elapsed  ( +-  0.16% )

stat.after:

 Performance counter stats for '/work/c/hackbench 50' (100 runs):

            53,799      context-switches                 #  10743.3 cs/sec =
 cs_per_second       ( +-  1.35% )
             8,095      cpu-migrations                   #   1616.5 migrati=
ons/sec  migrations_per_second  ( +-  0.86% )
            54,330      page-faults                      #  10849.4 faults/=
sec  page_faults_per_second  ( +-  0.55% )
          5,007.67 msec task-clock                       #      6.0 CPUs  C=
PUs_utilized         ( +-  0.13% )
        19,444,339      branch-misses                    #      1.2 %  bran=
ch_miss_rate         ( +-  0.21% )  (38.04%)
     1,504,382,421      branches                         #    300.4 M/sec  =
branch_frequency     ( +-  0.17% )  (60.42%)
    16,225,153,060      cpu-cycles                       #      3.2 GHz  cy=
cles_frequency       ( +-  0.16% )  (56.19%)
     7,889,645,005      instructions                     #      0.5 instruc=
tions  insn_per_cycle  ( +-  0.16% )  (56.30%)
    12,488,115,947      stalled-cycles-frontend          #     0.77 fronten=
d_cycles_idle        ( +-  0.16% )  (55.55%)

       0.835123855 +- 0.001015781 seconds time elapsed  ( +-  0.12% )


Looking at the difference between cpu-cycles of baseline and baseline2, we =
have:

  15,607,564,080 vs 15,683,586,735 where it went up by 0.4% (in the noise).

But when enabling tracing, we have between before and after:

  16,037,658,236 vs 16,225,153,060 which is 1.1%. May be low but not insign=
ificant.

Where tracing enabled slowed the code down by 2.7% (16,037,658,236 vs 15,60=
7,564,080)
having another 1% is quite an impact!

As tracing now slows it down by 3.9% which is a significant increase from 2=
.7%

I really rather keep memcpy() here.

-- Steve

