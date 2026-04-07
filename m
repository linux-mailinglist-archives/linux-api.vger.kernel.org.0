Return-Path: <linux-api+bounces-6067-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHjlOtrF1GlbxQcAu9opvQ
	(envelope-from <linux-api+bounces-6067-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 07 Apr 2026 10:52:42 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F28A43AB89F
	for <lists+linux-api@lfdr.de>; Tue, 07 Apr 2026 10:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C258B3006983
	for <lists+linux-api@lfdr.de>; Tue,  7 Apr 2026 08:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CCF39A800;
	Tue,  7 Apr 2026 08:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7LzFUkn"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFC039A045
	for <linux-api@vger.kernel.org>; Tue,  7 Apr 2026 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775551951; cv=pass; b=LrCrIG/HYf7Sc9zJPsPlnmB3pzmd2BSv/VBR9cg/cEpMSg5Et7pmXYV15UKcxdnVeBTsqIlqYqu3ux1H/O4ZAOmhTkH4q5xueTTgFrtDHFcQWUkdw2+gWgAnKkYx9T/yUlo5MUzDc7z2/XAYleAUnz3bNIoRypLmMAxdY0EGrqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775551951; c=relaxed/simple;
	bh=1/yxO41x8fx08HBDLEnG68zlrtgzWXfreGygoOQjbaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7Cw9DO+QOXqR4pse4pS+SFJuH3BnZejzrOqvWy+DFafCilyVgav8/ApcJ22iSJ4j95XgWOp4ImItoHVNFL3BU87JlB2j/qg7BJ8D6D5y0xm0mwMA3BooG2adlY0goDLhgR9ngqdaWk9P4pagmeI8yEGno1FqQhpGnOZTX4mx8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7LzFUkn; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-66e8cc714fbso4385884a12.0
        for <linux-api@vger.kernel.org>; Tue, 07 Apr 2026 01:52:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775551948; cv=none;
        d=google.com; s=arc-20240605;
        b=fcT1NiLQUh/Cmsohsiyonc59duVaYC4rXE2Du6yTCHhb/dCUwn5leN4VE7zxciKfr5
         UgFiKw7BInAVRqARsTAFOjLqvc4+heva/PGLl1sphvpr1CoPRWIoejrcCs2Pn5IawBHM
         0oU5uuhbh5zp3YWW/L9PiRn6UFkpd0LAhkyGdggpjlvkn8q3RPD4u2VGtNsqx+/8gTD4
         /1VfUYI1rqcxdZfefaOsnmD/3FVerTEf8MmQxjEIXBf5MGii34N2NyNpY868jwwYHv0F
         SoTkra8b8JKR+/4Uskg0whaGqAvJfa575030ofp05zSkmfqPU2cgg2QN5TQHXyjOUvNt
         +7jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1/yxO41x8fx08HBDLEnG68zlrtgzWXfreGygoOQjbaw=;
        fh=989hFj2afRX2dSnWobxFHYh1PezBgdGuLKBat8AaqXo=;
        b=FQX2fhUXQTk4CxwhmVBwuQHtDF4LsIgvOiA/yTJiWftIx+vhiZ5ixbSqY82XcrSJ9Y
         qLYlf6xqwkouO3Vi+Q2QCcZjM5ukVpz8sU3qVbecEZ/elWTf2I0Y6PYrTO0ZdiGFeYGS
         /xaRwK3Rec9xIbNMnWbQ59P1VRzGxwzjy1l0vsV8BfJ8eEInpkEzTMrzX2eAj3ayLs8c
         L98qS1XuB1Q7MMGfX4H2VIwVYq2SvjQO9+dg9RRRMyarmv440S5JDZmQ5jAW55jJvbKH
         b7eKpr9UxjJ8ukUCv4ljUGlyfvNsF6YIMKFAQ7s/0Kxm73rHjkybKKovFKNrLszz0SF3
         po2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775551948; x=1776156748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/yxO41x8fx08HBDLEnG68zlrtgzWXfreGygoOQjbaw=;
        b=V7LzFUknaNaa+Ni3xvKOIPElGYuOJXP1y0XM1OPOmTQVGAyQQjxKJOTRD83CDp0Vf1
         m68toxhmpregUOeHgK81IHSWDfz8n0uUt/QST5qkegHj119alX5cEyNeUd8UthSkNBAU
         RqDwG2ru9JVu2sG76beHJ33ZkqF6wkexVML+G3avEWfPcevmGEdiLeHR6Hbwpq5vVz4j
         s3Z/mKubjaR12r3hmJZu0fDyqjUnMbQkRm+Q0zb2M41qBkWpz+t+HyiWkQF+/SON2sRB
         s6LT0FCMi8LtUK9o0gjkdxj0ob+7DpK1BVqo1BQb0iTchNgLIZo6a4gMNKx4/tLnNjr1
         l87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775551948; x=1776156748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1/yxO41x8fx08HBDLEnG68zlrtgzWXfreGygoOQjbaw=;
        b=WlAeO1LrA+4tqs9lqBFhMzauw846dcVLJ0LEf1kDY4nQpHtUxqcu0sBM15cfqnsy4O
         IXnnq8ek5oQ8YIryu5ckr+yT0GmmPm9i2sPH8VXr5062138Uzi+YObXE5HkM/R1FdXC+
         kFdj+uKQeyNoXBtgOp+PR12JsSYGkdKJAW4scPs0Z1Th4CxIKQAh2SZXrHrt4rBkOJ5r
         gftcteK/NxGbX2arEI7bx+ELn/UdnEkb8fA2Ewx1lc2NQmOs6D5wlZk1omjGTRoziwuS
         nQvGen/kEI9RVqyUF3X4Zc2Uhyw1dImooxjeg/JQFiS6S7p+pZqDUOal/fzwqr2q5I43
         Lyiw==
X-Forwarded-Encrypted: i=1; AJvYcCVt1Ug2sWG7lJsZzM0/nSx2J2dMq4rGJ5zTmIo4abWexnKdMMVQzHeRPNwVPqaB0OfFGBphOairD6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YylhZNnDIDLo0CqprvJGEkEGWYRnpz9H7DV36gSIbjEue4g/iqd
	4iYBGc70v1wsZoeANRsSJK8F4CeUmv9KuB539drOkIJOn2ICWcRVkarUDvAi2bF765oxy+/UqXv
	kpj+L/5I+sQj6v9FV6ZyRlyAL6cPDJ64=
X-Gm-Gg: AeBDiesmxaSAq+W5uK2lPI3DgoCA78HAINj+S1PUzRNo082tNfbMjPTQy8NCkyTzDLu
	IQw1hrgoAw2qEFrcQKPegIWDa+gH/rPpUHb5PZC1Z9ok8qBWv7ULK1KfU9vKnPakQaiye+EAgBy
	9gof08EA1KErlgzey4da42tDDQPABY68Y7+Tvq0RypqB9sE4N3lpWSG/WzcqSk9tEg7CMpdxw5j
	jsLblf22mx4N2K7q4jqv8kpjuMwYTRWc5vxbnDyz4rP7Q7KJE+Z4huur93YG5IYTOXIazRjUN0k
	1RT06g4Jm0q38m3F+5kEi7XkFn/9URXoOyn6ULqecSM0VDXuhQ==
X-Received: by 2002:a05:6402:358e:b0:66e:378d:2e56 with SMTP id
 4fb4d7f45d1cf-66e3eedec45mr7929165a12.6.1775551948068; Tue, 07 Apr 2026
 01:52:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331172011.3512876-1-jkoolstra@xs4all.nl> <20260331172011.3512876-2-jkoolstra@xs4all.nl>
 <pbobkjhtuli53o3z34ajyxztaosmztwlygxfxhhjq5ajt47inc@ngtoge3ucdm5> <2026-04-02-aged-convex-snowbird-foxes-Ym20JZ@cyphar.com>
In-Reply-To: <2026-04-02-aged-convex-snowbird-foxes-Ym20JZ@cyphar.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 7 Apr 2026 10:52:16 +0200
X-Gm-Features: AQROBzCvAizTWNJ0cjKYiQAmPZiL_VBNVb8McO5K2r3B9TnWKq4dAI0MnvUnod8
Message-ID: <CAGudoHH7z8CwAXMxAxTbjfovRBpne5f19Tz0okMh7_6G9NfQ-Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] vfs: syscalls: add mkdirat_fd()
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Alexander Aring <alex.aring@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Andrey Albershteyn <aalbersh@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	cmirabil@redhat.com, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6067-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[xs4all.nl,kernel.org,redhat.com,alien8.de,linux.intel.com,zeniv.linux.org.uk,oracle.com,arndb.de,linuxfoundation.org,zytor.com,suse.cz,gmail.com,infradead.org,efficios.com,linutronix.de,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjguzik@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F28A43AB89F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 4:52=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com> wro=
te:
>
> On 2026-04-01, Mateusz Guzik <mjguzik@gmail.com> wrote:
> > Trying to handle this in open() is a no-go. openat2 is rather
> > problematic.
>
> I'm interested in what makes you say that. It would be very nice to be ab=
le
> to do mkdir + RESOLVE_IN_ROOT and get an fd back all in one syscall. :D
>

Not handling this in either of open or openat2 does not preclude mkdir
+ RESOLVE_IN_ROOT + getting a fd in one go from existing.

Creating a directory was always a different syscall than creating a
file. I don't see any benefit to squeezing it into open. I do see a
downside because of an extra branchfest to differentiate the cases.

> > The routine would have to start with validating the passed O_ flags, fo=
r
> > now only allowing O_CLOEXEC and EINVAL-ing otherwise.
>
> Please do not use O_* flags! O_CLOEXEC takes up 3 flag bits on different
> architectures which makes adding new flags a nightmare.
>

With my proposal there are no new flags added so I don't think that's relev=
ant.

> I think this should take AT_* flags and (like most newer syscalls)
> O_CLOEXEC should be automatically set. Userspace can unset it with
> fnctl(F_SETFD) in the relatively rare case where they don't want
> O_CLOEXEC. Alternatively, we could just bite the bullet and make
> AT_NO_CLOEXEC a thing...
>

I would say that's a pretty weird discrepancy vs what normally happens
with other syscalls, but perhaps it would be fine.

