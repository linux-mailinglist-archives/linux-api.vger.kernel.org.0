Return-Path: <linux-api+bounces-6401-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eP7qAngnFGrfKAcAu9opvQ
	(envelope-from <linux-api+bounces-6401-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2026 12:42:00 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 581915C9519
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2026 12:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4F8A3001B62
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2026 10:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD9B360722;
	Mon, 25 May 2026 10:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYTqAaJx"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCABA354AE3
	for <linux-api@vger.kernel.org>; Mon, 25 May 2026 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779705673; cv=none; b=lb3CBkfD2BHAsWjhiSExqIXkXx+pvNG23pQ2gf0KWRHO+hfqgVm258uK6CsFiEDSY+O89SdhsAyaUjTwet8ZZeT0vhJAuG2AysfsQyeYJk/Hks3eckDiZd621ElMzZLtXIgLs+nJQ/OGE0+jlcJRCp7HB6KKeUwF9sNsrvcSTyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779705673; c=relaxed/simple;
	bh=b8lhQfe3Q+bOi9iCNVtnKB8fDwLiL01OzSJK1dgBBgI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8ro0ORPtN7zokQ/b4AEsSCT8ItVCghi/q9Q0QarOH45BO03vFny399WxuwQLY5EZ+mOsf3txEJYTahSJSvojJYbG5k06ykkCvq5eFET0rpdvF2qMA3M8Re6GC6yLmFeLTjlcVwaL8M++Epah0Diw8VnQaPqRBtxSRxuRbmCbwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYTqAaJx; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-44ccbd3290aso8269599f8f.2
        for <linux-api@vger.kernel.org>; Mon, 25 May 2026 03:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779705670; x=1780310470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFLYe9us/Dsl57mEZ/B/rM5ImRHePLFDjoSpnJjwwkw=;
        b=UYTqAaJxzVw8iGcTlg8Vzspx606buHo46BkwX1HtPd6Xx2AeXFeGg/UobSvsfnLaRJ
         LyCax/I7Nzq+xxEuza8ydEOz8OKJbPX98PeZc3vtD/3XrVxtkD5D7JHYGS5XauPthVx5
         n9zA2hTKGjLXmstcWWgc+edgy7VebI+uv/0DUNWwuBX1nOhPBZey6D78ezwhou/k/Xuw
         Gl0hdHjZomi9Go1ukoqPidcDqUedopQAC4dM6cv9eLPq+kbS5aqte3CvNj3/xHmuga6u
         v/O7rEkJ1kN64XSMSxQPC6/Jn0MPRKLG9LyZGjggkgiTJasA4zySBdZtIxEgDb33f+2V
         tdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779705670; x=1780310470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SFLYe9us/Dsl57mEZ/B/rM5ImRHePLFDjoSpnJjwwkw=;
        b=cWQ01G2sjQ2pG8QHWI36dh2FHoRcgFBaD8kZQfWv+pbwYlSeRVOjioqdjDFlJm8QBq
         R5+9MqTXd1SLw+SDCbjutYAWYFgPDCN+UYQBRbh/EtlnNxjNoCU5oAF8qgpPUiKm7BL+
         LBl0PkScI373Qm0qR3J8JLLPAX43Uz0MuPQCDQIc8uRn4lwioI4MeXeJ7mNMeS39qLWT
         ZJZUXzkT9gMfvqAMx2rpIFfWi3IfL3DyvJx6seaCK2s2OVLKlm2RUpZebz7uqPFxJ1Uz
         CLpwy4d4wC0wIYoDzwA6J3W4IbxIoh1CPZi1fBR/Tk46ujPXxwNDfX8NIrTcDBdtfGjS
         NKAA==
X-Forwarded-Encrypted: i=1; AFNElJ9R0SOjY0PpYdP2q8d8M6RAaOYZ87pSl7BvlBHQc6jReJT+UjBrSyR0QtHq30l7xOghMkXqEoL/lE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6JhcICPC+rw9rT31TZtdaRroGnm+KUzaipIvTi09sRTuD0rF5
	m9ENP3m4D3yV3zFPu2bGRUW/w0u//itrjWqD6f4HsinByg3cFdQ2noiz
X-Gm-Gg: Acq92OHDu/gqOorSn+gMK2+Xv6KrxkUnCOccAsxI4mHrJq+CVVXAivz0dcT1WHF9iCw
	Bxk4JTF2JpRSp6aKksQDQR2fEVlr4o4QUtcY8uwDvUQ9/qz/RvlB9ns+GpC5msjlzLlAOU+91YN
	KrwEKKhtoQToTPqMM+zqG5zE//PnGrhQE+zCx21fan4n64v8B50DD+zcGHlhUY8G8OBRTCQ3WkR
	Ilw5Suj7zlkw2F5bmmC4PlqahSAZAZ3VxIxWb3Ltpms7ytttLox1QXaQKW3KVs5bPCTJHoGakq4
	OFJ89icDLe/evODAaf4hdzO8FFdmxjR84QbefWXQfI/I+5g5mAvF0WocJPLQQhvROdaB04U6EKW
	fNum5L/DqufXxgQjBtDI/Q70JBxRFsl2QPNPE2EEgwRkc9ylxkuolboN3jUJEVHL4hoe0zB26xM
	P6cY4LWBIYRGswTrR1g1e5mje+hpSnyvj+4sfK8123INAQOpiKsxPlIlbrAisp+eRK
X-Received: by 2002:a05:6000:4606:b0:45e:8727:be87 with SMTP id ffacd0b85a97d-45eb36aa72amr22395547f8f.15.1779705669622;
        Mon, 25 May 2026 03:41:09 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6cd1780sm27855882f8f.16.2026.05.25.03.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 03:41:09 -0700 (PDT)
Date: Mon, 25 May 2026 11:41:07 +0100
From: David Laight <david.laight.linux@gmail.com>
To: =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Christian Brauner
 <brauner@kernel.org>, Kees Cook <kees@kernel.org>, Shuah Khan
 <shuah@kernel.org>, willy@infradead.org, mathieu.desnoyers@efficios.com,
 Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org,
 Yafang Shao <laoar.shao@gmail.com>, andrii.nakryiko@gmail.com,
 arnaldo.melo@gmail.com, Petr Mladek <pmladek@suse.com>,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com, linux-mm@kvack.org,
 linux-api@vger.kernel.org, Bhupesh <bhupesh@igalia.com>
Subject: Re: [PATCH v2 4/6] sched: Extend task command name to 64 bytes
Message-ID: <20260525114107.7fa5b4c1@pumpkin>
In-Reply-To: <20260524-tonyk-long_name-v2-4-332f6bd041c4@igalia.com>
References: <20260524-tonyk-long_name-v2-0-332f6bd041c4@igalia.com>
	<20260524-tonyk-long_name-v2-4-332f6bd041c4@igalia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6401-lists,linux-api=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,linaro.org,goodmis.org,kernel.org,efficios.com,linux-foundation.org,gmail.com,suse.com,vger.kernel.org,igalia.com,kvack.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 581915C9519
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 24 May 2026 19:38:54 -0300
Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:

> Command name has been restrict to only 16 bytes, which is too limiting,
> specially when debugging and tracing complex software with thousands of
> threads and the need to differentiate them.
>=20
> Just as it was done with kthreads in commit 6b59808bfe48 ("workqueue:
> Show the latest workqueue name in /proc/PID/{comm,stat,status}"), support
> long names for userspace threads as well.
>=20
> To avoid buffer overflows, cap all existing userspace APIs to
> TASK_COMM_LEN, and leave the full extended name for a new interface.
>=20
> Co-developed-by: Bhupesh <bhupesh@igalia.com>
> Signed-off-by: Bhupesh <bhupesh@igalia.com>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  fs/proc/array.c       |  2 +-
>  include/linux/sched.h |  3 ++-
>  kernel/sys.c          | 10 +++++-----
>  3 files changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index c8c3fbd9bfa9..312371eddc7f 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -110,7 +110,7 @@ void proc_task_name(struct seq_file *m, struct task_s=
truct *p, bool escape)
>  	else if (p->flags & PF_KTHREAD)
>  		get_kthread_comm(tcomm, sizeof(tcomm), p);
>  	else
> -		strscpy_pad(tcomm, p->comm);
> +		strscpy_pad(tcomm, p->comm, TASK_COMM_LEN);
> =20
>  	if (escape)
>  		seq_escape_str(m, tcomm, ESCAPE_SPACE | ESCAPE_SPECIAL, "\n\\");
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index b6de742b1155..f7fd2b7d131d 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -323,6 +323,7 @@ struct user_event_mm;
>   */
>  enum {
>  	TASK_COMM_LEN =3D 16,
> +	TASK_COMM_EXT_LEN =3D 64,
>  };
> =20
>  extern void sched_tick(void);
> @@ -1167,7 +1168,7 @@ struct task_struct {
>  	 * - set it with set_task_comm() to ensure it is always
>  	 *   NUL-terminated and zero-padded
>  	 */
> -	char				comm[TASK_COMM_LEN];
> +	char				comm[TASK_COMM_EXT_LEN];
> =20
>  	struct nameidata		*nameidata;
> =20
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 1d5152d2395e..76d77218ab19 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2535,7 +2535,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, =
arg2, unsigned long, arg3,
>  		unsigned long, arg4, unsigned long, arg5)
>  {
>  	struct task_struct *me =3D current;
> -	unsigned char comm[sizeof(me->comm)];
> +	unsigned char comm[TASK_COMM_LEN];
>  	long error;
> =20
>  	error =3D security_task_prctl(option, arg2, arg3, arg4, arg5);
> @@ -2601,16 +2601,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long=
, arg2, unsigned long, arg3,
>  			error =3D -EINVAL;
>  		break;
>  	case PR_SET_NAME:
> -		comm[sizeof(me->comm) - 1] =3D 0;
> +		comm[TASK_COMM_LEN - 1] =3D 0;
>  		if (strncpy_from_user(comm, (char __user *)arg2,
> -				      sizeof(me->comm) - 1) < 0)
> +				      TASK_COMM_LEN - 1) < 0)

Nak - you can't do that.
You are reading data that the application doesn't expect you to read.

>  			return -EFAULT;
>  		set_task_comm(me, comm);
>  		proc_comm_connector(me);
>  		break;
>  	case PR_GET_NAME:
> -		strscpy_pad(comm, me->comm);
> -		if (copy_to_user((char __user *)arg2, comm, sizeof(comm)))
> +		strscpy_pad(comm, me->comm, TASK_COMM_LEN);
> +		if (copy_to_user((char __user *)arg2, comm, TASK_COMM_LEN))

Double-nak - you are writing beyond the end of the applications buffer.

You can't change the user memory that the syscalls access.

You can support the longer name for read/write of /proc/self/comm.

-- David

>  			return -EFAULT;
>  		break;
>  	case PR_GET_ENDIAN:
>=20


