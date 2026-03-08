Return-Path: <linux-api+bounces-5910-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEHSGrwXrWmyyAEAu9opvQ
	(envelope-from <linux-api+bounces-5910-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sun, 08 Mar 2026 07:31:24 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1485A22EBA1
	for <lists+linux-api@lfdr.de>; Sun, 08 Mar 2026 07:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 686793007507
	for <lists+linux-api@lfdr.de>; Sun,  8 Mar 2026 06:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C477F30C608;
	Sun,  8 Mar 2026 06:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoBC7Wij"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1BC2F6904
	for <linux-api@vger.kernel.org>; Sun,  8 Mar 2026 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772951479; cv=pass; b=sEVVydr4pDOQSdxNv2vZj4eNP+jXtOWhqHg+wQ57qqym1BISwdWBBtZJ6usN/rhkDibidui/U/lqs3x1ARSRJ01GiKYHGo21nSQXfHHbIIQ0pXXxkJgOKzlMzJ4lXnju1kAfoyfDmAn1z/FXp9pfzvD7y0K0o6GT6FIR5KFIx0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772951479; c=relaxed/simple;
	bh=bqMEOQ0Ckcrgyric5QOWebyRcZKyiXhkKZw3Ukws05o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BI5YrYedZbb9qHOHWrFdXixqlYXV8vb//1Xnbe8J2jL0CSHTNQbr6nce+dLJrx974acEWqH1Ayti0l9MWESnoAQ64VTgygw7TPmqdnstxKmgWqTnOF8uoRwuYFXrAcZJXE+JO5EL1xwZfIrgLXVMmKYQVNqKZWFsa0XuTL6mmuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoBC7Wij; arc=pass smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-94de664b541so2992245241.1
        for <linux-api@vger.kernel.org>; Sat, 07 Mar 2026 22:31:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772951477; cv=none;
        d=google.com; s=arc-20240605;
        b=BK5xjzeUIclt5q0vsqfBiH7e6MsP87KDZjn1quuZ43nSMkOM0TAa+Ve4W7UdOyV14m
         RDXRrWZQZ53ccdzcFEVDVvJT2l1uMj/8Xp2MA5TehSho48xYiA7fkAiX5C3sJYIfpZGR
         eHozs49INcNvTSKLwWJ7k6joqqV7UfaNu+YQO7VhdhbrBuFJtwGpvG69z3F7utKkzvSB
         Es8GPN4/0EGRjhj0RKpSXvHmZ+Lmi/H3qptDJChT+hbzeUOyMUj3Ja4m+4BxrDlLvtTN
         xSXhX2L2uCyMSjJ75vp/MqwXH8TL7PZdeidt/IDDjM40D/48igp3k48sql/wqCY3GqQQ
         QvDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wmFGvCnSNVovQCGgt6RuGUFVOm9BbgW1X0Xq7Fd9owU=;
        fh=/p7PtslJ+yDYCsGjz6gHyX0ULIRAR1R5MBwDPzYZLoU=;
        b=JoxWlX0PvRiFv1C3FdWIdSK8wb7IKar3oJ41CdOHHNdc689r8qc9S0QP928Vr9CTX6
         0mjegmDD2OpPCgptTVlVe4FsBB9MlpMFQqRpfT+/CQLdGg+5s/3dOxDP+OzhigYWhGtt
         ra8dImVLXQt4zwTd78gSvx2ubdb8Y5TeBLPbpsbGLF6TTwKIRU6SBCRPsF6GV66QwDD7
         1IliqpfwskphQY3IQjnR8JxvhjNxYHmw6FYdyXPAEdl2FG8rVw1Ewbgljck0X0568rN9
         HoL2KiH1JxH+xRvZS4UxmUjfDr+gy+Jfs3GBcl7oCE7sun8PKH4Rn3N+tWIVfdi5ZXyO
         FMOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772951477; x=1773556277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmFGvCnSNVovQCGgt6RuGUFVOm9BbgW1X0Xq7Fd9owU=;
        b=UoBC7WijfmQjVlLHxpWqT3DlTCrRD4bQJHimo+Ve0AMx+0bxsR3bN/1HscBrJM5qp4
         hAoHmEH3IXVxPHPjHP72bQjLwytOTAT5lJd6vLsKUfcx09gi0FJHs8GAtUs2Zp97KKRS
         FEk475ub7vx4XQABNB53DotIZxjsKUBLPuPd0GzyFt/3v07yHqf9qXCPxfHICyaytCF/
         wULC1pF4Xso5tHqPjvY31TUJdWMLPO7UZMC4SdrzuK11/bdvaGVzvdmvJy12Y+tEql+T
         EYn1klj2Rf4ROnNVpKQExB+BChYuTiyYbqJmdmRYKShyl6hiOYBewDd9lUoEbhAHN1Ij
         57aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772951477; x=1773556277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wmFGvCnSNVovQCGgt6RuGUFVOm9BbgW1X0Xq7Fd9owU=;
        b=UfmFdYGFTDyZt3vWkxW84nZdHiKWo6yaGs09I6FDDcu74qLXm5Bcep7LUEH3TiSrEJ
         N45806CDxPE1pXT5jAsqrMdSXTAnncUZgog1nCFfWtYjDnt77B2vXh0hDSsrQymI4Duw
         P4Mp9Fx2Mhe13PUdgAImz+MrQHEdsYn2ehZm2nVjNPkfIyN7Drf8bSgbPIMIr3FcRk2G
         xuJTvYRUXCDdG4eRnwirBiRymdAwTOAMq7n0qTemWyigm9vCtbvGNaNpWqrexUNn6GGh
         qKyilFPkx3ILzLmqiHgRX/yS6TNr5JUOQW1rRhLgq7hMnGU+XeAd5T3NZN+QTPWafdMX
         XcDA==
X-Forwarded-Encrypted: i=1; AJvYcCUR7uAmOCQTfGlbk3evGHUPnZXYk31TtkYWJ8QeKTVyb07lt+7z7xip238qEmUfB+r57YOgesNDcxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1s4Znt2pEfVdxx+bpqEJEuH7u9VWnWmBAuoiuoAsuMalcryl6
	erH9MmRlIho++50iW4Ac3GrLohmtBXMnGDiEsdIwgjAvh1QgeZt6vhUXpS89xFlWzyIo4h+9oZq
	74BZkar1kidWqu9uzBpMEATbZJv5GOFQ=
X-Gm-Gg: ATEYQzwM+8fz1PNhJwXwaf2VAa9MuFYBKuJ/r0NtQaiPaj6a0GMDDBck6xQFyGT0Qaj
	VQoRrvdftl6A/ctVS1ECyzHLsYlTJgvPvAF6nXNlJRMbnQS2hJG6MHFjS6vig8Rc43sjOC5QF9r
	9fXc6EoHK6VDViP/p08d4r8YB/WY2BdLpQsjmIjkIE+gmkGlajxIfIRLZikM6aQB6MBeUyqACjm
	0Qe8aZtACR8Du6rZf8oBoqQOP8U//7rCEK93uk14qvUH11G4jxON0XTc0NVhe8cVhwbLQAUlOhs
	3+JUSnYoHMKEVLKYoKoGWV5mSykerG/7DQeXSW2R1g==
X-Received: by 2002:a05:6102:41a6:b0:600:11e1:2a4b with SMTP id
 ada2fe7eead31-60011e12bf3mr732622137.34.1772951477120; Sat, 07 Mar 2026
 22:31:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
 <20260307140726.70219-2-dorjoychy111@gmail.com> <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
In-Reply-To: <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 8 Mar 2026 12:31:06 +0600
X-Gm-Features: AaiRm51WCqo6sYLOpIV6hZ1XNIYME3jM_VRhuXhqPcz8hjUnJuRMBp96SANcO1M
Message-ID: <CAFfO_h4g-QtE1gsp3nw7+BUYnRj29au=pYs1goEnppbdU-8DbA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
To: Andy Lutomirski <luto@amacapital.net>, brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	jlayton@kernel.org, chuck.lever@oracle.com, alex.aring@gmail.com, 
	arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, shuah@kernel.org, miklos@szeredi.hu, 
	hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1485A22EBA1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5910-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[43];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,suse.cz,kernel.org,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.973];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun, Mar 8, 2026 at 12:56=E2=80=AFAM Andy Lutomirski <luto@amacapital.ne=
t> wrote:
>
> On Sat, Mar 7, 2026 at 6:09=E2=80=AFAM Dorjoy Chowdhury <dorjoychy111@gma=
il.com> wrote:
> >
> > This flag indicates the path should be opened if it's a regular file.
> > This is useful to write secure programs that want to avoid being
> > tricked into opening device nodes with special semantics while thinking
> > they operate on regular files. This is a requested feature from the
> > uapi-group[1].
> >
>
> I think this needs a lot more clarification as to what "regular"
> means.  If it's literally
>
> > A corresponding error code EFTYPE has been introduced. For example, if
> > openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> > param, it will return -EFTYPE. EFTYPE is already used in BSD systems
> > like FreeBSD, macOS.
>
> I think this needs more clarification as to what "regular" means,
> since S_IFREG may not be sufficient.  The UAPI group page says:
>
> Use-Case: this would be very useful to write secure programs that want
> to avoid being tricked into opening device nodes with special
> semantics while thinking they operate on regular files. This is
> particularly relevant as many device nodes (or even FIFOs) come with
> blocking I/O (or even blocking open()!) by default, which is not
> expected from regular files backed by =E2=80=9Cfast=E2=80=9D disk I/O. Co=
nsider
> implementation of a naive web browser which is pointed to
> file://dev/zero, not expecting an endless amount of data to read.
>
> What about procfs?  What about sysfs?  What about /proc/self/fd/17
> where that fd is a memfd?  What about files backed by non-"fast" disk
> I/O like something on a flaky USB stick or a network mount or FUSE?
>
> Are we concerned about blocking open?  (open blocks as a matter of
> course.)  Are we concerned about open having strange side effects?
> Are we concerned about write having strange side effects?  Are we
> concerned about cases where opening the file as root results in
> elevated privilege beyond merely gaining the ability to write to that
> specific path on an ordinary filesystem?
>

Good questions. I had assumed regular file means S_IFREG when
implementing this as mentioned in the UAPI page:
"O_REGULAR (inspired by the existing O_DIRECTORY flag for open()),
which opens a file only if it is of type S_IFREG"
I think Christian Brauner (cc-d) can better answer your above questions.

Regards,
Dorjoy

