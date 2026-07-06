Return-Path: <linux-api+bounces-6778-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oopRL07yS2oIdgEAu9opvQ
	(envelope-from <linux-api+bounces-6778-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 06 Jul 2026 20:22:06 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1744471471A
	for <lists+linux-api@lfdr.de>; Mon, 06 Jul 2026 20:22:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=EmYQtEHC;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6778-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6778-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BCE7303E4F5
	for <lists+linux-api@lfdr.de>; Mon,  6 Jul 2026 16:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F306388883;
	Mon,  6 Jul 2026 16:32:58 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655863AFD0C
	for <linux-api@vger.kernel.org>; Mon,  6 Jul 2026 16:32:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355578; cv=pass; b=m05JdcxJZv71+vIi7vZx9oYwJV6ia56jCuIWNakd7D8skmoLGVsrwNAfOjMPAedPLO6ac22Zuv3pBnAEW9UdF96G7sfPSCQM6vuxV4raQpPMN2Fc2IL/2cxUiv6h+xVmmag6tsKqo5MPjZ/ArtrEzk9V869FIOsJ3EpIWjg9h00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355578; c=relaxed/simple;
	bh=t4c/prX2kM47f73KS173peuhIQJkJQX0xyrhbtLBLqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnoI9rMhn60xoBW9LSYIX/a4fbT74tDjmELkJo+D/s001kLGcfUObb3QZebnaN7546STmvBrGjC5iwEx/qhaiJ2zW/07A/0na/SBs26oIiejvblKFBOVv1s7KK+TVTZFZYzJmWh1OeFWZDwHSS31/fh+cr1BSzjbw5ECg6AGwsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EmYQtEHC; arc=pass smtp.client-ip=209.85.208.49
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69a45011a92so1070a12.0
        for <linux-api@vger.kernel.org>; Mon, 06 Jul 2026 09:32:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783355575; cv=none;
        d=google.com; s=arc-20260327;
        b=PL4UkjO16HPRKyCAnAJPrjnOturdKlIUCih1I2SqIf2udYO+AKL6gKXAhX/9SKZXX2
         YxbA1TIUCHlPMjV1PD8BnoGsrQl3geIqtP+6VEpkW0EECcJ0lNn6GFMvG/Fu0pNq6GgR
         j4I7ZSCQh9o4wXKNByGOgavgqky8PKA75EGbHnKAQz7ubwtw12SdwFHQXIluzFQAgRcw
         iVm+xhmjhQVcDYSox9G6USQoCkD5+RLanzWsavtzzEI7hMnn0ffRYAnhv9MDyNWUm/hD
         n59BxhDTRLbibM+NGFb8Pqu5qFWZHp1Ugjimtw/+VOI8CY7xpy5rxxKqRD/UeP5JmUCp
         IWZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2UNDUGiqVvt711IXtO4cz//8EytDsjGbLNuNJRhGABA=;
        fh=eILIqzxG4658r3MMkihHovaUAdYsMLWPOlZ5rZPueqc=;
        b=YTmFBqjwLDsdxpjlA4Rs39uRX+3Nalu+F6wvdI66PMm/drh4+IRroNnNabFNgy+wob
         Vm51rQJRtuoPbWvic8bilWLZq//f6iwgbfSWME4/8pRn8iDvofkuNbKtAcn2r2yZ25Qq
         wr4UhRk5WkpukCnwKc6uA3PdvNvYD02fzk3IQJogTpQFq/1w9V1IBz5/+4ziqyUinsaU
         y24cxSMPF62WUglPGv/pNLjae8CqNm+XQV/q4V1rkyBNX8tjuuS/Iv60f+Rggx7Yztuz
         u2tsGHXa+3MoeV0EvnUYDcnVNGM3tMqErtEK9ADAln+IjTQaP6dayUQ60eoE3Jrblq+l
         p//A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783355575; x=1783960375; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2UNDUGiqVvt711IXtO4cz//8EytDsjGbLNuNJRhGABA=;
        b=EmYQtEHC3rJK9HuS6kuhKNlf3FDP85kdds1TVxEbvBE2CqtRgDgemp5I9xUh9tnBu2
         Pmm0OgtS3uY0N6QsXw910miH8lxqm0bfHjPUhL4Ek4JBY/zoqbl9BkzdUqaA0+5tD5RY
         rNO7Q//VJ149kJcW/XbNYcj9t9FzcZOHRhA7SmFrY/sKor2xHrbqUgtQtSVmh2TSjyBg
         JwYG6Qc5DXlYY+dByxKM3AGG8A8irZgfL7etu+XqHtZtwqifu/muoHjp628twd5cB6Mj
         kWqdZlIk4igcZMHlTl22SlmXY0Niy5uHDkuTGPbHsXrpYvXzGyUDAI0JWBvdEefs12KE
         tSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783355575; x=1783960375;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2UNDUGiqVvt711IXtO4cz//8EytDsjGbLNuNJRhGABA=;
        b=Z4BPElPBBZJBvBuJKkxNKivh9tHcU2pceZMIjs+DiGChtw9GIUT7dAhTmPvSdTFZuU
         TZcF0NliajoSwC43sRqwFoA5hlM5L+2FF/KhwAG3hSY5rOuBqVMSB/eDUzuTd6uSM3tI
         ElwTZDTcAdMIpo3HLL+t6l5RBGE0Qnp2PuDVMCv1UuA75IWRIgNRPLWK32UDamvXFJmY
         AWOOrRKgdGfG/DnVqaJKWweMIsgx0JggPBUD1l639TaGOxhx3JgL4CNCJGu2tkbrF6KR
         PhTwk4Xo4bOmqVnMffLQpveBazLYmaNV2BWadm5jgkgYL0P1j0fEJYWxQkCBrStQg/n0
         jHaQ==
X-Forwarded-Encrypted: i=1; AHgh+RoK3Xc6xpv9L1Uk+RdDN7Zd28ySmB1HumxfXco57A3vDc4pub1Xkg5bAWIbytBmx0o+5JWU+xmvElw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB0iEPL9tJkwtYlVNWdxsGiNdcHSvohPntEimhzMeCBi2zUWS6
	iR/X8ovfuCE/k8o6juJZsf0yM82XtWM2OWTPpoF9E1Wl3wKJUJojuunjWJop9W05sk7BBW7TePo
	t+waVRdKnwCFS2ivIbur88tyvc6J48eAzmJdrS4i0
X-Gm-Gg: AfdE7cm6kiAKzcBh9T4I+qtBcSeD3iOTMDtU6BmhhqsiZpDPytFhB2bQBGlJTh9u9WN
	NmKGdDo0G7kWMcxRMUdc0Lub+cnCSqY/zxVlTDUwlhQ9OG1Id18kZwEHNnq824we0TbOXVu4e4k
	5iPyZ8z7G5jsPlKR20V4kG2im64JeDwKVST8ZNeUt1G7Jg6T8gjLv9kaJbL+UrgK4Vxi+FRnLiU
	kpHreoNi0LLvLC0+UL1laZ7FMD/7Zr8Q3Ok5hcGIp8W3DjZsoK/BIntTTj0+Z7vQ3lkum48+bxS
	TCxvur1Cu1N8fwkE3rA//mjdBaw3RdQ1LCN89LA9RGQa5Fgm1T72pJptgg==
X-Received: by 2002:a05:6402:a2c6:20b0:698:aaf6:88ed with SMTP id
 4fb4d7f45d1cf-69a8d5ed3bfmr4552a12.3.1783355574513; Mon, 06 Jul 2026 09:32:54
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
 <20260629-hauer-erhitzen-sobald-96d3dff68707@brauner> <CALCETrVuh0-biOw=TgYN9ERTFAoiki57XeZ3S2T3dO2+hL54gA@mail.gmail.com>
 <20260702-entladen-farbkombinationen-klarheit-fe24cb608f23@brauner> <20260706-dabei-radeln-glitzer-71ecb835029c@brauner>
In-Reply-To: <20260706-dabei-radeln-glitzer-71ecb835029c@brauner>
From: Jann Horn <jannh@google.com>
Date: Mon, 6 Jul 2026 18:32:18 +0200
X-Gm-Features: AVVi8CeD6mwq1gcY0rcYzICnjlSpXjKTO3gnqdNJY9gW__HUf8Q1MpIvTqehCOI
Message-ID: <CAG48ez0sh7vEzBxtaG1HCJ0bmUMmhF_JR3=xXcc4+vpfB6LUOQ@mail.gmail.com>
Subject: Re: [RFC] Null Namespaces
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>, John Ericson <mail@johnericson.me>, Li Chen <me@linux.beauty>, 
	Cong Wang <cwang@multikernel.io>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>, 
	Sergei Zimmerman <sergei@zimmerman.foo>, Farid Zakaria <farid.m.zakaria@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-6778-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[jannh@google.com,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:luto@kernel.org,m:mail@johnericson.me,m:me@linux.beauty,m:cwang@multikernel.io,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:arnd@arndb.de,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:viro@zeniv.linux.org.uk,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,johnericson.me,linux.beauty,multikernel.io,vger.kernel.org,arndb.de,redhat.com,alien8.de,linux.intel.com,zytor.com,suse.cz,lwn.net,linuxfoundation.org,zeniv.linux.org.uk,zimmerman.foo,gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1744471471A

On Mon, Jul 6, 2026 at 4:52=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
> I think the straightforward solution to FD_NULLFS_ROOT would be to just:
>
> - make it always available
> - refer to the caller's mount namespace nullfs
> - work with fchroot()/fchdir()
>
> So I considered two chroot() use-cases for the sake of simplicity:
>
> (1) You want to isolate yourself for the sake of lookup
>
> (2) You want to isolate yourself to assemble a "private mount tree" but
>     not really be in a separate namespace (very odd use-case... but it
>     helps to make a point).
>
> The problem with this approach is that everyone who chroots into the
> nullfs root would suffer from the problem that any mount on top of it is
> still visible. So that kinda makes it pointless for both (1) and (2).
>
> Also all mounts that someone else would do would also be visible
> allowing multiple chroot()ers to affect each others state. That also
> would somewhat defeat the purpose of the chroot(). So I'm not convinced
> this is what we should do.
>
> IOW, I think FD_NULLFS_ROOT to chroot to the nullfs of your mount
> namespace is mostly useless and just not workable for unprivileged
> fchroot().
>
> Instead, this made me consider whether it wouldn't make more sense to
> allow unprivileged mount namespace unsharing for both CLONE_EMPTY_MNTNS
> and UNSHARE_EMPTY_MNTNS. Look, there's no real risk at all. It is
> literally just placing the caller into a new mount namespace with only
> nullfs in there. I fail to see any attack vector here. It's literally
> self-sandboxing and you give up access to anything that you didn't have
> a file descriptor open for. It's actually a bonus, because you don't
> need to use userns for this. You just throw away your filesystem state.

I mostly agree, though we might want to gate this on no_new_privs just
to be sure - you could theoretically have a setuid root program that
gives the caller more privileges if it can't find its config file.
That's kind of a far-fetched scenario, and in reality it would
probably fail because the dynamic linker can't be found, but there is
precedent for other sandboxing stuff also requiring no_new_privs, so
we might as well require that here, too...

(I think it actually might be fine to just make chroot entirely
unprivileged as long as no_new_privs is set, but I don't think we
should actually do that, that would just be unnecessarily playing with
fire and would probably confuse some security monitoring tools or
such.)

We should probably also reject if current_chrooted() is true, for the
same reason we reject userns creation when that's true.

