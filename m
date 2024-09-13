Return-Path: <linux-api+bounces-2316-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D6F977DED
	for <lists+linux-api@lfdr.de>; Fri, 13 Sep 2024 12:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C78252858EA
	for <lists+linux-api@lfdr.de>; Fri, 13 Sep 2024 10:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7E21D86C2;
	Fri, 13 Sep 2024 10:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="nwEksSen"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE77E1D6C61
	for <linux-api@vger.kernel.org>; Fri, 13 Sep 2024 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726224415; cv=none; b=QP9OOE7d3g4FFAm8XOTC8NcjjsUymdsIYB+hn+3f2bE19nn97EISc4STQIB6iUPVY2nnTdjuPtnz5UCSD+hfAniTd1XXw7Tjirb9YvqJpnkibjvawzQ1cqREgxRSlpoC03o4yJZmM6Rd/xQbN+0thygbIqxPV+mYG60F9XxKI+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726224415; c=relaxed/simple;
	bh=CQZu3v5gvm75PQs5vyLOAEm7VvML+OftnXxyPMpnbe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOkYKCW3QcDaeAZ8tu3PX0phVZhcmS1VdY3D0LAypz/bimPearTiGkyphcyf242KnQ6CU6axeWLokNiOXCPheBhGg+EUU6M3OZh8yhSU+vwxGWFyxTdTFOoPvsjLmYzbRHEq+NGnOlWtg0a+fC5kin6B8hziSug3q6QnLX2k3vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=nwEksSen; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4X4rb70BmvzDmL;
	Fri, 13 Sep 2024 12:46:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1726224402;
	bh=G9D1DK7YBO4iWpZr7m77+lcDnYO5RE/cbvabg3+xvwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nwEksSen0+/SgVAo+wzgbzMqGaKB4flMPYuYmosXhqkd4yQ/nPePQCEDCCWdVwcxD
	 3nlSY2ez9YAL0Qq5yQwCLiyHSAsu4iUNA3HDyAsch2DtWHhCJcBi7euBHv2IoMbzbh
	 Ctdnn53zQW9e2OmIPVPi19JkZ8MzNq4XQHf741zQ=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4X4rb54836zgMC;
	Fri, 13 Sep 2024 12:46:41 +0200 (CEST)
Date: Fri, 13 Sep 2024 12:46:34 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>, linux-api@vger.kernel.org
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org, Alejandro Colomar <alx@kernel.org>
Subject: Re: [PATCH v11 1/8] Landlock: Add abstract UNIX socket restriction
Message-ID: <20240913.nuu9Eevo2Pha@digikod.net>
References: <cover.1725494372.git.fahimitahera@gmail.com>
 <5f7ad85243b78427242275b93481cfc7c127764b.1725494372.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f7ad85243b78427242275b93481cfc7c127764b.1725494372.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Sep 04, 2024 at 06:13:55PM -0600, Tahera Fahimi wrote:
> This patch introduces a new "scoped" attribute to the
> landlock_ruleset_attr that can specify
> "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" to scope abstract UNIX sockets
> from connecting to a process outside of the same Landlock domain. It
> implements two hooks, unix_stream_connect and unix_may_send to enforce
> this restriction.
> 
> Closes: https://github.com/landlock-lsm/linux/issues/7
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>

> diff --git a/security/landlock/task.c b/security/landlock/task.c
> index 849f5123610b..b9390445d242 100644
> --- a/security/landlock/task.c
> +++ b/security/landlock/task.c

> +static int hook_unix_stream_connect(struct sock *const sock,
> +				    struct sock *const other,
> +				    struct sock *const newsk)
> +{
> +	const struct landlock_ruleset *const dom =
> +		landlock_get_current_domain();
> +
> +	/* quick return for non-sandboxed processes */
> +	if (!dom)
> +		return 0;
> +
> +	if (is_abstract_socket(other) && sock_is_scoped(other, dom))
> +		return -EPERM;

I was wondering if it would make more sense to return -EACCES here.
EACCES is usually related to file permission, but send(2)/sendto(2)
don't return EPERM according to man pages.  Well, according to the
kernel code they can return EPERM so I think we are good with EPERM.

It looks like other LSMs always use EACCES though...

> +
> +	return 0;
> +}
> +
> +static int hook_unix_may_send(struct socket *const sock,
> +			      struct socket *const other)
> +{
> +	const struct landlock_ruleset *const dom =
> +		landlock_get_current_domain();
> +
> +	if (!dom)
> +		return 0;
> +
> +	if (is_abstract_socket(other->sk)) {
> +		/*
> +		 * Checks if this datagram socket was already allowed to
> +		 * be connected to other.
> +		 */
> +		if (unix_peer(sock->sk) == other->sk)
> +			return 0;
> +
> +		if (sock_is_scoped(other->sk, dom))
> +			return -EPERM;

ditto

