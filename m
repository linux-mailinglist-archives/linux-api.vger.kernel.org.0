Return-Path: <linux-api+bounces-6589-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4DS7OHpTKGrmCAMAu9opvQ
	(envelope-from <linux-api+bounces-6589-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 09 Jun 2026 19:55:06 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8071A66319F
	for <lists+linux-api@lfdr.de>; Tue, 09 Jun 2026 19:55:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=iZfBKXHF;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6589-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6589-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F3425303CD52
	for <lists+linux-api@lfdr.de>; Tue,  9 Jun 2026 17:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BC7376BE2;
	Tue,  9 Jun 2026 17:54:10 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7043EB112
	for <linux-api@vger.kernel.org>; Tue,  9 Jun 2026 17:54:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027650; cv=pass; b=qPQc7xC8YgecSFzIwERwiAP8n3y8gbnldg9Kb9KvtW3pqqjBHeUrga9XKdGCmrIfEO+cEJdAzH0XcsJ9hc4IWqbdBJ4GvzQVZkwBmJWhNg8WCryjKCbhvWtg8KH80BAU2Gg0ANys3gW4Kl0nv3Vx82d4OM8tXjOmiFhDxCEE+/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027650; c=relaxed/simple;
	bh=Hq4A7JGxJMTkiPV3o4Xs1UnKUenCIEORnYI3PIpLLJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYhP171aeWmv0Rpmq623EBBvKkWx2q3L9KAZYQJ98j8/Fx93vpGRosuZaUfO0niFKdA/wb40/jINu3dEBC4ZTsQ49VhYieigxam17gCNdbF+iPY5+rIpMwdKbpCbrz/2iutn7dMq5DyptzhQvUVOJrAjkKWjjTjhG5bERvZC0Kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iZfBKXHF; arc=pass smtp.client-ip=209.85.208.44
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-68ced08613aso47177a12.0
        for <linux-api@vger.kernel.org>; Tue, 09 Jun 2026 10:54:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781027648; cv=none;
        d=google.com; s=arc-20240605;
        b=anRdcxzitWC5uuh7TFxh8703Jf4mwsbH45W5u4A5PpHjj8YzEacwWTMR9uO87J2dUH
         x6LmplGV+Mj8yilm3pgxcptkKT6bwSAgx9gOw4Fab2X2mOWVTRvIIRj7jAzQthxTXKLS
         PcHSqYdByfciPRDvKkg6WCRZUxR5M+AVu2I2Pdmaf9/nn91LSyBt3Wt1LEdvVIl0hRJY
         XURnqU0iXxkU7TyRnuzuiaHXBPUMDdxuAfic/zKqWFr+oHbj7wiLZv6DWyrEZJOAMEfP
         HUs8HjehEjQ4Re8rIzfgVHGLSMXzgViPcklhlMUIn5ppPQkO22jR726QI5OT7VugpNd8
         BLgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iPo/rNEwfs0tGz+mQjgisI/ZCW4vs/mt/EjG+vliJIU=;
        fh=OpEZ3e2ktVSa96tqJT56ZWybHlHGTS1/qD8oQHR6EJc=;
        b=UEy06CJ25OlnYis0q/VTGjflpoydkeYlatLNVqaUC3oejBDJJcO6imwVbJHezf/UvG
         HQi/H51cDpucAbH5HpcyDGf/Me6BOlBVZ3pFJvXY+ll9i7ZiWxEDI0foZ6jjX7X5wt4o
         5WTcx7HhIxIkcBSB/JQeBv/M6KW3IP/KYhdrd4lFpqJ7sV7qhDXZRrCCKPQt4tdR1Cry
         FgJ58dN739hGUtV3gCFQ62DtyFXgfQniuBYizHZTQCdujidnolW26MREjyGzSbqlNVVW
         WtvqWcCZMABfBzqJiSTCTmrDNQU4yHRcVKSj/dZZYrEbaqJIdJoBkkK34RlzkhsnILzv
         bPiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781027648; x=1781632448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPo/rNEwfs0tGz+mQjgisI/ZCW4vs/mt/EjG+vliJIU=;
        b=iZfBKXHFAby34uHGpYi2VbZP+Pazod5Qc+pxnkwolhQruv5pTqedVLudlVv+YX3wSY
         Uvs1bWsokvHd9EcxespPGitXQUjQ02oG0JGpJMnsFiMTnvIw0gyWIUX/SB6RMjsEv+2r
         rhxt01z2rd5I/RDkyxkfpr3Oe8Hodptu2WuaiHnsd3DEDQ/nKhUoOSbttVz68dwtuT/j
         b+0OdPmoDhTN+E9jd6VE4rPpwar+vQttOWkEP8TTSpQQLlYx1hjyQJ7qHhos34m8vrKX
         mnbEnNErlEybTK8zbZ55NtPOVouI00Ayg/Ef+ogwn4FfwQIx5o5Ut5OR/Z/VmEkyhfB4
         7qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781027648; x=1781632448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iPo/rNEwfs0tGz+mQjgisI/ZCW4vs/mt/EjG+vliJIU=;
        b=nzAC4l9gCoibNuvlskV+Y0Lr5INFqUOooiWm9of28yaUF8yybT2gbxFcl4+U5QaqqO
         bcwfGEzJJbWczVgWT0dXGilTbfZ4XbZ2trpEHanxj60WuBsQ0uLgzO6xA2dusrTDCV1w
         KHlhAwEayIz3mH5oLQskgNs45Q57thKtnfZ5t2/+WKRUdyd+IkuAAiLcXBuNYuzOztTu
         NXs29PoefwtHeFPoeqE3798iPZ6igY/g6Pgkncg2uF2MZSDZBUZorwQV4KyRUslwD8mK
         iFW5CJpTjubOnkVBThTK+CMjS2MAbe3D1Af62eIII8F7n4Ad3tvG7G1fxiCqUtf6wqo7
         L6vg==
X-Forwarded-Encrypted: i=1; AFNElJ9UThXooOITmpG1h6GjMubpgdHXYfCC9uqNA+IXWE7XHprSLbYg+YEiMezAPD6NQO7pgnecG/aewMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7vaBz19Sx7dnkXcEis4EZr2cebUHrBmi6RP69xJW/tnP8tmjn
	IKG7bxbW4Y38OeDupUnQGxqOPgmNtDn0dXCh/jwQIG7qDCfh5Pc9R56m2CWHfM/OOxbc1mLbIxh
	dCSsve1sK4EWnYar1B+cONJxVhm7yUe2itm1OejcM
X-Gm-Gg: Acq92OEuY+Ujq0o0fMut99Nuf/yQEwyObgsNxj31nmoj1hqh8oGJvZEAD5zn/xmr1VH
	wASDeFowmMYy9lHEMdvUYvss9bD1FbMn6ZJMXlRPmFfTDIxlMhwxwR2yHSdW4GTfIgG0SVaPpUB
	SAcDLdM0Ys8fJrOWD1k6ZDhcyNxkX/zwq0QeVuTYpSsegIcKno86TWlgUCLflKPKjVtIUBjIiin
	KWcct2DL/dBo7zRjlf6C9goZjcJLVQd6L2Btyu+rBOH3bSUMHSz0AiPX+DwH2cxWriOM92tYyUI
	tU4iZOCSDcdfvBpo8kt7RXql+j7RNR/tuwHhyWJQkY+Tjilv
X-Received: by 2002:a05:6402:708:b0:68f:d45f:e497 with SMTP id
 4fb4d7f45d1cf-68ff191f2f4mr222363a12.14.1781027647308; Tue, 09 Jun 2026
 10:54:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528095235.2491226-1-me@linux.beauty> <vealb52tv5suireenkke4lul2l3wbnaul2rp3ea545ly5wa5ty@yk3aksvp7skt>
 <CAG48ez38OEE8ZPLyU6nr9=cYx-hMsdoh5WRrv-GMZGMDKyyOTA@mail.gmail.com> <lhubjdk1c1m.fsf@oldenburg.str.redhat.com>
In-Reply-To: <lhubjdk1c1m.fsf@oldenburg.str.redhat.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 9 Jun 2026 19:53:30 +0200
X-Gm-Features: AVVi8CdbotQb6TdiuBRRRFJLKPXdrZXdsDiaDY2tYNXV6Fkhva6G6BZKR3tezyY
Message-ID: <CAG48ez0FCqMaEgosy4K59pKan6Wn5RMbJeOuNWAc_m_56nDVYg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/13] exec: add spawn templates for repeated
 executable startup
To: Florian Weimer <fweimer@redhat.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Christian Brauner <brauner@kernel.org>, Li Chen <me@linux.beauty>, 
	Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:fweimer@redhat.com,m:mjguzik@gmail.com,m:brauner@kernel.org,m:me@linux.beauty,m:kees@kernel.org,m:viro@zeniv.linux.org.uk,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-arch@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:x86@kernel.org,m:arnd@arndb.de,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-6589-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jannh@google.com,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux.beauty,zeniv.linux.org.uk,vger.kernel.org,kvack.org,arndb.de,redhat.com,alien8.de,linux.intel.com,zytor.com,suse.cz,lwn.net,linuxfoundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sourceware.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8071A66319F

On Tue, Jun 9, 2026 at 8:08=E2=80=AFAM Florian Weimer <fweimer@redhat.com> =
wrote:
>
> * Jann Horn:
>
> >> Per the above, the primary win would stem from *NOT* messing with mm.
> >
> > As you write below, I think we have that with CLONE_MM? The C function
> > vfork() is kind of a terrible API because of its returns-twice
> > behavior, but I think if process cloning with CLONE_VM|CLONE_VFORK was
> > wrapped by libc in a way similar to clone() (with the child executing
> > a separate handler function), or if it was used in the implementation
> > of some higher-level process-spawning API, it would be a perfectly
> > fine API?
>
> No, there is still a problem with SIGTSTP handling because we cannot
> atomically unmask the signal during execve.  We need to unblock SIGTSTP
> before execve in the new process, but this means that it can get
> suspended by SIGTSTP.  Consequently, the execve never happens and the
> original process is stuck in vfork:
>
>   posix_spawn: parent can get stuck in uninterruptible sleep if child
>   receives SIGTSTP early enough
>   <https://inbox.sourceware.org/libc-help/2921668c-773e-465d-9480-0abb6f9=
79bf9@www.fastmail.com/>
>
> More on the low-level side, it's difficult to make sure that execve gets
> a consistent snapshot of the environ vector.  Both vfork and execve need
> to be async-signal-safe.  Any locking or memory allocation (except for
> the stack =E2=80=A6) persists in the original process after vfork returns=
.  The

I think that's not entirely accurate; if you call set_robust_list() on
a futex list, then call execve(), the futexes should be released once
the process switches to a new MM, in
begin_new_exec -> exec_mmap -> exec_mm_release -> futex_exec_release
-> futex_cleanup -> exit_robust_list.

So in theory you could use clone() with CLONE_VM and without
CLONE_VFORK, and let the parent either wait for a futex that is
released on exec, or somehow asynchronously check later whether the
futex is still held... probably not the nicest building block but
maybe workable? Though I guess it would fit more nicely if there was a
"munmap() this range on exec" API...

> environ vector can be large, so making a copy on the stack is not ideal.
> It's even harder for getenv/setenv/unsetenv implementations that use
> locking instead of software transactional memory.

Makes sense, that kind of sounds like a pain inherent in being able to
execute from signal handler context...

