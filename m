Return-Path: <linux-api+bounces-6402-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK+bKicoFGrfKAcAu9opvQ
	(envelope-from <linux-api+bounces-6402-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2026 12:44:55 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 003FA5C9555
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2026 12:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BECEB301778B
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2026 10:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827A236493F;
	Mon, 25 May 2026 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDLESzdv"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B6C364032
	for <linux-api@vger.kernel.org>; Mon, 25 May 2026 10:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779705768; cv=none; b=PGTM2kxZNXK8GeZJnZ+JYLOMoeDHmL9thzPKTHtN4/FKWk8yG0Fps6pRftkTbT5gokt7vX/moc8YZcGTYagXcgJ0GrGAesX8SwgVVnx3ne9uTZJHSV2sHI3N62Ldxj8XOLqElQT5kcMwmoTSgAbsPvA6n4QB6PtV0dEsTm2ELgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779705768; c=relaxed/simple;
	bh=ku8y9vd3yPYRGF0AX/sLztGjsUzSXbH5w1d1bDEIIRc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hyQEVIQpWh6VvW3Y7+cKPbHfr88f9R//IWt6JDXnwm+v1dj6dyBb2rGQimJctRKGCsxXzZvtwd7mFl7v3U/bj9bBVquBrMZdEcJZ6S+hvnKyHFnEGQdGDB26VitRCKy6yaetsvoyQtehcbsSriVP+yQGETlS3NFRzn9FNBl3p+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDLESzdv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49056b9f04aso21390095e9.0
        for <linux-api@vger.kernel.org>; Mon, 25 May 2026 03:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779705764; x=1780310564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zc9LvU3e/f54K4oHyIoq4+XKoWb/QRX1RMbSGSqgSQI=;
        b=JDLESzdvRDYf7bUq6zSAU/TVaNUhe7IAydptxUaYlhVWaW/rgco8FQY5tmBN5lGxsq
         FOwyHfjvS+SHrHJqo2/Ti8m8vb+3yd0hXq/YDerliGbmjhG16kn9fliWAjW5jGKbg7E0
         o1BBuLCtiEFmB/M3QvNu4dS0g+SgYiSdxTH6SoOuxzRsW++2aJjpCxwPZo50YqZmzzKV
         FkPZyarbcQ61WhO8MDatDBfuBft1BpXjL52RrtzhN2ME6FXPjPJ7ulc63mL5dj58n8NX
         UBKptAHBdp8KDuzbiH4VLxJHEUtxMVZIFagGsJhn7FbNQ27qdpdiG2Ov9sIZwmKrMVhv
         yxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779705764; x=1780310564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zc9LvU3e/f54K4oHyIoq4+XKoWb/QRX1RMbSGSqgSQI=;
        b=CZB2c00HIWVKtz47UcGihg83oSVSZR1cl5KYThH0BDiEWzuf2NkEagYLPNw51MxFfH
         Rsgg6ApsjRojx1uMMxLS1qR4FwARWaPt6KwJThzQSCjnnN4DER6DLDpbgLAPmNssCQ8F
         ZJ2lHUwUcKaxbVRpVZSqbM0+OQ/HQxENInTLk9Vt/uzLDG9lexrCVTt/nUu41oIFwPtn
         qKxvRMFr+UMxYJz/9ZFfJa0lz4sBDkn4A0UxGdszOps2K16XPy1Arz7dMT84eXlezS+1
         9SVCymwyUAe1Ob6LUZd6iGcxhhP9PFOrRKPlnsUvBviqc9Y8ipQo70oUl8BO7NpV4kUf
         XjiA==
X-Forwarded-Encrypted: i=1; AFNElJ+1NaZGSr5lcKrRWPCpUuUWnx7JyEg3+27Va80H832TRr6oAWmQ/YM/r0+wmTr6okUFzktRcKfgqDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOia/LEAkd3EKZegRWxDGIJ8XLmMIUAdKlry7LAAJ8Qd2bVV3E
	ioJkfxJjRC6Nv+LzFxH/e/G+unXITfFjSsBdo4Eg71Ya/dtnQoWyPkYA
X-Gm-Gg: Acq92OEiUcwBpqUSR+Fkp4ec32R1jUk/RNfKRSvcO488Z1gYWviNLhbiAKa3DrTJviH
	2AEWj/G7Y2aDSWfBvcISXPmSrEBX+Jz99oew3PuHP9MPjEsQUOIuXZ8uDMMkq1q2ztGCnLQ6s+I
	Nn/Ke3Yw9SX7Kqw4blW29AI+XYehJGqZNX/zjr21ISS6udkuyl/d0FZWbK2yOaBeO6fOPf86tEV
	Dg8Z/JW737FIXrfDDq0FVIP8y0dqMq/sfXQA9AN1TO3oHL5RachpTZ5CKzR5Ld+bjiNu3gAJtKg
	NyBPENB0YydfiktjFyMnaJPx7D5U5ATqgBGYOGeWAOvPwpvfsRy2Svmv2AbpUcmArqXBfvue3fd
	xH8+kPc9/ePMbNknVdhfGFLZEesgssfvqj5kVBxT16yeJTf9lJrtaOH01MtyBoCp8YtGNFD68ri
	FZ5HllKZs9GLj4LGmLKVjU8507k/jWDOQbv+9rxHNeoDZX87inQpRFqeZ1DBi4vBAxrLCBHkzHD
	gM=
X-Received: by 2002:a05:600c:45ce:b0:490:5cd8:d213 with SMTP id 5b1f17b1804b1-4905cd8d33emr89808645e9.15.1779705763319;
        Mon, 25 May 2026 03:42:43 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49049973b71sm67696445e9.29.2026.05.25.03.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 03:42:42 -0700 (PDT)
Date: Mon, 25 May 2026 11:42:41 +0100
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
Message-ID: <20260525114241.4b6f3050@pumpkin>
In-Reply-To: <20260525114107.7fa5b4c1@pumpkin>
References: <20260524-tonyk-long_name-v2-0-332f6bd041c4@igalia.com>
	<20260524-tonyk-long_name-v2-4-332f6bd041c4@igalia.com>
	<20260525114107.7fa5b4c1@pumpkin>
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
	TAGGED_FROM(0.00)[bounces-6402-lists,linux-api=lfdr.de];
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
X-Rspamd-Queue-Id: 003FA5C9555
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026 11:41:07 +0100
David Laight <david.laight.linux@gmail.com> wrote:

> On Sun, 24 May 2026 19:38:54 -0300
> Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:
>=20
> > Command name has been restrict to only 16 bytes, which is too limiting,
> > specially when debugging and tracing complex software with thousands of
> > threads and the need to differentiate them.
> >=20
> > Just as it was done with kthreads in commit 6b59808bfe48 ("workqueue:
> > Show the latest workqueue name in /proc/PID/{comm,stat,status}"), suppo=
rt
> > long names for userspace threads as well.
> >=20
> > To avoid buffer overflows, cap all existing userspace APIs to
> > TASK_COMM_LEN, and leave the full extended name for a new interface.
> >=20
> > Co-developed-by: Bhupesh <bhupesh@igalia.com>
> > Signed-off-by: Bhupesh <bhupesh@igalia.com>
> > Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> > ---
> >  fs/proc/array.c       |  2 +-
> >  include/linux/sched.h |  3 ++-
> >  kernel/sys.c          | 10 +++++-----
> >  3 files changed, 8 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/fs/proc/array.c b/fs/proc/array.c
> > index c8c3fbd9bfa9..312371eddc7f 100644
> > --- a/fs/proc/array.c
> > +++ b/fs/proc/array.c
> > @@ -110,7 +110,7 @@ void proc_task_name(struct seq_file *m, struct task=
_struct *p, bool escape)
> >  	else if (p->flags & PF_KTHREAD)
> >  		get_kthread_comm(tcomm, sizeof(tcomm), p);
> >  	else
> > -		strscpy_pad(tcomm, p->comm);
> > +		strscpy_pad(tcomm, p->comm, TASK_COMM_LEN);
> > =20
> >  	if (escape)
> >  		seq_escape_str(m, tcomm, ESCAPE_SPACE | ESCAPE_SPECIAL, "\n\\");
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index b6de742b1155..f7fd2b7d131d 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -323,6 +323,7 @@ struct user_event_mm;
> >   */
> >  enum {
> >  	TASK_COMM_LEN =3D 16,
> > +	TASK_COMM_EXT_LEN =3D 64,
> >  };
> > =20
> >  extern void sched_tick(void);
> > @@ -1167,7 +1168,7 @@ struct task_struct {
> >  	 * - set it with set_task_comm() to ensure it is always
> >  	 *   NUL-terminated and zero-padded
> >  	 */
> > -	char				comm[TASK_COMM_LEN];
> > +	char				comm[TASK_COMM_EXT_LEN];
> > =20
> >  	struct nameidata		*nameidata;
> > =20
> > diff --git a/kernel/sys.c b/kernel/sys.c
> > index 1d5152d2395e..76d77218ab19 100644
> > --- a/kernel/sys.c
> > +++ b/kernel/sys.c
> > @@ -2535,7 +2535,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long=
, arg2, unsigned long, arg3,
> >  		unsigned long, arg4, unsigned long, arg5)
> >  {
> >  	struct task_struct *me =3D current;
> > -	unsigned char comm[sizeof(me->comm)];
> > +	unsigned char comm[TASK_COMM_LEN];
> >  	long error;
> > =20
> >  	error =3D security_task_prctl(option, arg2, arg3, arg4, arg5);
> > @@ -2601,16 +2601,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned lo=
ng, arg2, unsigned long, arg3,
> >  			error =3D -EINVAL;
> >  		break;
> >  	case PR_SET_NAME:
> > -		comm[sizeof(me->comm) - 1] =3D 0;
> > +		comm[TASK_COMM_LEN - 1] =3D 0;
> >  		if (strncpy_from_user(comm, (char __user *)arg2,
> > -				      sizeof(me->comm) - 1) < 0)
> > +				      TASK_COMM_LEN - 1) < 0) =20
>=20
> Nak - you can't do that.
> You are reading data that the application doesn't expect you to read.

Or have I got confused over the names...

-- David

>=20
> >  			return -EFAULT;
> >  		set_task_comm(me, comm);
> >  		proc_comm_connector(me);
> >  		break;
> >  	case PR_GET_NAME:
> > -		strscpy_pad(comm, me->comm);
> > -		if (copy_to_user((char __user *)arg2, comm, sizeof(comm)))
> > +		strscpy_pad(comm, me->comm, TASK_COMM_LEN);
> > +		if (copy_to_user((char __user *)arg2, comm, TASK_COMM_LEN)) =20
>=20
> Double-nak - you are writing beyond the end of the applications buffer.
>=20
> You can't change the user memory that the syscalls access.
>=20
> You can support the longer name for read/write of /proc/self/comm.
>=20
> -- David
>=20
> >  			return -EFAULT;
> >  		break;
> >  	case PR_GET_ENDIAN:
> >  =20
>=20


