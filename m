Return-Path: <linux-api+bounces-6714-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0XbFLQ+qPmrAJwkAu9opvQ
	(envelope-from <linux-api+bounces-6714-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 26 Jun 2026 18:34:23 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A55A6CF239
	for <lists+linux-api@lfdr.de>; Fri, 26 Jun 2026 18:34:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=johnericson.me header.s=fm3 header.b=SPlopbP4;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="d RYp2Eh";
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6714-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-api+bounces-6714-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=johnericson.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1525130A57EE
	for <lists+linux-api@lfdr.de>; Fri, 26 Jun 2026 16:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEBA3F9F47;
	Fri, 26 Jun 2026 16:26:33 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209633E2AD1;
	Fri, 26 Jun 2026 16:26:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782491193; cv=none; b=shcJeTTDwQ6rRk7Xq5YKv0+D1GTjSketmewI/xnR7vAa6ZGRnccQ9dbEOA6HXx1ir64tvImhz7lgfBnfKGHYt7YZsd29Ta21Cha1zCFkJ1T6Gdlgfpl0PAlrUse1/I1T+hn61dhwUFPxTVWsBXrCDZV8II6OYQKmnbSuXS8fpq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782491193; c=relaxed/simple;
	bh=Mz/U24SwsVtPOUHfNr1Quz+WAfYt6WoruIadhcSODqs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dYNu67OhWbYMCU+biJ5SbRJK3dDKM6C5tG+yvpnF//sYduxk3KttgD+c0WWWjwpwn2set5kGbJcb8xFdNLXukmOT8g6yDN2IMzI15b8i676XRoVpshsAg6erS8skKtug2u8hqTG9NdK5N5jLQAl0H9Y6RpEgd/0fej9Yt1H3mbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me; spf=pass smtp.mailfrom=johnericson.me; dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b=SPlopbP4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dRYp2Ehi; arc=none smtp.client-ip=103.168.172.136
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 28702138003B;
	Fri, 26 Jun 2026 12:26:31 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-05.internal (MEProxy); Fri, 26 Jun 2026 12:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnericson.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1782491191; x=1782498391; bh=zo1vKmi6nDEQFw10MzbUtqBMgAqbeul2
	j6P3vSvt178=; b=SPlopbP4GHueoT5BMNLqY+W4uGbAwB7jgw8agYIaF28shVlJ
	wK+qVZDYILJwhka56O2+QDYejbn+J076sNf/S5wRAqjesV2RGpprbRZbUApJH0/V
	agJmXOataX29I4DlvVvrdlQDJGf+TPxGYL812FMMOFJ6koI1srV0VVuCK8708xYi
	JliDazJjoyO6tyLhbuwW2fCs7YO/9cBZaaKbkraRN3SMiebslX78owsfSz/rcGpE
	4oUUgHcP61VyMt7Sr+7Na6Gtzt2/5YxmynYsG8cZWAbIWm13GkNcu5QTfyb1nhJH
	ovsSv1YsA8tzbvFHlKhZnYdrQuWYPX8OHeNUfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782491191; x=
	1782498391; bh=zo1vKmi6nDEQFw10MzbUtqBMgAqbeul2j6P3vSvt178=; b=d
	RYp2EhiXV6GsJrVk1oSNWuBObCMSYuI6jdEsE0jW+k6solP1QmAKUGSO4hMrU+Ig
	kBJXiMo6ecgXTDa2oQb0ck7puBap8f4nAshtLteQDCq5GnToY6DwWqvwstgi9Psp
	Lxfd67txHAJ7I0iYze3F3q1g8Xha9dzkHy2Bt9pp2gjq06HhXrfGau7nkblXe1m8
	lax94wM9GhDnH0WZK0PmTTsmJW7U1RTsfv/hJe0oyOgpqohKQmYrByJa6bzbjXGh
	vre79tsw5dXQWXhlQVKfa78bnT9XTMMFvCV1hm7Pjt2fXQFuec65oAwW+t1au/0F
	ksRBEGo/z9mhjwBh8RSDg==
X-ME-Sender: <xms:Nag-auWLtcHt889oRmjF6T0gdOKSR2Ux2gwekvx9hJf8goqgFzeHZw>
    <xme:Nag-alYip_4aAgrSnK6xbQSQSZjOhc-92PCq5HlaNxRW8KXf39qO9odKYBWcXnJht
    EW6eDC240djqRV2M9HE-tOh3zKFIdh5B4JbMvnOjcvZBuM1YYF4Xw>
X-ME-Proxy-Cause: dmFkZTFgiFjdRsukHEqzjO2JlLF7qtQ8Ajnv4KbpUVK5BbcUW0/0LZ3HdLzuqk6crIinlh
    AT292UJL2AHJNFqudBA5tfxvDt8hYr7Pdk4v+1HQ4wDmBditK366BV6RX9xHSDn80klhcA
    d/vBx2JAgw9T6A8zOCaf6hAUcvgu+oKBKIXdZtdeYeTcpeq9azqtWPuyLZccbY0lvTBD/M
    GAjnp4AJZR97bP7ThB/C4qvdSCeWKlTgEBzROUQtIgrMMB58RTEvrcvNORUWnWIkl0ZBg/
    Ont/O9F3HXeMnaYCvOtEysBRg5fpV3zKl5dqOExuwEjnAL1ss0NO2OstgPGN0e7O+pvzcU
    Mf7k7w2q8iqj3hDGPHirXoPB+oL9jzueRN2HJAkmyFfqYApCHRQTBdj66ufCko0o05sdqA
    s3Hw54rZHUpSr0yvj4dHK0KbY8HUEXntKsyhG2nWa96gZpMWQirZSLzhHQD/V/+/dJLbKQ
    8SrgF383091dRJiIIZ061ttxGeRjqMl31lAO+zb2f0epruqcpwsvKjJ2ayBCaCWO1+xUTQ
    CnGBtEbfQwHqL/+FpOYhlGOm7OOCStq5irIwAPMHj+WsfX0qIXEwtZfHc0d8TETmTVrhzX
    Zp8WdrXxKjG2CNHFpH/klWZpMczA8gYkg91B3O8TA7TNvVnbV23t+TjN1iww
X-ME-Proxy: <xmx:Nag-ask1XphmWFQQNKq8v7Fq8pQRsEsRBwdUXQMUX-EVamT2DDV7Iw>
    <xmx:Nag-apDT832kxHmlJjNL6sl4q37nvlQWiRULoK-DA1e4dcjFfDGvbA>
    <xmx:Nag-avLsW5GcdZwYn_d-y8EvNfvw5esU3-vroppDogeMrGWKewTQBQ>
    <xmx:Nag-akxW5tuizNbDxm51vDsMBMAJH9eQrB5T0zo5xMAk-onLEXD1VQ>
    <xmx:N6g-amMIh2rml7_nZOvyXzk16RhXb0pM48ntbw0pojR4GlFdtIUpjoRO>
Feedback-ID: ieb4144f1:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 952122CC0083; Fri, 26 Jun 2026 12:26:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AG8qDlxFSDr7
Date: Fri, 26 Jun 2026 12:26:09 -0400
From: "John Ericson" <mail@johnericson.me>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Andy Lutomirski" <luto@kernel.org>, "Li Chen" <me@linux.beauty>,
 "Cong Wang" <cwang@multikernel.io>, "Christian Brauner" <brauner@kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-api <linux-api@vger.kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Jan Kara" <jack@suse.cz>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Kees Cook" <kees@kernel.org>, "Sergei Zimmerman" <sergei@zimmerman.foo>,
 "Farid Zakaria" <farid.m.zakaria@gmail.com>
Message-Id: <ba6be060-2dd8-4cda-ac73-4b154f968692@app.fastmail.com>
In-Reply-To: <20260626001538.GO2636677@ZenIV>
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
 <CALCETrWhXNetw-BsAaoyT31suMmjYLdMh9MAuLB2Lvk2ac-31g@mail.gmail.com>
 <CALCETrU3bgUxp0k1y-U-uL0-fW2016Gmsyu9O_=830czEUGMcQ@mail.gmail.com>
 <103524f8-1658-41df-88e9-cf49c628a721@app.fastmail.com>
 <20260625011023.GM2636677@ZenIV>
 <a75a9b82-a15b-4893-8f92-62b62664ea83@app.fastmail.com>
 <20260626001538.GO2636677@ZenIV>
Subject: Re: [RFC] Null Namespaces
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[johnericson.me,none];
	R_DKIM_ALLOW(-0.20)[johnericson.me:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6714-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:viro@zeniv.linux.org.uk,m:luto@kernel.org,m:me@linux.beauty,m:cwang@multikernel.io,m:brauner@kernel.org,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:arnd@arndb.de,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mail@johnericson.me,linux-api@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[vger.kernel.org:server fail,johnericson.me:server fail,app.fastmail.com:server fail,et.al:server fail,messagingengine.com:server fail,tor.lore.kernel.org:server fail];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[johnericson.me:+,messagingengine.com:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@johnericson.me,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux.beauty,multikernel.io,vger.kernel.org,arndb.de,redhat.com,alien8.de,linux.intel.com,zytor.com,suse.cz,lwn.net,linuxfoundation.org,zimmerman.foo,gmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,johnericson.me:dkim,johnericson.me:from_mime,et.al:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A55A6CF239

On Thu, Jun 25, 2026, at 8:15 PM, Al Viro wrote:
> On Wed, Jun 24, 2026 at 11:41:07PM -0400, John Ericson wrote:
>
> > But I don't want that global state.
>
> Don't use it, then... out of curiosity, does that extend to stdout et.=
al.?

Good question; it turns out I like the standard streams much better!

First of all, the standard streams are just an idiom --- there is
nothing actually special about file descriptors 0, 1, and 2. That's a
clean design --- the kernel doesn't need to know about userspace idioms.

Second of all, if you don't want any of those, you can just close 'em!
You can't do that with the cwd, however. It's stuck open.

Ideally `*at` would have been with us from the beginning, and, say, file
descriptor 3 would have been the "current working directory" merely by
convention.

> Would that kind of thing added kernel-side assist the development of s=
uch
> library?  Maybe, but I wouldn't bet too much on that - if you start fr=
om
> scratch, you can trivially verify that you don't even attempt given
> set of syscalls and if you use libc as a starting point, you get to
> debug all the failure exits you've added...

First of all, I am trying to change what processes are allowed to do,
and this includes programs I did not write. A libc-based solution is the
program cooperating with its own sandboxing; this is not a solution for
running arbitrary programs which may not be trusted in a restricted
manner.

Second of all, this would be very laborious in practice, because we're
talking not about what syscalls the program uses, but about what data is
passed in those syscalls. Any program that consumes arbitrary user input
(like shell utilities) might receive an absolute or relative path, and
so it would have to manually check for that, lest the user input "trick"
the program into using the root dir and cwd it is trying to ignore.

Making a tiny few edits in the kernel path resolution logic to allow for
these null fields is much more practical than defending a much broader
perimeter in userspace.

> > The programmer (or coding agent) is
> > encouraged to do everything with file descriptors rather than path
> > concatenations etc., because they need to use `*at` anyways, and then
> > voil=C3=A0, without browbeating anyone in security seminars or code =
review, a
> > bunch of TOCTOU issues disappear simply because doing the right thin=
g is
> > now the path of least resistance.
>
> I'm sorry, but the path of least resistance is picking a snippet from =
google
> that will implement open(), etc., on top of your setup and using it.
> _Especially_ if coding agents are going to be involved, precisely beca=
use
> they'll do a convincing simulation of human duhveloper's behaviour, i.=
e.
> "cut'n'paste it from the net".

We agree! But this is precisely why it is important to make these things
fail. Mindless Stack Overflow cut'n'pasters (human or agent) still run
their program to make sure it works. Making the thing you don't want
them to do *actually fail* creates sufficiently strong and incremental
feedback that they will end up doing the right thing.

> > The current working directory, roughly, is *just* some global state
> > holding a directory file descriptor.
>
> So's the descriptor table; what's the difference?

Now that I've responded to everything else, I can answer this in
summary:

- File descriptors can be closed; cwd and root cannot be.

- File descriptors need to be explicitly used in syscalls. The cwd and
  root are implicitly used (in too many different syscalls to make
  syscall-level auditing practical) based on the sort of path string
  argument to the syscall, without the program's explicit consent.

John

