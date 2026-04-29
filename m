Return-Path: <linux-api+bounces-6240-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDdRAopr82lf2gEAu9opvQ
	(envelope-from <linux-api+bounces-6240-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2026 16:47:38 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 973214A4380
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2026 16:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6CE6302864C
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2026 14:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C447D4279F7;
	Thu, 30 Apr 2026 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vM1iY9/t"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E55A40B6F6;
	Thu, 30 Apr 2026 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777560438; cv=none; b=pzR/DbyM7TnSEQYoX9au5NbCOuJ+lRuqi1T7iknPyDeiQm25j2WyacDWk5Db4JDVPyYYknOZ8ub38Vs4ljwFcoiD9lvAuczphQPoKBJBrjMtL+Fxp5Tx6OD/mnj6M6VUHw5LPYib2ZheuPw/h4hA8ryNxPRKsUaFNZWYlqAKa9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777560438; c=relaxed/simple;
	bh=PgjNJKLT2zJkSi9VpdJOFcoOhqQHfDSBNF35mCNRBI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzYMVwUUIacKnMjp8AmQ+5i25cCCFFxEr5z1MBw7P9TErzRSaA3w913p/yfFsOl6i7j1tmCCD26KuV3IcT3h0xk+ZDVKbQkCKMr3RS5Ns9gAxhlEgP7g905m0ltuZtMgPDBoGcjGPqH73c+DR9SyFI4M4BXW2eF2c93t4PQuDIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vM1iY9/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2039C2BCB3;
	Thu, 30 Apr 2026 14:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777560438;
	bh=PgjNJKLT2zJkSi9VpdJOFcoOhqQHfDSBNF35mCNRBI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vM1iY9/t2BKQ45wuFAsqyAf/5CCva2wC6dU+JCnJ0IdlWvR2j3/AnA/0d31WDzruV
	 imgLERpZhP/AubkiUNQk0DTfTomV0cDRKxCDPqgYn+dSrq0kQ8wO0Bn3ySopJtC1AY
	 WIO8hhikkM7Cxdq0+UU4hER8OBwXdbXfyBJ3TYM7GV4RbJmmIZr8CFPU2h09+nntnP
	 jBjY6wUdgRnnGC3sq6F8CqLNFsES1uliYwFO3ABzDjXGjybbY/3tfsXno3eq2ytHmX
	 NNAotC3v8dUJwcpbKulD7LPfUyJAN7L0kY6Dsz4VQ1RRz/ooRyhv/n1kAQ2COSiCgP
	 MINuZ0sKWe+ag==
Date: Wed, 29 Apr 2026 18:32:16 +0200
From: Nicolas Schier <nsc@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kselftest@vger.kernel.org, workflows@vger.kernel.org,
	tools@kernel.org, x86@kernel.org, Thomas Gleixner <tglx@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Dmitry Vyukov <dvyukov@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Cyril Hrubis <chrubis@suse.cz>, Kees Cook <kees@kernel.org>,
	Jake Edge <jake@lwn.net>,
	David Laight <david.laight.linux@gmail.com>,
	Askar Safin <safinaskar@zohomail.com>,
	Gabriele Paoloni <gpaoloni@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/9] kernel/api: introduce kernel API specification
 framework
Message-ID: <afIykLLPj7m0fcsX@levanger>
Mail-Followup-To: Nicolas Schier <nsc@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Sasha Levin <sashal@kernel.org>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kselftest@vger.kernel.org, workflows@vger.kernel.org,
	tools@kernel.org, x86@kernel.org, Thomas Gleixner <tglx@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Dmitry Vyukov <dvyukov@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Cyril Hrubis <chrubis@suse.cz>, Kees Cook <kees@kernel.org>,
	Jake Edge <jake@lwn.net>,
	David Laight <david.laight.linux@gmail.com>,
	Askar Safin <safinaskar@zohomail.com>,
	Gabriele Paoloni <gpaoloni@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
References: <20260424165130.2306833-1-sashal@kernel.org>
 <20260424165130.2306833-2-sashal@kernel.org>
 <177726106581.2478607.12645653803520391071.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177726106581.2478607.12645653803520391071.b4-review@b4>
X-Rspamd-Queue-Id: 973214A4380
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6240-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linuxfoundation.org,lwn.net,google.com,infradead.org,suse.cz,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nsc@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Sun, Apr 26, 2026 at 11:37:45PM -0400, Nathan Chancellor wrote:
> On Fri, 24 Apr 2026 12:51:21 -0400, Sasha Levin <sashal@kernel.org> wrote:
> > diff --git a/kernel/Makefile b/kernel/Makefile
> > index 6785982013dc..564315153643 100644
> > --- a/kernel/Makefile
> > +++ b/kernel/Makefile
> > @@ -59,6 +59,9 @@ obj-y += dma/
> >  obj-y += entry/
> >  obj-y += unwind/
> >  obj-$(CONFIG_MODULES) += module/
> > +obj-$(CONFIG_KAPI_SPEC) += api/
> > +# Ensure api/ is always cleaned even when CONFIG_KAPI_SPEC is not set
> > +obj- += api/
> 
> If $(CONFIG_KAPI_SPEC) is not set, shouldn't
> 
>   obj-$(CONFIG_KAPI_SPEC) += api/
> 
> evaluate to
> 
>   obj- += api/
> 
> anyways? Why the duplication? This is the only place in the kernel where
> this would be needed?

yes, this is definitely not needed, as obj- is always evaluated during
'make clean', cp. scripts/Makefile.clean [1].

Kind regards
Nicolas

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/Makefile.clean?h=v7.1-rc1#n30

