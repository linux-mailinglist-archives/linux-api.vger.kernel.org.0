Return-Path: <linux-api+bounces-257-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 753B38073AC
	for <lists+linux-api@lfdr.de>; Wed,  6 Dec 2023 16:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD611F21894
	for <lists+linux-api@lfdr.de>; Wed,  6 Dec 2023 15:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E363FE5F;
	Wed,  6 Dec 2023 15:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="eIx0mXmL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IwmUrbSA"
X-Original-To: linux-api@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340B9FA;
	Wed,  6 Dec 2023 07:27:20 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 8D6935C02A9;
	Wed,  6 Dec 2023 10:27:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 06 Dec 2023 10:27:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1701876439; x=1701962839; bh=FT
	6UEoWVsDlfq8nOucO+L8572l+DeQGXhub/tbWtdrE=; b=eIx0mXmLhdGLez1Q+u
	Ee0o8vn+1rJ13CAy0ryFOtVnfnOY+WReKAgmoSV4pq8Vs+TP72SYcIjuSMtCtzmF
	pcievzijmVoLfI5+sB+MIS70mdvBmkCKNnevaxVwbbb+MN26eH3A+uEhzKjczoSz
	u/w7NDif0QudJR6wwfRTVoiP4d+2of1LB8BF2NPwvPsUJQ4avEJ2oRbuaXGfLvqC
	baZt32UXCPuIV1Havxch7H5KmOP951fwRSdaA3lvrM6Er6BQ+SyiMvZ/t++Idn/h
	BzUIwjgzuEB4bYUqfTeYDhkBXdkIxnu5csUDEWBrWdloWM4PdhCVYfpFTuklaPZh
	Deyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701876439; x=1701962839; bh=FT6UEoWVsDlfq
	8nOucO+L8572l+DeQGXhub/tbWtdrE=; b=IwmUrbSAlb0Twy6EorGSDlLkjaeuS
	gncuJoTYDmFaLztU8O1f+k3nVftAOr6uwAvtyQ2p25abP9n9ABGhJ8HeWmKEzu3w
	VQ5jFbnTPgX4KnHsLip9ZBlpBn8X0NcOay6IDDfDYUc01iljg0GzwZ+cSVK0gVvf
	PIZSUKS7rgrirb4BeGeNXq89LXAzbi+JbpJB2agitfOedDLq+NQYgHhAaKeQ4wPs
	ZZcQIdB2L6OMg5Zc1zal6ba21fu60MRp0c6V9f8jnsbfDdNrYARTx9bRqvR2JCUy
	acVwAoJWgdzb708JXKEDmayeajdLhfiWQi5uvI+Tawqxd5bR2JIGV7UIA==
X-ME-Sender: <xms:15JwZZ1cm5uK11ww6N-OFCKcAnz0RCROi6eKV7kdGS6b5NLTRHWKIg>
    <xme:15JwZQGZDaXb1NplmNVvbtoawJFeTsk3moR1fftaslpix2x3UcGuokJBU7qtD-Wu3
    pPwoWXYGdg8d3lF4ss>
X-ME-Received: <xmr:15JwZZ5jjWAA2PGEJgIzgAg3FPkysEWkpdsYc_XEwf0SU_bYzxwxX1g9OdtNromuiu52hQ1wyfCOILwaRbX61ygIn3RS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudektddgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:15JwZW3KPkIw_b256pFVavGfelUCZSAZmcD4F7XfQo-BxljvgPEUOg>
    <xmx:15JwZcHiWf1EVl_MGU2gnyOw1nhOIW3CJ0f-aJBG532qiIXjaY2kzQ>
    <xmx:15JwZX-O0YmgE6YUwpkjTmjO-mLtu_mScNcWu4IHKerjrEDztmuruw>
    <xmx:15JwZR4jvTsL_SOv-sronCWcxDVhFM1w3cdMJC7A9WOo1JXwmn5bFA>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Dec 2023 10:27:18 -0500 (EST)
Date: Wed, 6 Dec 2023 08:27:17 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Florian Weimer <fweimer@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [RFC 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
Message-ID: <ZXCS1SMQLhSPtjdp@tycho.pizza>
References: <20231130163946.277502-1-tycho@tycho.pizza>
 <874jh3t7e9.fsf@oldenburg.str.redhat.com>
 <ZWjaSAhG9KI2i9NK@tycho.pizza>
 <a07b7ae6-8e86-4a87-9347-e6e1a0f2ee65@efficios.com>
 <87ttp3rprd.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttp3rprd.fsf@oldenburg.str.redhat.com>

On Thu, Nov 30, 2023 at 08:43:18PM +0100, Florian Weimer wrote:
> * Mathieu Desnoyers:
> 
> >>> I'd like to offer a userspace API which allows safe stashing of
> >>> unreachable file descriptors on a service thread.
> 
> >> By "safe" here do you mean not accessible via pidfd_getfd()?
> 
> No, unreachable by close/close_range/dup2/dup3.  I expect we can do an
> intra-process transfer using /proc, but I'm hoping for something nicer.

It occurred to me that we could get the seccomp() protected-memory
functionality almost all the way via some combination of
memfd_create(MFD_ALLOW_SEALING), fcntl(F_SEAL_WRITE|F_SEAL_SEAL), and
mmap(PROT_NONE). Some other thread could come along and unmap/remap,
but perhaps with some kind of F_SEAL_NOUNMAP married to one of these
special files we could both get what we want?

I submitted a talk to FOSDEM just for grins, if anyone is planning to
attend that.

Tycho

