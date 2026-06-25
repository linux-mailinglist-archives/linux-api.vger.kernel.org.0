Return-Path: <linux-api+bounces-6708-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t+jrJWKjPWro4wgAu9opvQ
	(envelope-from <linux-api+bounces-6708-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 23:53:38 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D34BD6C8CC1
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 23:53:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=johnericson.me header.s=fm3 header.b=dZOvz1X+;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="V mtWSt7";
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6708-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6708-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=johnericson.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33109303CB4B
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 21:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BE736C9D9;
	Thu, 25 Jun 2026 21:53:35 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69F730D3ED;
	Thu, 25 Jun 2026 21:53:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782424415; cv=none; b=K26R1alvVU7B6u7ayXhkRjPbF3I3NYx3VLBGbhITpt04GXWOZ0Xi/N0BWhQWWLHPwop2/o7tHDJBLfyn1dWVmXjEW0zO9biaeIM3w8ihywZKezseCC6Ln5wvbVRMYHwRDQ0qD1f2t8eKJy38tMb2J4s+cM48Zqd4ecCTnYzEfoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782424415; c=relaxed/simple;
	bh=z0ogCZX+fL4NK9ldiKbPeg39+XtPZhElqplGgXQgczE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hk87whCcx0OY4gQjKYcpy7dMdOOqGm8DF4eFOeReim63ecYZDF1iSlqW0XpWlWaG6J11YDi00eH24OvfyQzlSFiLcSQ/H84Od6My2qU6xOLJRumb52KWoNKvb0k46wRpXJCtwW4AILyFojQj9NGqydXwOcoc1K2KgGOSept3+KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me; spf=pass smtp.mailfrom=johnericson.me; dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b=dZOvz1X+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VmtWSt7D; arc=none smtp.client-ip=103.168.172.138
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id B94131380CDB;
	Thu, 25 Jun 2026 17:53:32 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-05.internal (MEProxy); Thu, 25 Jun 2026 17:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnericson.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1782424412; x=1782431612; bh=IYsq78NejCoXtDw/qwAAchwUzVkN1+bU
	UjWnxG1UkCY=; b=dZOvz1X+c5o372apcohjNrL7VyxarusAjUyBlp63GOLa4MDZ
	ffwFej1PrcaYN41fzbAHgVwji5APx0zPLBI4XY05NVcoq1217kZ/P0gRF97a8VoA
	gP9522Oje3Pbpu2px6SARXoAOKXEoQG7OJC+lp5qf7J36gE25koXpeEXy1RcR9xg
	ujjokQl8c/yx2Jx1tL+586vXAuNQim6X4gRpm0PKPaO+U8GocUyzUkV4qq8cscfI
	K9Ymn7JbJ1HaquRRNE6O3uMAmP/fzRySBGJiQ3274sOryuGQByo1miv3iI4XvSiN
	wxlMWaGVfS1Pm6uvoq4vLTm0zH/BB0KpFOzKGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782424412; x=
	1782431612; bh=IYsq78NejCoXtDw/qwAAchwUzVkN1+bUUjWnxG1UkCY=; b=V
	mtWSt7D6qTt9ALyCMp7ryHMnsxkWCBiWBOM4UyEu39ZcHzV/fS69NCwAvOooesoW
	+/nuuuwJaPBlMXS6sPYsZ8GLkm+Bm9bbCpm+zDEC8SBONwMrd4WLPOv1DhslSQx0
	NbqaKLe4vwI369U01+NjYyGWZUyoPKyZNfqBmVIvn1+Qkc4+vtRyEJC+NRzw0Pca
	UZlOZxqfffyTDpSjCqVTDO06UgbdHNLrcGBnDpibVWa5W9vD1oVR2IIirdrILgra
	rd5YHvmrNvVAWpOHUVEDP0/zGV9Y1cqsotxm0yriNx4HAiFQZsMzDqb41lYl0K9q
	EoA+CAyx/SJp4lllR3e8Q==
X-ME-Sender: <xms:W6M9asMXnx5cbFHIohVJl1GpcPyDy2TyqiI8wRVrNgVkYRrkBrj_hQ>
    <xme:W6M9atwjadaH5OVOBRl969claQE8RJEjjcl5muqPKT-EwbS763caYkDIbGanhOf0g
    wvcLgT0BtPaPzshji-aRcbaP0zcsU_nxlQpIjeLUF96iDpHFAJSk8M>
X-ME-Proxy-Cause: dmFkZTGrWUulMGa9t7hh5vsJ6ujfE19InZyJmAgynX1N+d7rh6JbPMu5Qd8zLIj7s10I4B
    EHHq+2X6kFsg+mnVolMH6+caO5+JO9vpixP0Q37sl8vWZl55EaOjRahxqsTdx8pLTGoZQO
    VAXCynZvt5rIk67xeGuDSfgZppgVkUVlCwihSq12Q4MQr6RiRSaU2v6mgFUz8oBov3dm9R
    kThJUvMc7+MZZ99johKylTEsDp0cEmpoDO0F2wlgj4z9iFxwvrYlOZNWMV5Nj/dx3/72Oq
    PolGxOrdytxUCxtni25t5bMMKsoUeq7Y+JgVk+CVTBwQO+ssiX+eZeviQ5C+GBEtwPyGMJ
    ybM2KXzo+SjafWk5bU27fczaHbLKmEqHv3eBde240KRo7hujnXv9EPcVi4G/mIbOmly1t4
    /eeuew4Hq5sZ8DWu81FKzBDsbfrvUYYIXh7HpWwT1VNmwECrnoxX/tLaQFvgK3xmoqJ5CN
    sDQuLKOV/HhkCD/N2kenCLL8sPsDX2Iv2ou8aVFfKNXY7JCpWupl4mD97+zGQEbTWfM7Pz
    rxbAXIJVtX+UAKrLiApI/Qnrsrpaz6lv/YS6LYn7w2aYg78iO6+ekT17qMZyqn+aJ5Suq2
    BivUK3xhSNiqth7vFsCuIC6B0ZG9X3sZluJfg2CZUlC2XxL7JCk2+NpG9QBQ
X-ME-Proxy: <xmx:W6M9anc-CdKzk51jMlNU2krOxhc23NuSijJunvXuhiGv2cPMWZnxGw>
    <xmx:W6M9aqbZ-pmn5KpDUCbCvRfa_vXZfQeuCHOhEgChiQfpbdIAuwkW0Q>
    <xmx:W6M9alBIGYAL2njYDZtCiU65NgFreMgCIHdn_aSX-PBJZDOIkRZmNA>
    <xmx:W6M9alKxRGE-pxZFtzy-snUfN7XE21iggwrwOhgh5XV3xmhpw6YXEQ>
    <xmx:XKM9apfGsK2JXc_AqU-3rTPQQ_w6ep2LWktZgesw9sHxTMYbMCiWHylD>
Feedback-ID: ieb4144f1:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7496B2CC0091; Thu, 25 Jun 2026 17:53:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AG8qDlxFSDr7
Date: Thu, 25 Jun 2026 17:50:21 -0400
From: "John Ericson" <mail@johnericson.me>
To: "H. Peter Anvin" <hpa@zytor.com>, "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Li Chen" <me@linux.beauty>, "Cong Wang" <cwang@multikernel.io>,
 "Christian Brauner" <brauner@kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-api <linux-api@vger.kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
 "Andy Lutomirski" <luto@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, "Jan Kara" <jack@suse.cz>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Kees Cook" <kees@kernel.org>, "Sergei Zimmerman" <sergei@zimmerman.foo>,
 "Farid Zakaria" <farid.m.zakaria@gmail.com>
Message-Id: <614b290f-e274-4eb2-b687-008b004de526@app.fastmail.com>
In-Reply-To: <29cd3188-2d7c-4470-a39a-6648638f795e@zytor.com>
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
 <20260624231219.GL2636677@ZenIV>
 <29cd3188-2d7c-4470-a39a-6648638f795e@zytor.com>
Subject: Re: [RFC] Null Namespaces
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[johnericson.me,none];
	R_DKIM_ALLOW(-0.20)[johnericson.me:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-6708-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hpa@zytor.com,m:viro@zeniv.linux.org.uk,m:me@linux.beauty,m:cwang@multikernel.io,m:brauner@kernel.org,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:arnd@arndb.de,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mail@johnericson.me,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[johnericson.me:+,messagingengine.com:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@johnericson.me,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.beauty,multikernel.io,kernel.org,vger.kernel.org,arndb.de,redhat.com,alien8.de,linux.intel.com,suse.cz,lwn.net,linuxfoundation.org,zimmerman.foo,gmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,messagingengine.com:dkim,johnericson.me:dkim,johnericson.me:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D34BD6C8CC1

On Thu, Jun 25, 2026, at 5:00 PM, H. Peter Anvin wrote:
> On 2026-06-24 16:12, Al Viro wrote:
> > On Wed, Jun 24, 2026 at 06:51:47PM -0400, John Ericson wrote:
> >
> >> #### Null mount namespace
> >>
> >> - requires:
> >>
> >>   - null root file system: absolute paths don't work.
> >>
> >>   - null current working directory: relative paths with traditional,
> >>     non-`*at` system calls (and `*at` ones using `AT_FDCWD`) don't work.
> >>
> >> - All operations relating to the "ambient" mount tree don't work.
> >>
> >> - `*at` operations with a file descriptor do work.
> >
> > Huh?  The last bit looks contradicts the previous one - if you have
> > an opened directory in a mount from some namespace, those `*at` operations
> > with that descriptor *will* be seeing the mount tree of that namespace,
> > whatever the hell is "ambient" supposed to mean.  Either that, or you
> > will be exposing whatever's overmounted in that mount, which is a huge
> > can of worms.
>
> It seems to me that this is really no different *in practice* to having an
> empty mount namespace, no? You might still be able to stat("/") and get a
> d--------- result, but how does that actually affect anything?

The argument against just having an empty, immutable root directory and
calling it a day is the tie-in with a new process-spawning API discussed
near the bottom of my original email. I want to have nice secure
defaults, rather than forcing the programmer to remember to unshare, but
I also don't want to degrade performance by speculatively creating new
empty mount namespaces that might just be thrown away. Null fields alone
get us both --- security and good performance.

> The big thing with a lot of this is that introducing a null case can really
> complicate things all over the place, and since this is very likely to be only
> a niche use case, it kind of screams to me like it has the potential to become
> an attack surface like any other rarely used code in the kernel...

I understand and am sympathetic to this line of reasoning, but I think
it is important to look at the patch in question (which I suppose I
should soon submit) to weigh the competing concerns.

The kernel rightfully has consolidated path resolution in a few key
places as much as possible -- the internal `struct path` does not suffer
from these issues. I barely modify those places to support null root and
CWD, and because of that consolidation, we shouldn't expect new places
to crop up in the future. (Duplicative path resolution logic is a bad
idea whether or not we have a nascent, little-used NULL-cwd/root code
path.) Therefore, I think existing code review, even among people
totally ignorant of this feature, will protect us --- the vast majority
of code will just be working with `struct path`, and be totally
unaffected by this change.

Moreover, every new feature starts rarely used. This is to me a
judicious anti-feature (removing state, making more things fail) that
should be quite intuitive to those developing for Linux, given the
prominence of things like WASI, and I will do what I can in the Nix
ecosystem to try to get it widely used in short order. Just guessing
from its design, this ought to be something other ecosystems, like
Android, are also interested in.

John

