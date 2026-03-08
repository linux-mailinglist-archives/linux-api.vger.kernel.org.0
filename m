Return-Path: <linux-api+bounces-5912-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPvYDY6trWkW6AEAu9opvQ
	(envelope-from <linux-api+bounces-5912-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sun, 08 Mar 2026 18:10:38 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3222315C6
	for <lists+linux-api@lfdr.de>; Sun, 08 Mar 2026 18:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25C0E3002A0E
	for <lists+linux-api@lfdr.de>; Sun,  8 Mar 2026 17:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BBF38E5DD;
	Sun,  8 Mar 2026 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="V5oii2AP"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79A938E12D
	for <linux-api@vger.kernel.org>; Sun,  8 Mar 2026 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772989826; cv=pass; b=KFcdjs7ITCv3PwNvaunjZCddPu9Ng8FN43qAm+Ms5AADz14u+UkenNwoBAmzj419ZwG5nR8VMb9hQeBwS++reZNkJZqgnmsg3biI1NnocKosQpKSW5kibx7W8hlJw1QCmTR82anRSUhnRCLkXlTzeufmKOTnKpiMjz/PeXeYQ5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772989826; c=relaxed/simple;
	bh=mPpVNiloCu6uzQI1WxZPytR2t4HpF2nlFZDXYS8kVTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1SmQK8j4xxUpFHEXSvp5xk1wzsGKeF/x7x95J0NA3Ke3gC9wNIJVToaYo95SyFYY+9vICsBkmyLwTNFqx5XzXzW14xmDjN1+Sg6nAmaZ+FsW1sJGZvgjURj6hynw26McmVmNZQHr/YD0+9wEYwu0GcjOuMmp7TWjnWMZZccHHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=V5oii2AP; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a13d40c760so2249023e87.0
        for <linux-api@vger.kernel.org>; Sun, 08 Mar 2026 10:10:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1772989821; cv=none;
        d=google.com; s=arc-20240605;
        b=G1y4tBtcf54jUUx+3RmZoEUVjyvRegYuRZlkqIT1K03Fm2S0z79it6QLtLDL2VfFyA
         wYMcawijmxlA4Ao15kwdx8KmHsjoIKSrdNkwldUVcyv4r/IkusC6LwmvzME6eWiWeppI
         +BMRgBRbslZMLaTbNX3/vJr1KYa9bQOidCXV2E4r1NCTzHAjnYA95geNz/Nqcmj1mObP
         Le708857TF8+fY/l/+XUsj3vn+H7AR9KRAFuPWXk4qdHHR76pIDshhl8iWagLYkmJdz8
         56/Fk3SFBmTpV6IqerneDdEiUaW7A7kJckH5AVK7Mssz6DOQi93OrjYikPal7Vu7hELM
         p50A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gg9ZdLv2ki48mUNl69QeK9y3vC32V/8zR5xNICHMQ28=;
        fh=HWUuHdW8gHedrsqo6DKrnXbsJENn3b5fSJtRXJd/xdg=;
        b=BonTt9JakT4dEDxXRXTwZ7bq3KRWeDWehfSsHAWQSt9GbHnZKhogLn97UbxeK1XhlD
         +6PISOjhjsB65wfm3vqPeep7JugNiaexfxVfmaBeTOMse7gZixhEEBBkAy5DsKKFjgrn
         Zfstq0Z4ALl0jIjo1x7xAoR1NvwIJmuCOwd1B0Ungi+Fs+4fSlAmhyjQ9Bj1uJXu3P/W
         KXsQ85MCbzpzsrEhtUkujN/R7uLtORbFDQAd0ZD43NM2ryGdtO5+T49MRSB3a1Ua6I6t
         G5rBOHLXIYJSP96/7hJF8dtzIn3m3wAG3qpqAkyzGnghdTXAMumYnk6gn0AShGsxjs8l
         DatQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1772989821; x=1773594621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gg9ZdLv2ki48mUNl69QeK9y3vC32V/8zR5xNICHMQ28=;
        b=V5oii2AP7iK/gHbMNDsSVEdYvHWzBqwPyeiCJaSxH80cBJ0weDfC5z5Jac3vnz4xBd
         Tn2ClWoMdMt+leExQaUPFXVNn1yHQ669Vg1RrqJYPh/2X3l9jSvgtmZZiIj1bUZ2IzMa
         dB3alhLex5Auo3ljWEQXqzrJbKBAnpaXzkW8R3j7dH57EQCqLyyRRuNOPBvBnxDwabY1
         PCB7f6Teh/1ED3+YhCaqbNuWa+/ytjyR+MjlDNbb0urQBJvJj9Tgkb8oCphjnt8HYU5m
         JKo9lxiVLkjF2Ntl0hmSDMics51tH/PApK2OBsOlL42naroddrbbIARbX0CgiVbmpphc
         lFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772989821; x=1773594621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gg9ZdLv2ki48mUNl69QeK9y3vC32V/8zR5xNICHMQ28=;
        b=OBUQWNrEWI85HnFqNgBPpuVDuCvSwJhR5MoMg4xhlG7I/J4DlUjd0y20XRaNM4/q7V
         9ytBlx1ehbtIEVSL9csMTK9yqvCrnKxLSq3Y2ExyfvVvixsg05jtXsIuAZ/g4D5hIAms
         a7PZ30Gws7XRY9imORdvucjXVGNV1Ss8tV4X6feE/e6M2sON0hGtIWwsBdM8jyir6/1Q
         wytPGhQmW2737JREHSpKp4OS7kKBFl53oW0lz/f5VJFR5y/d0zmxo1CaRU+6IBB+v6Hi
         c1b7JdAC4vJWxo3uoOR0FahJONrhpWke3iw7jB4JNKm9xl38gx/3Yx01klHsNMmTKqbn
         41TQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBngURyH67r5oN+62aVwN0CpBnEji9RQxnXZSRatxgcUwZBpZKP0Xw0xSwGzH1DfCJJ7Sd/4mAQdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz6ihV4pg6ZjMWr2/d1n87Z3oTO2PfuFRNVbosi5cSLRU1Dx65
	cu+ilOtQm91HOGW9UZQj70sstmL6+1rVPUQBeUQ9sEuLWtAAklRwiRcGkU6/zIkTDPiHbot9cz9
	O7FxuLvFjNdi6fbjlzEiPX/cs7eqoWaSaEwnyn6V0
X-Gm-Gg: ATEYQzwwEykVzaUgEtSbR73/q+bvAFVd+6H8XAhdwDdoZZt9+0QTGyDz3TWcc/4WfCM
	1iHDNlZpikefpwnwpd2t3b9cCX9Fd1BBxXOVw9AVqxNQbSQn9kLyQczsz/PObspcp2jEhXamwoi
	VLbr42x2Mwwa1qAf5C6kb3E5UiOTLN7kFSA6KSrH8nTDEhn0S1LTyzd7R6G90h59bFlhd9Ermg4
	QBnOYDuV+Sgao1tf/ttM9LpbHBUro5UWZv66XIOXvX+IHGDlMh0wceNjFwTbWAgAnOllNV2ISDy
	vNZHdRu73qu2/eU=
X-Received: by 2002:a05:6512:10c1:b0:5a1:3539:1181 with SMTP id
 2adb3069b0e04-5a13ccc6854mr2584241e87.20.1772989820622; Sun, 08 Mar 2026
 10:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
 <20260307140726.70219-2-dorjoychy111@gmail.com> <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
 <801cf2c42b80d486726ea0a3774e52abcb158100.camel@kernel.org>
In-Reply-To: <801cf2c42b80d486726ea0a3774e52abcb158100.camel@kernel.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sun, 8 Mar 2026 10:10:05 -0700
X-Gm-Features: AaiRm53NE6RSEVl9G8ylA7uki0xCjhtuxwfA8HvbEL_OVbVZXAi0saXeclsKpvo
Message-ID: <CALCETrVt7o+7JCMfTX3Vu9PANJJgR8hB5Z2THcXzam61kG9Gig@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
To: Jeff Layton <jlayton@kernel.org>
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
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
X-Rspamd-Queue-Id: BE3222315C6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[amacapital-net.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[amacapital.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5912-lists,linux-api=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amacapital-net.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@amacapital.net,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amacapital-net.20230601.gappssmtp.com:dkim,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun, Mar 8, 2026 at 4:40=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Sat, 2026-03-07 at 10:56 -0800, Andy Lutomirski wrote:
> > On Sat, Mar 7, 2026 at 6:09=E2=80=AFAM Dorjoy Chowdhury <dorjoychy111@g=
mail.com> wrote:
> > >
> > > This flag indicates the path should be opened if it's a regular file.
> > > This is useful to write secure programs that want to avoid being
> > > tricked into opening device nodes with special semantics while thinki=
ng
> > > they operate on regular files. This is a requested feature from the
> > > uapi-group[1].
> > >
> >
> > I think this needs a lot more clarification as to what "regular"
> > means.  If it's literally
> >
> > > A corresponding error code EFTYPE has been introduced. For example, i=
f
> > > openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> > > param, it will return -EFTYPE. EFTYPE is already used in BSD systems
> > > like FreeBSD, macOS.
> >
> > I think this needs more clarification as to what "regular" means,
> > since S_IFREG may not be sufficient.  The UAPI group page says:
> >
> > Use-Case: this would be very useful to write secure programs that want
> > to avoid being tricked into opening device nodes with special
> > semantics while thinking they operate on regular files. This is
> > particularly relevant as many device nodes (or even FIFOs) come with
> > blocking I/O (or even blocking open()!) by default, which is not
> > expected from regular files backed by =E2=80=9Cfast=E2=80=9D disk I/O. =
Consider
> > implementation of a naive web browser which is pointed to
> > file://dev/zero, not expecting an endless amount of data to read.
> >
> > What about procfs?  What about sysfs?  What about /proc/self/fd/17
> > where that fd is a memfd?  What about files backed by non-"fast" disk
> > I/O like something on a flaky USB stick or a network mount or FUSE?
> >
> > Are we concerned about blocking open?  (open blocks as a matter of
> > course.)  Are we concerned about open having strange side effects?
> > Are we concerned about write having strange side effects?  Are we
> > concerned about cases where opening the file as root results in
> > elevated privilege beyond merely gaining the ability to write to that
> > specific path on an ordinary filesystem?
> >
>
> Above the use-case, it also says:
>
> "O_REGULAR (inspired by the existing O_DIRECTORY flag for open()),
> which opens a file only if it is of type S_IFREG."
>
> Since we allow programs to open a directory under /proc or /sys using
> O_DIRECTORY, I don't think we should do anything different here. To the
> VFS, all of the examples you gave above are S_IFREG "regular files",
> even if they are backed by something quite irregular.

That's certainly a valid and consistent way to define this, but is it usefu=
l?

--Andy

