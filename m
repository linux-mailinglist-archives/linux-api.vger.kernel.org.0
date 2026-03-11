Return-Path: <linux-api+bounces-5931-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Bw6OgCUsWnkDAAAu9opvQ
	(envelope-from <linux-api+bounces-5931-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 11 Mar 2026 17:10:40 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 708F926709D
	for <lists+linux-api@lfdr.de>; Wed, 11 Mar 2026 17:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC333300D36D
	for <lists+linux-api@lfdr.de>; Wed, 11 Mar 2026 16:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFB037187F;
	Wed, 11 Mar 2026 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="DQI1cRxa"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2830536B043
	for <linux-api@vger.kernel.org>; Wed, 11 Mar 2026 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245421; cv=pass; b=n6LBzUQzgZgzZd2SzfManjRpgNMQb/W9hTCUpw7+QGwaflR5kiw+9P6d8uOdDvoybvAteukxVX+gICovefB8HJF95WZG6pW17nvhE/K5yFi/BZ2udzgnBtQlWiuYtqr4/zu34IT2Yiu3KSyeRn7dkfxivexibWj0P8nSkChxnbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245421; c=relaxed/simple;
	bh=RINC3OxukObTWwNgLj8cUCMQfmLKMyUKoc5ifoxu7lY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVYMLbO3gWWGwppInvz/Nllv14dpX5jdr77YGk1VtT7cy5wphKwvs93hafdYo9Q/NtbEpJNjgVHu5Cqapg23nZiEIPv37nVDakR4LTJEzEUYelYhTLEq2nfJlwGzEgfB/TS+ZBi3qOTeaPvfGPUxzaQjA2qRFwGp2BBcYI48aTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=DQI1cRxa; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a13d40c760so124187e87.0
        for <linux-api@vger.kernel.org>; Wed, 11 Mar 2026 09:10:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773245418; cv=none;
        d=google.com; s=arc-20240605;
        b=OKK/HgabjldBVOw3DA2/0T+scJv1OSqSu6gBvIext5QwZzvjW9PPgBjc3rYuu9U4WE
         T8spjLrC21IUMRSSfs4gojc0L4OmD6w+Bg2/jDymRGToq/uI+4rZaMB0k4CgYrKJN5dB
         vo2c13AUzhUrBsG2O66MHY+OvHgNm2hTNUcuVQNmK1fkNNJ0Fu1O/LM+rbQTqHQeZVs4
         zXHhsOHriQl00FcuHB6jKAVaX/d/RIi0+h5pHCr9eCpVTMBtoyg83hzx46ruUhLiyuxm
         u5qYAfdikpILDL1b/ZGygynhw7AuBFcJh21NJE8adVX0hUSCP8K47fVVWjyixZOIWy7Y
         p+3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zQf3bqKM0prJaYagyzgzwBy7UALOn5Wa6w4qvhYX8FU=;
        fh=s5w1wysQBMTc2aGpu1wenxsJz2eEAonUhIbWA49am24=;
        b=CZyknUcVrU+j2JcMBAP7gd6K2T8uHoFUp3m6zAWyLFkO3WI6yF8NYIBkm1IewEjvBj
         mLTaXZMWILBnBKkLr0DwY3TnQow2815Uu9oeh9iCY0P1bkRBoWQceAWZgfFmY98ffcQW
         PfxUJS4ozgSn/RdSA56iJSRVNmUmGpYAzg/A5JpsymN+qzcQwCAEeWJAhQmaaejISCHP
         Ma106RVJxtftGuiLlDixTnqHqPyMSmWZ42HhUJPF0WNnDW5XAeKomE6qWB78V9izbPhA
         WfutQpvXwgcQClYvqUkPWvxJf1doJKue6kw7HC+kQOrDLc1YV8X3BTa54VTzDR6mXS6j
         7CkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1773245418; x=1773850218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQf3bqKM0prJaYagyzgzwBy7UALOn5Wa6w4qvhYX8FU=;
        b=DQI1cRxaYaxsZCMcyoPsKK9oceAAMF2Z/4ka0wFpZB8+XmCfMpWDiiF7wWVvKTnenh
         fLiq0/4041WV6SUN9UIAUOBG/CMSj6vFuAOInXJ4NveJurk01cGbF8fRy51alCQzW54O
         UmWAXgDLBXidwZi/zen/FyMiT4+9QZH++ETKQNT+c0cTD2imeB9je4SnL8TKcC48glED
         ooRh8mXUApVARqvWJDY7zkjpZo16/2+cEhSB1AU7m2IZ8+56OmAYPqCj9CJqISqpRtn0
         +Gzbol7v857u1b5Km8cgfWLXwWaOdvanog3a0ycMGHtle6ytBjRh/50KWHHrh5a7Q75q
         +ZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773245418; x=1773850218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zQf3bqKM0prJaYagyzgzwBy7UALOn5Wa6w4qvhYX8FU=;
        b=aM0VI71QZ6yagiC5WsM+xz19pXMSmcTx7Y4UfrpWq8S2YQG1xohUUx0hsZhNdQq0hR
         fnpVpTqV/vLrh0djmwEcfCFjNcSDl4lvBjCyU8n2zd9bCsP6aNbbVxtBaC5ge0EmqNyM
         W6nGGsS9aszVQXWqsHkB7UWQDND5pkeZsHLL1XhFKOy58tu2CiUxGHBu0uei10gw0xL3
         tUwz3MlDpOUxvC6noHE7r+TpxQ3hubhY2Lrklfv9RY1KIM0NQmHFnDnVm92vP3Stdct4
         4bgCOsFVDlum3OsC+R4dZhLarAL4XrQZbgNqDK02TXVVcV1JWypAcwJ+E9M6SyPhu/Dp
         0LOA==
X-Forwarded-Encrypted: i=1; AJvYcCUiRJ4FKpZELG/8XW+G/iGW6eREqooSz6/WQTgPnM1W7JeJJQkx3Oe3V3f50NdXZ43PmAMRngqx9OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPOmBSIRcFt535M2BxWnR167tamMu6s/S0mtnoOlMUPfNatPLE
	8rNuGaR+zl5Czz7a8QlQjm5OSmWlyX8iUlC/W/BCVof0kUOrNY3m466XPRHaiGIpIZQ50WBu4lH
	7MHrausoDgekFVD9Sicf/IvVoPluH5z+N2s8I+KPg
X-Gm-Gg: ATEYQzz7gErVyoO69/TuQ2/rIFZdJ1ulPHUfTHpxg6Sx4njYAFanxv2DoJrGGOJBSoP
	coCbwFs6783lmQZ1elS2VHRBE9RNWDEbCy/o0bmA//em9AF0ewDC43VaW/IJw9knIt/6lFHEhE7
	H6032yjQSgnpC/k3crggZCZlWWg221t43qXOZNWyGQjYE+BrDCaVwYrISQOwQ79j8U6OvcdGczE
	AWZLU7ttbggBeFSBkiULbdHx8RDQ7dbjFRUWq8Fk8EyF9/C2r4LNHwADYTqM7K4F/62woW9lNJ9
	QVsu
X-Received: by 2002:a05:6512:712:b0:5a1:4835:306f with SMTP id
 2adb3069b0e04-5a156baf0a8mr762062e87.19.1773245418128; Wed, 11 Mar 2026
 09:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
 <20260307140726.70219-2-dorjoychy111@gmail.com> <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
 <801cf2c42b80d486726ea0a3774e52abcb158100.camel@kernel.org>
 <CALCETrVt7o+7JCMfTX3Vu9PANJJgR8hB5Z2THcXzam61kG9Gig@mail.gmail.com>
 <20260309-umsturz-herfallen-067eb2df7ec2@brauner> <2026-03-11-regular-sore-census-shops-DqYcUT@cyphar.com>
In-Reply-To: <2026-03-11-regular-sore-census-shops-DqYcUT@cyphar.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 11 Mar 2026 09:10:05 -0700
X-Gm-Features: AaiRm51EXHFpn1BAVpxsTY5E2VQC7PD0Lwp6wdRjddj9MKMq4N9OfHTiuPJrR94
Message-ID: <CALCETrVMF3VBr0cuEYOg-M_u+hX77Jfdujv3ZMtLGCzHgOcsGA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Dorjoy Chowdhury <dorjoychy111@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[amacapital-net.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[amacapital.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5931-lists,linux-api=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amacapital-net.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@amacapital.net,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,suse.cz,oracle.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,cyphar.com:email,amacapital-net.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 708F926709D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 10, 2026 at 9:49=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> wr=
ote:
>
> On 2026-03-09, Christian Brauner <brauner@kernel.org> wrote:
> > > > On Sat, 2026-03-07 at 10:56 -0800, Andy Lutomirski wrote:
> > > > > I think this needs more clarification as to what "regular" means,
> > > > > since S_IFREG may not be sufficient.  The UAPI group page says:
> > > > >
> > > > > Use-Case: this would be very useful to write secure programs that=
 want
> > > > > to avoid being tricked into opening device nodes with special
> > > > > semantics while thinking they operate on regular files. This is
> > > > > particularly relevant as many device nodes (or even FIFOs) come w=
ith
> > > > > blocking I/O (or even blocking open()!) by default, which is not
> > > > > expected from regular files backed by =E2=80=9Cfast=E2=80=9D disk=
 I/O. Consider
> > > > > implementation of a naive web browser which is pointed to
> > > > > file://dev/zero, not expecting an endless amount of data to read.
> > > > >
> > > > > What about procfs?  What about sysfs?  What about /proc/self/fd/1=
7
> > > > > where that fd is a memfd?  What about files backed by non-"fast" =
disk
> > > > > I/O like something on a flaky USB stick or a network mount or FUS=
E?
> > > > >
> > > > > Are we concerned about blocking open?  (open blocks as a matter o=
f
> > > > > course.)  Are we concerned about open having strange side effects=
?
> > > > > Are we concerned about write having strange side effects?  Are we
> > > > > concerned about cases where opening the file as root results in
> > > > > elevated privilege beyond merely gaining the ability to write to =
that
> > > > > specific path on an ordinary filesystem?
> >
> > I think this is opening up a barrage of question that I'm not sure are
> > all that useful. The ability to only open regular file isn't intended t=
o
> > defend against hung FUSE or NFS servers or other random Linux
> > special-sauce murder-suicide file descriptor traps. For a lot of those
> > we have O_PATH which can easily function with the new extension. A lot
> > of the other special-sauce files (most anonymous inode fds) cannot even
> > be reopened via e.g., /proc.
>
> Indeed, I see OPENAT2_REGULAR as a way of optimising the tedious checks
> that userspace does using O_PATH+/proc/self/fd/$n re-opening when
> dealing with regular files.

Can you give a brief decription or a link to what these checks are and
what problem they solve?

--Andy

