Return-Path: <linux-api+bounces-5775-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oACZG1tHe2kdDQIAu9opvQ
	(envelope-from <linux-api+bounces-5775-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 29 Jan 2026 12:41:15 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8733BAFB9B
	for <lists+linux-api@lfdr.de>; Thu, 29 Jan 2026 12:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A89BD30028E5
	for <lists+linux-api@lfdr.de>; Thu, 29 Jan 2026 11:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77277387583;
	Thu, 29 Jan 2026 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhFtYdDg"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E2926CE39;
	Thu, 29 Jan 2026 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769686870; cv=none; b=pnWSb9eeqdIqan9OJmfhe41E+y5UaSDYmgEHvomZpyAEGPTJXwDWeJcQIZbfd3ToRn8Z4YDzBmSJn4NEkbj/EPsNJY2dzHfKb3lS59znzaEJ0lsJILm2KfG0Y+0sqrcDxEoTM3P9nDLZVtgbX2kip1sY6DVfP91aPgJ+Sl4XfLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769686870; c=relaxed/simple;
	bh=GxMf/5mp8QjYk8b0oivIjo05Zaj5YW+DCUftJ/YqvNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxAdogfWVpw736g4zpl6czHA8O4KzMvJa05t1G1vyz7uPYmj6ytiStHYm9BdNddMVfUF8yS0BiGxZlzyRad+SOMiJeeVgiW8uRmfso2C6iAAfiQczARF2h4HP9QoRE4uxedWRlCqiDqWtEz+c4DaGjX5y+E3zXCsQnfFmFtBKAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhFtYdDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057BEC4CEF7;
	Thu, 29 Jan 2026 11:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769686869;
	bh=GxMf/5mp8QjYk8b0oivIjo05Zaj5YW+DCUftJ/YqvNM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hhFtYdDgi04FrQb5oG6WU8WJT4pW/Ad6DqcjX3kcqWfoeCoUWWlUTa6fEjrKjjgNK
	 Ny5NJ8XnpEARZaj7GCmoGiijjtYfNLHEn/MQYPvkfALCH4OyNO9VBy/AN75ciNVtXy
	 1/DWf/378vO5qA9itsnqFsNxJtXhgDa825aZFwQzucY2BWQzaXTLQLCE6ZxGZJG1To
	 1zL9oj4Ffpqkzu6ephruC4criEO4DC6NlaiO4kgdN0UTJHk7DSN7nkMoZwc0B+Pjy0
	 /Ji2JuMWSbeb57Wzf4AJBJ0xaRdacitwyC33idjkx5m7qtlSejYsIfBvvk/sid2ymE
	 NV+TlEt7VlsSQ==
Message-ID: <24935907-76b8-4369-a221-f408c9747642@kernel.org>
Date: Thu, 29 Jan 2026 12:41:03 +0100
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: synclink_gt: remove broken driver
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 linux-serial@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org
Cc: linux-api@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Haren Myneni <haren@linux.ibm.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
 Simon Horman <horms@kernel.org>, Eric Biggers <ebiggers@google.com>
References: <20260129075200.38060-1-enelsonmoore@gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20260129075200.38060-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5775-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lwn.net,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linuxfoundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jirislaby@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api,netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anu.edu.au:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8733BAFB9B
X-Rspamd-Action: no action

On 29. 01. 26, 8:51, Ethan Nelson-Moore wrote:
> The synclink_gt driver was marked as broken in commit 426263d5fb40
> ("tty: synclink_gt: mark as BROKEN") in July 2023 because it had severe
> structural problems and there had been no evidence of users since 2016.
> Since then, no meaningful improvements have been made to the driver,
> and it is unlikely that will ever happen due to the lack of interest.
> Drop the driver and references to it in comments and documentation.

Overall, I am all for it, but a few remarks:

> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>   .../userspace-api/ioctl/ioctl-number.rst      |    2 +-
>   arch/powerpc/configs/ppc6xx_defconfig         |    1 -
>   drivers/net/ppp/Kconfig                       |    4 +-
>   drivers/tty/Kconfig                           |   11 +-
>   drivers/tty/Makefile                          |    1 -
>   drivers/tty/n_hdlc.c                          |    7 -
>   drivers/tty/synclink_gt.c                     | 5038 -----------------
>   include/linux/synclink.h                      |   37 -

     vvvvvvvvvvvvvvvvvvvvvvvvvvvvv

>   include/uapi/linux/synclink.h                 |  301 -

Have you checked this is not included in any relevant userspace? How? 
Hints: debian code search, github...

> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 7232b3544cec..8abedab9fea7 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -271,7 +271,7 @@ Code  Seq#    Include File                                             Comments
>   'm'   00-09  linux/mmtimer.h                                           conflict!
>   'm'   all    linux/mtio.h                                              conflict!
>   'm'   all    linux/soundcard.h                                         conflict!
> -'m'   all    linux/synclink.h                                          conflict!
> +'m'   all    linux/synclink.h                                          Dead since 2026

I would just drop the line, removing one conflicting entry. The letter 
is not going to be dead.

Or is this Dead note some ioctl-number's policy?

> --- a/drivers/tty/n_hdlc.c
> +++ b/drivers/tty/n_hdlc.c
> @@ -4,8 +4,6 @@
>    * Written by Paul Fulghum paulkf@microgate.com
>    * for Microgate Corporation
>    *
> - * Microgate and SyncLink are registered trademarks of Microgate Corporation
> - *
>    * Adapted from ppp.c, written by Michael Callahan <callahan@maths.ox.ac.uk>,
>    *	Al Longyear <longyear@netcom.com>,
>    *	Paul Mackerras <Paul.Mackerras@cs.anu.edu.au>
> @@ -54,11 +52,6 @@
>    * this line discipline (or another line discipline that is frame
>    * oriented such as N_PPP).
>    *
> - * The SyncLink driver (synclink.c) implements both asynchronous
> - * (using standard line discipline N_TTY) and synchronous HDLC
> - * (using N_HDLC) communications, with the latter using the above
> - * conventions.

This paragraph actually talks about long removed synclink.c, removed in:
   a1f714b44e34 tty: Remove redundant synclink driver
But OK, let's kick all the remaining traces of synclinks.
thanks,
-- 
js
suse labs

