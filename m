Return-Path: <linux-api+bounces-6773-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id djs1AVrYRmobegsAu9opvQ
	(envelope-from <linux-api+bounces-6773-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 02 Jul 2026 23:30:02 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9826FCF6C
	for <lists+linux-api@lfdr.de>; Thu, 02 Jul 2026 23:30:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=zytor.com header.s=2026062701 header.b=JjRazOYC;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6773-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-api+bounces-6773-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=zytor.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A384300F97D
	for <lists+linux-api@lfdr.de>; Thu,  2 Jul 2026 21:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2533A1D02;
	Thu,  2 Jul 2026 21:29:56 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90703932D5;
	Thu,  2 Jul 2026 21:29:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783027796; cv=none; b=egmUnJs8SvJXWaznLeFTnouXH0kBfsbR8ZZNdVNP5wRKpCcQmleNLG1lO1/svbvbNB1hQrJGwMz7tEOgGw0MbJEEiXTpvhdv8Uy15+qfJf0rhNtFebgr0xJ44ThldYQA2kF3tLCfVVLcSNpMvZ+28WUxYKySvCqeuu3/NFgFRfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783027796; c=relaxed/simple;
	bh=5oqrz+LiMDK9676ekvxbm63fiiDM3SLGNSviWUWLyUw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=TXoAuz/4vz1a50O7FQmgJvT0qhZ77774rClhjhQIB/bGEsnb+1apFU8qsLR/33gZNB7WQpS+ce5rYYTvWCABaG+MH7UWn/p1Hu2vgTwrK90Dzaw4W1jufTw4Jljh/JcCjnIUjE6agZ9TG1gLrmJFAa3PMZGEW1L0i3Fw+63TF90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=JjRazOYC; arc=none smtp.client-ip=198.137.202.136
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 662LSpZ1948852
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 2 Jul 2026 14:28:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 662LSpZ1948852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026062701; t=1783027734;
	bh=5oqrz+LiMDK9676ekvxbm63fiiDM3SLGNSviWUWLyUw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=JjRazOYCGaKR92P0cSVuUmaQglN45uw1vmjGKHTMMApJ5ng3yO2m7uUXAGnLAO8YB
	 dvezkE/ogdWcdtB56F8e5SzRQFBhH533pM84OUDfN0jtHyRUgW0jxKgU1QBeb6FKCX
	 uJZzEU3OzY/qtGWTwaXof9nW+ebTux19vmtwlCJZQd/eSv0ienAOqsDzu3jDHkLzms
	 9iIkufLnlHxDUOjqeojucA+/YaNjWLZAQTZDh1DRJ7MfDgQCV1OgPMvHzj99R1EP04
	 8jE3V5voYF5qEn9wjMjUgmozONba8ix89uniHZB8I0h8ZRbFFveSVWgPsbQF1Aggdp
	 8Xo1VgP7pIHfQ==
Date: Thu, 02 Jul 2026 14:28:46 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>,
        Christian Brauner <brauner@kernel.org>
CC: John Ericson <mail@johnericson.me>, Al Viro <viro@zeniv.linux.org.uk>,
        Li Chen <me@linux.beauty>, Cong Wang <cwang@multikernel.io>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>,
        Sergei Zimmerman <sergei@zimmerman.foo>,
        Farid Zakaria <farid.m.zakaria@gmail.com>
Subject: Re: [RFC] Null Namespaces
User-Agent: K-9 Mail for Android
In-Reply-To: <akTgQH1YIg2blzRe@lt-jori.localdomain>
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com> <20260624231219.GL2636677@ZenIV> <29cd3188-2d7c-4470-a39a-6648638f795e@zytor.com> <614b290f-e274-4eb2-b687-008b004de526@app.fastmail.com> <20260629-zoomen-tragweite-redakteur-dc6c41c9c151@brauner> <akTgQH1YIg2blzRe@lt-jori.localdomain>
Message-ID: <A656CDC3-6A62-4DC7-AB97-1ADF1622165D@zytor.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026062701];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-6773-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[xs4all.nl,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jkoolstra@xs4all.nl,m:brauner@kernel.org,m:mail@johnericson.me,m:viro@zeniv.linux.org.uk,m:me@linux.beauty,m:cwang@multikernel.io,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:arnd@arndb.de,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[hpa@zytor.com,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[zytor.com:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[johnericson.me,zeniv.linux.org.uk,linux.beauty,multikernel.io,vger.kernel.org,arndb.de,kernel.org,redhat.com,alien8.de,linux.intel.com,suse.cz,lwn.net,linuxfoundation.org,zimmerman.foo,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D9826FCF6C

On July 1, 2026 2:49:42 AM PDT, Jori Koolstra <jkoolstra@xs4all=2Enl> wrote=
:
>On Mon, Jun 29, 2026 at 12:39:56PM +0200, Christian Brauner wrote:
>> > The kernel rightfully has consolidated path resolution in a few key
>> > places as much as possible -- the internal `struct path` does not suf=
fer
>> > from these issues=2E I barely modify those places to support null roo=
t and
>> > CWD, and because of that consolidation, we shouldn't expect new place=
s
>> > to crop up in the future=2E (Duplicative path resolution logic is a b=
ad
>> > idea whether or not we have a nascent, little-used NULL-cwd/root code
>> > path=2E) Therefore, I think existing code review, even among people
>> > totally ignorant of this feature, will protect us --- the vast majori=
ty
>> > of code will just be working with `struct path`, and be totally
>> > unaffected by this change=2E
>>=20
>> I actually did laugh out loud reading this=2E I'm sorry, I can't really
>> take this argument seriously=2E May I introduce you to drivers/ for a
>> start and the history of path lookup exploits of the last - say 10
>> years=2E
>>=20
>> You have to excuse me but it's a mixture of amusement and slight anger=
=2E
>> Amusement because this is really naive and thus also a bit endearing=2E
>> Anger because it single-handedly dismisses how big of an attack surface
>> and problem space path lookup is=2E The equivalent of every math
>> professor's "trivial=2E excercise left to the reader"=2E
>
>I could easily show you why path lookup is trivial, but I have no space
>left in the margins of this email=2E

=F0=9F=A4=A3=F0=9F=A4=A3=F0=9F=A4=A3

