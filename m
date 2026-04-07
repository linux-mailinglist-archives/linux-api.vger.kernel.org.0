Return-Path: <linux-api+bounces-6068-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2H9HAS7I1GlbxQcAu9opvQ
	(envelope-from <linux-api+bounces-6068-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 07 Apr 2026 11:02:38 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FE23ABB17
	for <lists+linux-api@lfdr.de>; Tue, 07 Apr 2026 11:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A715530063BA
	for <lists+linux-api@lfdr.de>; Tue,  7 Apr 2026 09:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F78207DF7;
	Tue,  7 Apr 2026 09:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWl/6TbX"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977BB39B978
	for <linux-api@vger.kernel.org>; Tue,  7 Apr 2026 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775552432; cv=pass; b=BocCpzEyXaSea7DyjUjomdXxRYqVl12sc8hg+ryziJjT30C6lV9w1AynbX7zpLt7OtCXuvBHRJGnt4UP0Y6jp+zhn2rXXe1MQV58+ybIRt1q4pFN14CuKuwM0TOBqoyiBV4PtWwhxkrl1LJwucoL+hErb9enBUsW+50xWcvCZXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775552432; c=relaxed/simple;
	bh=/qHCexAei7RF7p2L9Y8baQacw83HsvWaoqQzNumxOc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QmJWT7B+/GKNT94YX5IxnMFk6zxbnr4s5j+b6+cnlozmwcVFIcZrAfsShQS7MSs9699yw/ESnV2qav4NxKTEEi7221JxbmmQay8EPU93mFZd7ih69uiQuMOykfoydnEDFXoIlak36ZM/8hMMVsc7DAtvRnVceeW1lqgpF3Zei1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWl/6TbX; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-65c4152313fso6301027a12.1
        for <linux-api@vger.kernel.org>; Tue, 07 Apr 2026 02:00:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775552429; cv=none;
        d=google.com; s=arc-20240605;
        b=ZCRpAcuRq05GDHrqsdqwcpFIio4usCbKZXy20mGypNP7qwkXqBGrYb5hUBRyhB4zla
         nttVsFxA1m5+LpNSN9E2kszA2Silx2N/jbpaT5Mx/GS2j3BfJryrMcf0jdykN+0UTXOj
         rQjK55oQOphF4xUGjr5Bfqr6lSHRubbJIxWXCEsLMhcpq/DTw3zMzHLJz93qAvWhdpxJ
         y/ttJqwyV80imR3iy/LFzRkrIdpEeWAQdm9yu7g0RxwZwInn3PJW/OjNPkIJOiigR3EQ
         30+Xt/38D54qK1FvJMkLO5R+nRSkvrkTiEcoU6pK9zRIs2hoxqBPqq2Ht8zBI7FQWAD1
         UeDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FFOsIxaJz5dSO/KiouzcRuRQBGo6Ioal7l5wuulXe+0=;
        fh=j3skdNuR5EIDI/AVFFlmfO7Kq/oCtr+2MWQXsbHny5U=;
        b=hGTIi9n+8Je6XYSMmTqseKQZeceTwYen6klnpAcSuUvmZXj66EEYIj6/B2zSmjvjuH
         /Bf4hC1PJuF5RZgRNODoZjL8LmVzFNnTBAhHFgVnSi/EQzcbete4VscTRCUxFAobWSuM
         37eZgyC8v6MwXTAQUv/J/pqhzyqg46ZTyA6ECOjrVwdI0ut0yGDcPge5zFBU7/Ihr9hK
         vp61i1RKGoczEU0Gt/kXK013z715DkPGwCw1270zXHan1ulVO+J+trdTMS0wfXNmGwqA
         NFTuVxVCBTVA2sTfvnd6tjioxN1EaCjwfc4gPtqmILoh2X7lvd6AVJvEA+xwBkDTUEYx
         Xbrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775552429; x=1776157229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFOsIxaJz5dSO/KiouzcRuRQBGo6Ioal7l5wuulXe+0=;
        b=jWl/6TbXsKsAwDhGUGza9pOYYIBVHnidqHYZTBVdaNbTX9ME5XX/rm4v363GU9j5K9
         KQG4134uovS+P/PiXTyazoN4TumiD86pUuTXHVfHLjW+BvVwQFtqhDsA/IXvSTprjNXy
         7edCAZE7Pcl+1sP3Lh2g8/2CIzpzt8dAQFQCCpR1jDYvr4DdCtfAt6Sc417uB2zBWwPS
         58Mzjh+JRCtXrk7IcDCzUxowbPgOQvdHzZS+C4vX2WgMl/J+R0D07WkC+s8Ihx8hDnb1
         yeCkZ3wUBgrS7mqij9tHcusixgBsVpQL6ov3Sp12bckyj0tzmEIvLv8aOz7RpkXCJ0lV
         HjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775552429; x=1776157229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FFOsIxaJz5dSO/KiouzcRuRQBGo6Ioal7l5wuulXe+0=;
        b=R4NpP9jxUZKuRZRwnv5mwWcsJ/WcODZ7hfMB3byT0FtljVedZvRTtj7BYel4nKNeTe
         Abq/PC5Tz63mleG2bQGUpzV3qITQlyPtCBaWSp366K0UmNIY9Eq0T2xycVXvBo9flwbU
         dOZwfLiRiKr567oj/tXT+PdFCZwyRn9siZFdGlSDopJw3PvTnUD5nGU+5j63fKJStbqv
         CggKvHYdFaQAfKtO3b4m1qByYtRa3XZZ/sIikVClNpI3ZVHTpNOzYS8wn/hBIqR/HqkO
         3KuBnyO/67J3IhkorPMYDyfGYnINz4vSfdVy4rvPkHWltU+Pytd4cuHlw7pYEpGF55PL
         Vr/g==
X-Forwarded-Encrypted: i=1; AJvYcCVo3tUFnAq/bICWKUyOHRhQrWAfFZBmykuTlpgew+MdSQyg8Sf5DOnT6LSP0YYAlS+sVc/bwIC50xM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/MKdBpZa1nNQ4u7gGEoPPLd2eMapQzQrMCEs0AGrVo0mOYQKT
	YslIv0myVdp1LYrgR6ozaZlVgF+J22iQMrk2GjV7p9YgoF1q5Q0fM9OGWvxFLxAcih4yno9Hk4W
	mslwf66adzYYXkT5nY/nmdptBHH+rDA0=
X-Gm-Gg: AeBDieubfK65RgXeXgLx1fmidLyH4V88pHYTWM6jFnEbMwxSOxTmbjon65Y2UgezvsL
	8ySmE78Efrzzn5WIcPp7GXNOxbpzKJwNfdVZz2dLTRTugv3+qbl10yiiHPSg0N2Xuid5SzQ2Ntd
	ZAHGX4kLMai8ri8eDxGjbx5UTjuax7b8R/4V8vmrSDCXK/GCe8a7sAnPk3kYh9tP6TjXUSWK8kc
	PogC5m7D9JL2vgtgeqIZzOPE4MLhhN8FA63NLniOaOZUSnSRx/5/SFEtU2Rk8y59Qa9BYfkdW7C
	XOWyxzgllMDSKuwgOj9r564KIdhYU9R/AhXXbUPtnzbYVyofFA==
X-Received: by 2002:a05:6402:354f:b0:66e:6ff8:58ea with SMTP id
 4fb4d7f45d1cf-66e6ff85a1cmr5384406a12.4.1775552428473; Tue, 07 Apr 2026
 02:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331172011.3512876-1-jkoolstra@xs4all.nl> <20260331172011.3512876-2-jkoolstra@xs4all.nl>
 <pbobkjhtuli53o3z34ajyxztaosmztwlygxfxhhjq5ajt47inc@ngtoge3ucdm5> <1632825771.784338.1775039101736@kpc.webmail.kpnmail.nl>
In-Reply-To: <1632825771.784338.1775039101736@kpc.webmail.kpnmail.nl>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 7 Apr 2026 11:00:15 +0200
X-Gm-Features: AQROBzCSqaG2KiYg9FZOSa8vXjApBFJDEWda_0GT-r0h8fSgpilsGWZjwPwtzvA
Message-ID: <CAGudoHE-zSfiL2aVf41UHOtMsE53gCqLpVoy-NxoB8HeXtdgEA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] vfs: syscalls: add mkdirat_fd()
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Alexander Aring <alex.aring@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Andrey Albershteyn <aalbersh@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, cmirabil@redhat.com, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6068-lists,linux-api=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[xs4all.nl];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjguzik@gmail.com,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zeniv.linux.org.uk,oracle.com,arndb.de,linuxfoundation.org,zytor.com,suse.cz,gmail.com,infradead.org,efficios.com,linutronix.de,cyphar.com,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 59FE23ABB17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 12:25=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all.nl>=
 wrote:
>
>
> > Op 01-04-2026 06:19 CEST schreef Mateusz Guzik <mjguzik@gmail.com>:
> >
> >
> > On Tue, Mar 31, 2026 at 07:19:58PM +0200, Jori Koolstra wrote:
> > > @@ -5286,7 +5290,25 @@ int filename_mkdirat(int dfd, struct filename =
*name, umode_t mode)
> > >             lookup_flags |=3D LOOKUP_REVAL;
> > >             goto retry;
> > >     }
> > > +
> > > +   if (!error && (flags & MKDIRAT_FD_NEED_FD)) {
> > > +           struct path new_path =3D { .mnt =3D path.mnt, .dentry =3D=
 dentry };
> > > +           error =3D FD_ADD(0, dentry_open(&new_path, O_DIRECTORY, c=
urrent_cred()));
> > > +   }
> > > +   end_creating_path(&path, dentry);
> > >     return error;
> >
> >
> > You can't do it like this. Should it turn out no fd can be allocated,
> > the entire thing is going to error out while keeping the newly created
> > directory behind. You need to allocate the fd first, then do the hard
> > work, and only then fd_install and or free the fd. The FD_ADD machinery
> > can probably still be used provided proper wrapping of the real new
> > mkdir.
>
> But isn't this exactly what happens in open(O_CREAT) too? Eventually we
> call
>                 error =3D dir_inode->i_op->create(idmap, dir_inode, dentr=
y,
>                                                 mode, open_flag & O_EXCL)=
;
>
> and only then do we assign and install the fd. AFAIK there is no cleanup
> happening there either if the FD_ADD step fails. You will just have a
> regular file and no descriptor. But I would have to test this to be sure.
>

FD_ADD(how->flags, do_file_open(dfd, name, &op)) means fd itself will
be allocated upfront and only then file creation will happen and which
is what I'm saying is how it should be done. With your patch the
directory is created first and the possibly failing fd allocation
happens later.

> >
> > On top of that similarly to what other people mentioned the new syscall
> > will definitely want to support O_CLOEXEC and probably other flags down
> > the line.
> >
>
> I agree, and perhaps O_PATH too. Maybe just all open flags relevant to
> directories?
>

I don't know about O_PATH as is, but certainly the syscall needs to be
able to grab more flags in the future.

> > Trying to handle this in open() is a no-go. openat2 is rather
> > problematic.
>
> I don't think that is necessarily true. It turned out O_CREAT | O_DIRECTO=
RY
> was bugged for a very long time. Christian Brauner fixed it eventually, a=
nd
> that combination now returns EINVAL. But I think there is nothing really
> stopping us from implementing that combination in the expected way, apart
> from whatever reasons there were for not allowing this in the first place=
,
> which I don't know about (maybe mixing semantics?)
>

I am not saying it's impossible. I am saying mkdir was always a
separate codepath and in order to change that you would need to add a
branchfest to open. I don't see any reason to go that route.

