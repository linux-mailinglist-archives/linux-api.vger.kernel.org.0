Return-Path: <linux-api+bounces-6780-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qpuWDqzzS2p0dgEAu9opvQ
	(envelope-from <linux-api+bounces-6780-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 06 Jul 2026 20:27:56 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1B7714816
	for <lists+linux-api@lfdr.de>; Mon, 06 Jul 2026 20:27:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PjiLzONW;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6780-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6780-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46DEA358EB04
	for <lists+linux-api@lfdr.de>; Mon,  6 Jul 2026 17:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9448839E9AC;
	Mon,  6 Jul 2026 17:10:48 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42443383998
	for <linux-api@vger.kernel.org>; Mon,  6 Jul 2026 17:10:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357848; cv=none; b=c27w8C+fQTV9KaWtSvrBmPqzIr228AWrbmbmSP49LTDA0m1M62WZfuGaoA15v+EHfncB4B7GD8slzHFIJ8Mp8RViOQDjJudyGcESGkMUig57McDIjrYCAu6FKSSE/m74dv4DKjWeC12URhVYA4c7ootEjRnf5Ul8hD3WXZXmOYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357848; c=relaxed/simple;
	bh=UE1/A4JUkdvobYsxruX3DgPOIwXgNzWpCHo/V4LViqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DY8v2uupWXkJE330KY30MSmKggPzC0Wwl10q2QBp2jXBeTaSWNK+cOADKAhNxY7tqWt+bz9kUINcpVPQKo8eWaNK2htf27AiimgvW95nOQVPWH8B5Su6umP8gAzI6j04pY1LPDyS3dz+Xoc3VbK1pwdzkovFCzHBDGp1FHf5Tlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjiLzONW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137F51F00A3D
	for <linux-api@vger.kernel.org>; Mon,  6 Jul 2026 17:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783357847;
	bh=eJA0xUON18WtiblCyjyGpTE1Z5c5pH5jHS0SuDx0JtU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PjiLzONWALmqoNzeUTrvoOujjWzg3QQoQTvs5Fow3gv/QJQ+OEc7tzTZZFYL01TPD
	 Ei6FNSnO5SZPyJ22qWSTwI6eJ7kfjadg7gacET/Q6qeilh6i9P/SBkth86kRtZLjZp
	 BsvPNhmSMSUQOovDc7LtrDAC+SRXxH5GcQC19JDXCtKNinQDKKAXd7Hpd0RGJxMqgt
	 ev5v8GlDrX97glp72aE81uFI/nPT5PPAW4OLylPUzuap98KFP95Jyi5OajOGEMWuZU
	 8NusNpdOV8LhE+XXB8trjkfB/pmkqQLtUaw9jzkPzo0DcEz1h+WfL9KC4GlxuF7xMJ
	 CTj6EbcM81MwA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aeb2bc82ccso3082827e87.2
        for <linux-api@vger.kernel.org>; Mon, 06 Jul 2026 10:10:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RplrEWr1jfwR3Wm3YrouoisY2zY6R00IQqOxnulPW+SMNsKS2aWIYW9vHgMRmRoqz0NtBi8Ir1Yuos=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdO5HcLtkD/4lX0R5j6S2a2egxFiU6dqQqg/s9YdN10z+7Zd72
	BsFcSkHyGCN6RVBPZ6ULmG02HwtCEEB9tBjsUxD7wkIPlD9reMzDvz221/uB9K7s48rhCf2EnBj
	1PLVBYPE2KW1QZO7GpHb4QudzIGireXiIwkPC4jJv
X-Received: by 2002:a05:6512:254e:b0:5ad:5cec:74d4 with SMTP id
 2adb3069b0e04-5b007bc6019mr205711e87.41.1783357844812; Mon, 06 Jul 2026
 10:10:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
 <20260629-hauer-erhitzen-sobald-96d3dff68707@brauner> <CALCETrVuh0-biOw=TgYN9ERTFAoiki57XeZ3S2T3dO2+hL54gA@mail.gmail.com>
 <20260702-entladen-farbkombinationen-klarheit-fe24cb608f23@brauner>
 <20260706-dabei-radeln-glitzer-71ecb835029c@brauner> <CAG48ez0sh7vEzBxtaG1HCJ0bmUMmhF_JR3=xXcc4+vpfB6LUOQ@mail.gmail.com>
In-Reply-To: <CAG48ez0sh7vEzBxtaG1HCJ0bmUMmhF_JR3=xXcc4+vpfB6LUOQ@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 6 Jul 2026 10:10:32 -0700
X-Gmail-Original-Message-ID: <CALCETrW6HO22peDYwA44Kk05YdLbsK4mJ51R7qodLUUBYnspGA@mail.gmail.com>
X-Gm-Features: AVVi8Cfu2si1SpvPZPvwXFx-sB9HeAk226nHqLE8GCDNAolic_zOW6mpgLOpyNU
Message-ID: <CALCETrW6HO22peDYwA44Kk05YdLbsK4mJ51R7qodLUUBYnspGA@mail.gmail.com>
Subject: Re: [RFC] Null Namespaces
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	John Ericson <mail@johnericson.me>, Li Chen <me@linux.beauty>, Cong Wang <cwang@multikernel.io>, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Kees Cook <kees@kernel.org>, Sergei Zimmerman <sergei@zimmerman.foo>, 
	Farid Zakaria <farid.m.zakaria@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6780-lists,linux-api=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jannh@google.com,m:brauner@kernel.org,m:luto@kernel.org,m:mail@johnericson.me,m:me@linux.beauty,m:cwang@multikernel.io,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:arnd@arndb.de,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:viro@zeniv.linux.org.uk,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[luto@kernel.org,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,johnericson.me,linux.beauty,multikernel.io,vger.kernel.org,arndb.de,redhat.com,alien8.de,linux.intel.com,zytor.com,suse.cz,lwn.net,linuxfoundation.org,zeniv.linux.org.uk,zimmerman.foo,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA1B7714816

On Mon, Jul 6, 2026 at 9:55=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>

> I mostly agree, though we might want to gate this on no_new_privs just
> to be sure - you could theoretically have a setuid root program that
> gives the caller more privileges if it can't find its config file.
> That's kind of a far-fetched scenario, and in reality it would
> probably fail because the dynamic linker can't be found, but there is
> precedent for other sandboxing stuff also requiring no_new_privs, so
> we might as well require that here, too...
>

My ancient patch did this gating.

FWIW, if we are contemplating letting unprivileged tasks chroot to an
*empty* mountns and they don't have privileges to bind anything there,
then the mnt_may_suid() will prevent them from using execveat to run a
setuid program.

> (I think it actually might be fine to just make chroot entirely
> unprivileged as long as no_new_privs is set, but I don't think we
> should actually do that, that would just be unnecessarily playing with
> fire and would probably confuse some security monitoring tools or
> such.)
>
> We should probably also reject if current_chrooted() is true, for the
> same reason we reject userns creation when that's true.
>

These empty-tree proposals might expose a little issue in
current_chrooted().  We don't want to check whether our root is the
namespace root -- I think we may want to check whether our root has a
parent.  Otherwise once you chroot to an empty tree once, you can't
chroot again, which is silly.  Maybe if we add this empty tree thing,
the definition of current_chrooted should change.

(This is already an issue with open_tree and probably even with
detached mounts before that, but I don't think it's as easily
observable.)

