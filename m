Return-Path: <linux-api+bounces-194-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557047FFB04
	for <lists+linux-api@lfdr.de>; Thu, 30 Nov 2023 20:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8687B1C20D00
	for <lists+linux-api@lfdr.de>; Thu, 30 Nov 2023 19:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC4D5FF18;
	Thu, 30 Nov 2023 19:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="XkIPJIeq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TPFatEdJ"
X-Original-To: linux-api@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E711704;
	Thu, 30 Nov 2023 11:17:25 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id B50C65C00DB;
	Thu, 30 Nov 2023 14:17:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 30 Nov 2023 14:17:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1701371842; x=1701458242; bh=iQ
	ZWO0/diNEJkkg7lAgOL9yfv4aOzoXSzlS73uZBPds=; b=XkIPJIeqbBdVpFJqgr
	O5fippdUxsE4FcOTUGIBEiNqIdyZMnHSp4Bla1GEtxVuoLANGMjOiIu4jNuRDANH
	uVv8siM8MYxbiSnOfGAIj5o2LUcs/h2ZLsaI8ueHJQT/TDj/HwPSi8JmfygyQgjq
	tBUdW0pg5qh6c3cYPA15LMll+2pSLFTE6l2zfu6ppwnD4nLDG8KWbaiLNVa/rL/6
	tVx33Ld9rGKLAN8hJgHuGM0zEj1bLRg4saDlt3XtAC29DBPTzn/IwzeFV/vKS2bn
	pJXFbtWgaY4Nt7RFMO22LJ5y3hqKIYn9Iejw5MbGpLufDaAqNleDhXbW8CGHA1bs
	2Sdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701371842; x=1701458242; bh=iQZWO0/diNEJk
	kg7lAgOL9yfv4aOzoXSzlS73uZBPds=; b=TPFatEdJK8CIsFYFX91uL8rjEHKnH
	mUoOA4CvktpHgmndqfGm4/tsDRGIlZ9bZb0On6SJNIiuTvDLi1vbAs+2YrLnzmd7
	EdyOgxPJIMoVmsfUr4/P/5o2hGB9cTLmcl46HgEKjUIvkjccX8oRLzvMBOOGblMx
	MHz5GeZR0hUsMIz0N3ndsXGgZLIFcXsDZ0d3C8iymCqSyAk3ar8q6WOd3N2nQh2x
	ysMFjRbg+sa9oUbYJmS8siRzg4wDGTj3FtPF/TS+DMuBRUryFQSOhb6wDBYN8zNN
	tT/ufTjrZMeaoaJ8QQ/b5j5r/zR7e6kKCuSYH5sO+osj6UGIFp6bNEV1g==
X-ME-Sender: <xms:wt9oZdvhF0UJT88aSoJsEBC72vkauLWCkj17QGJ7b1de7hOvqaMC7A>
    <xme:wt9oZWcI8Ec6WkayszUm_FzTs-33ffod5l714D5VQZxgJDUTqnFkOpYE3-mOSO0Cx
    x9dx7cZy-4DoSx_yeI>
X-ME-Received: <xmr:wt9oZQx2FFEgc4G7GXIIRsRJ9tWC-mInBITqpo_kVgDKVuGm_lHb4uFRGi8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeijedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigt
    hhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtf
    frrghtthgvrhhnpeeutedttefgjeefffehffffkeejueevieefudelgeejuddtfeffteek
    lefhleelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:wt9oZUN3uGdisEfaexEp9Lks3p_BWRNG6AVeCtwXXHa_pl1XlFOvvA>
    <xmx:wt9oZd-9uCxsNDp9zbJ47T56lqfpOltDbeK8WPHK5xJKubKFk4h8BQ>
    <xmx:wt9oZUXOufGumPZQjAmO3brK0bHg4_6W7Fp3ayfJ8XAPk_f3IpRurQ>
    <xmx:wt9oZWN6GIUYaqk3hjWhT7s1y8ykSt9gGQcFMcoyYkUCZwO2JcQDNg>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Nov 2023 14:17:20 -0500 (EST)
Date: Thu, 30 Nov 2023 12:17:19 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Florian Weimer <fweimer@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>,
	Kees Cook <keescook@chromium.org>
Subject: Re: [RFC 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
Message-ID: <ZWjfv7ZB4M1E+GVE@tycho.pizza>
References: <20231130163946.277502-1-tycho@tycho.pizza>
 <874jh3t7e9.fsf@oldenburg.str.redhat.com>
 <ZWjaSAhG9KI2i9NK@tycho.pizza>
 <a07b7ae6-8e86-4a87-9347-e6e1a0f2ee65@efficios.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a07b7ae6-8e86-4a87-9347-e6e1a0f2ee65@efficios.com>

On Thu, Nov 30, 2023 at 02:00:01PM -0500, Mathieu Desnoyers wrote:
> On 2023-11-30 13:54, Tycho Andersen wrote:
> > On Thu, Nov 30, 2023 at 07:37:02PM +0100, Florian Weimer wrote:
> > > * Tycho Andersen:
> > > 
> > > > From: Tycho Andersen <tandersen@netflix.com>
> > > > 
> > > > We are using the pidfd family of syscalls with the seccomp userspace
> > > > notifier. When some thread triggers a seccomp notification, we want to do
> > > > some things to its context (munge fd tables via pidfd_getfd(), maybe write
> > > > to its memory, etc.). However, threads created with ~CLONE_FILES or
> > > > ~CLONE_VM mean that we can't use the pidfd family of syscalls for this
> > > > purpose, since their fd table or mm are distinct from the thread group
> > > > leader's. In this patch, we relax this restriction for pidfd_open().
> > > 
> > > Does this mean that pidfd_getfd cannot currently be used to get
> > > descriptors for a TID if that TID doesn't happen to share its descriptor
> > > set with the thread group leader?
> > 
> > Correct, that's what I'm trying to solve.
> > 
> > > I'd like to offer a userspace API which allows safe stashing of
> > > unreachable file descriptors on a service thread.
> > 
> > By "safe" here do you mean not accessible via pidfd_getfd()?
> 
> For the LTTng-UST use-case, we need to be able to create and
> use a file descriptor from an agent thread injected within the target
> process in a way that is safe against patterns where the application
> blindly close all file descriptors (for-loop doing close(2),
> closefrom(2) or closeall(2)).
> 
> The main issue here is that even though we could handle errors
> (-1, errno=EBADF) in the sendmsg/recvmsg calls, re-use of a file
> descriptor by the application can lead to data corruption, which
> is certainly an unwanted consequence.
> 
> AFAIU glibc has similar requirements with respect to io_uring
> file descriptors.

I see, thanks. And this introduces another problem: what if one of
these things is a memfd, then that memory needs to be invisible to the
process as well presumably?

This "invisible to the process" mapping would solve another
longstanding problem with seccomp: handlers could copy syscall
arguments to this safe memory area and then _CONTINUE things safely...

Tycho

